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
    CAMERA_POSITION_UNKNOWN,
    CAMERA_POSITION_FRONT,
    CAMERA_POSITION_REAR
};

typedef void (^CameraControllerCompletionHandler) (NSException *exception);

@interface CameraController : NSObject
- (void) prepareSession: (CameraControllerCompletionHandler) completionHandler;
- (void) displayPreviewOn : (UIView *) previewView;
@end
