//
//  CameraControllerViewController.m
//  CameraApp-AVFoundation
//
//  Created by Karthick C on 09/01/18.
//  Copyright © 2018 Karthick C. All rights reserved.
//

#import "CameraController.h"
#include <dispatch/dispatch.h>

#pragma mark -Concurrency Helpers
static dispatch_queue_t background_queue(){
    static dispatch_once_t preapre_queue_guard;
    static dispatch_queue_t background_queue;
    dispatch_once(&preapre_queue_guard, ^{
        background_queue = dispatch_queue_create("CamerVCBackground", DISPATCH_QUEUE_SERIAL);
    });
    return background_queue;
}

static void dispatch_to_background(dispatch_block_t block) {
    dispatch_async(background_queue(),block);
}

static void dispatch_to_main(dispatch_block_t block) {
    dispatch_async(dispatch_get_main_queue(), block);
}

/******************************************************************/

@interface CameraController () <AVCapturePhotoCaptureDelegate> {
    PhotoCaptureCompletionBlock _photoCaptureCompletionBlock;
}

@property (nonatomic) AVCaptureFlashMode captureFlashMode;
//Capture Session related Variables
@property (nonatomic) AVCaptureSession *captureSession;
//Capture Devices
@property (nonatomic,nullable) AVCaptureDevice *frontCamera;
@property (nonatomic,nullable) AVCaptureDevice *rearCamera;

//Capture Device Inputs
@property (nonatomic) CameraPosition cameraPosition;
@property (nonatomic, nullable) AVCaptureDeviceInput *frontCameraInput;
@property (nonatomic, nullable) AVCaptureDeviceInput *rearCameraInput;

//Capture Photo Output
@property (nonatomic,nullable) AVCapturePhotoOutput *photoOutput;

//Video Capture Preview Layer
@property (nonatomic,nullable) AVCaptureVideoPreviewLayer *previewLayer;
@end

@implementation CameraController

#pragma mark -Camera Session

-  (instancetype)init {
    self = [super init];
    _captureFlashMode = AVCaptureFlashModeOff;
    return self;
}

- (void) prepareSession: (CameraControllerCompletionHandler) completionHandler {
    dispatch_to_background(^{
        [self createCaptureSession];
        @try {
            [self configureCaptureDevices];
            [self configureDeviceInputs];
            [self configurePhotoOutput];
        }@catch(NSException *exception) {
            NSLog(@"failure in prepraing %@", exception);
            dispatch_to_main(^{
                completionHandler(exception);
            });
            return;
        }
        dispatch_to_main(^{
            completionHandler(nil);
        });
    });
}

-(void)displayPreviewOn:(UIView *)previewView {
    [self verifyCaptureSessionRunning];
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
    [previewView.layer insertSublayer:self.previewLayer atIndex:0];
    self.previewLayer.frame = previewView.frame;
}

- (void) toggleFlashMode {
    if(self.captureFlashMode == AVCaptureFlashModeOff) {
        self.captureFlashMode = AVCaptureFlashModeOn;
    }else {
        self.captureFlashMode = AVCaptureFlashModeOff;
    }
}

- (void)switchCameras {
    [self.captureSession beginConfiguration];
    if(self.cameraPosition == CameraPositionFront) {
        [self switchToRearCamera];
    }else if(self.cameraPosition == CameraPositionRear) {
        [self switchToFrontCamera];
    }
    [self.captureSession commitConfiguration];
}

- (void) captureImage : (PhotoCaptureCompletionBlock) completion{
    [self verifyCaptureSessionRunning];
    AVCapturePhotoSettings *capturePhotoSettings = [[AVCapturePhotoSettings alloc] init];
    capturePhotoSettings.flashMode = self.captureFlashMode;
    [self.photoOutput capturePhotoWithSettings:capturePhotoSettings delegate:self];
    self->_photoCaptureCompletionBlock = completion;
}

#pragma mark - AVCapturePhotoCaptureDelegate

- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(NSError *)error {
    NSData *outputData = [photo fileDataRepresentation];
    if(outputData != nil) {
        UIImage *image = [UIImage imageWithData:outputData];
         __weak typeof(self) weakSelf = self;
        dispatch_to_main(^{
            CameraController *controller = weakSelf;
            controller->_photoCaptureCompletionBlock(image,nil);
        });
    }else {
        if(error == nil) {
            NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:-1 userInfo:nil];
           __weak typeof(self) weakSelf = self;
            dispatch_to_main(^{
                CameraController *controller = weakSelf;
                controller->_photoCaptureCompletionBlock(nil,error);
            });
        }
    }
}

#pragma mark - Private Functions

- (void) createCaptureSession {
    self.captureSession = [[AVCaptureSession alloc] init];
}

- (void) verifyCaptureSessionRunning {
    if(![self.captureSession isRunning]) {
        @throw [NSException exceptionWithName:CameraControllerCaptureSessionMissing reason:nil userInfo:nil];
    }
}

- (void) configureCaptureDevices {
    AVCaptureDeviceDiscoverySession *discoverySession = [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInWideAngleCamera] mediaType: AVMediaTypeVideo position:AVCaptureDevicePositionUnspecified];
    if(discoverySession == nil) {
        @throw [[NSException alloc] initWithName:CameraControllerCaptureSessionMissing reason:@"Couldn't create session" userInfo:nil];
    }
    for(AVCaptureDevice *device in discoverySession.devices) {
        if(device.position == AVCaptureDevicePositionFront) {
            self.frontCamera = device;
        }
        if(device.position == AVCaptureDevicePositionBack) {
            self.rearCamera = device;
            if([self.rearCamera lockForConfiguration:nil] == YES) {
                self.rearCamera.focusMode = AVCaptureFocusModeContinuousAutoFocus;
                [self.rearCamera unlockForConfiguration];
            }
        }
    }
}

- (void) configureDeviceInputs {
    self.cameraPosition = CameraPositionUnknown;
    if(self.captureSession == nil) {
        @throw [NSException exceptionWithName:CameraControllerCaptureSessionMissing reason:@"Capture session missing" userInfo:nil];
    }
    NSError *inputError;
    AVCaptureDeviceInput *deviceInput;
    if(self.rearCamera != nil) {
        deviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:self.rearCamera error:&inputError];
        if(inputError == nil) {
            self.rearCameraInput = deviceInput;
            if(self.rearCameraInput != nil) {
                if([self.captureSession canAddInput:deviceInput]) {
                    [self.captureSession addInput:deviceInput];
                    self.cameraPosition = CameraPositionRear;
                }
            }
        }else {
            NSLog(@"rearCamera input error = %@",inputError);
        }
    }
    if(self.frontCamera != nil) {
        deviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:self.frontCamera error:&inputError];
        if(inputError == nil) {
            self.frontCameraInput = deviceInput;
            if(self.cameraPosition == CameraPositionUnknown) {
                if([self.captureSession canAddInput:deviceInput]) {
                    [self.captureSession addInput:deviceInput];
                    self.cameraPosition = CameraPositionFront;
                }
            }
        }else {
            NSLog(@"fontCamera input error = %@",inputError);
        }
    }
    if(self.cameraPosition == CameraPositionUnknown) {
        @throw [NSException exceptionWithName:CameraControllerNoCamerasAvailable reason:@"Cannot Configure device inputs" userInfo:nil];
    }
}

- (void) configurePhotoOutput {
    if(self.captureSession == nil) {
        @throw [NSException exceptionWithName:CameraControllerCaptureSessionMissing reason:@"Capture session missing while configuring photo output" userInfo:nil];
    }
    self.photoOutput = [[AVCapturePhotoOutput alloc] init];
    [self.photoOutput setPreparedPhotoSettingsArray:@[[AVCapturePhotoSettings photoSettingsWithFormat:@{AVVideoCodecKey:AVVideoCodecTypeJPEG}] ] completionHandler:nil];
    if([self.captureSession canAddOutput:self.photoOutput]) {
        [self.captureSession addOutput:self.photoOutput];
    }
    [self.captureSession startRunning];
}

- (void) switchToFrontCamera {
    [self verifyCaptureSessionRunning];
    NSArray <AVCaptureInput*> *captureSessionInputs = self.captureSession.inputs;
    if([captureSessionInputs containsObject:self.rearCameraInput]) {
        [self.captureSession removeInput:self.rearCameraInput];
    }
    if([self.captureSession canAddInput:self.frontCameraInput]) {
        [self.captureSession addInput:self.frontCameraInput];
        self.cameraPosition = CameraPositionFront;
        return;
    }
    @throw [NSException exceptionWithName:CameraControllerInvalidOperation reason:@"Couldn't switch to Front camera" userInfo:nil];
}


- (void) switchToRearCamera {
    [self verifyCaptureSessionRunning];
    NSArray <AVCaptureInput*> *captureSessionInputs = self.captureSession.inputs;
    if([captureSessionInputs containsObject:self.frontCameraInput]) {
        [self.captureSession removeInput:self.frontCameraInput];
    }
    if([self.captureSession canAddInput:self.rearCameraInput]) {
        [self.captureSession addInput:self.rearCameraInput];
        self.cameraPosition = CameraPositionRear;
        return;
    }
    @throw [NSException exceptionWithName:CameraControllerInvalidOperation reason:@"Couldn't switch to Rear camera" userInfo:nil];
}

@end
