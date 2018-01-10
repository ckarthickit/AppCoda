//
//  CameraControllerViewController.h
//  CameraApp-AVFoundation
//
//  Created by Karthick C on 09/01/18.
//  Copyright © 2018 Karthick C. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

static NSString *const CameraControllerCaptureSessionAlreadyRunning = @"CAPTURE_SESSION_ALREADY_RUNNING";
static NSString *const CameraControllerCaptureSessionMissing = @"CAPTURE_SESSION_MISSING";
static NSString *const CameraControllerInvalidInputs = @"INVALID_INPUTS";
static NSString *const CameraControllerInvalidOperation = @"INVALID_OPERATION";
static NSString *const CameraControllerNoCamerasAvailable = @"NO_CAMERAS_AVAILABLE";
static NSString *const CameraControllerUnknown = @"UNKNOWN";

typedef NS_ENUM(unsigned short,CameraPosition){
    CameraPositionUnknown,
    CameraPositionFront,
    CameraPositionRear
};

typedef void (^CameraControllerCompletionHandler) (NSException *exception);
typedef void (^PhotoCaptureCompletionBlock) (UIImage *image, NSError *error);

@interface CameraController : NSObject
@property (nonatomic, readonly) CameraPosition cameraPosition;
@property (nonatomic, readonly) AVCaptureFlashMode captureFlashMode;
- (void) prepareSession: (CameraControllerCompletionHandler) completionHandler;
- (void) displayPreviewOn : (UIView *) previewView;
- (void) switchCameras;
- (void) toggleFlashMode;
- (void) captureImage : (PhotoCaptureCompletionBlock) completion;
@end
