//
//  MyPlayerView.h
//  AVPlayerSample
//
//  Created by Karthick C on 14/05/18.
//  Copyright © 2018 Karthick C. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@interface MyPlayerView : UIView
@property (weak, readonly) AVPlayerLayer *playerLayer;
@end
