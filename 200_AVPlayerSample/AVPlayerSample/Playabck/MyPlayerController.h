//
//  MyPlayerController.h
//  AVPlayerSample
//
//  Created by Karthick C on 14/05/18.
//  Copyright © 2018 Karthick C. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

@interface MyPlayerController : NSObject

- (void) setLayer: (AVPlayerLayer *) layer;
- (void) playURL: (NSURL *) url;
- (BOOL) isPlaying;
- (void) play;
- (void) pause;
- (void) shutdown;
@end
