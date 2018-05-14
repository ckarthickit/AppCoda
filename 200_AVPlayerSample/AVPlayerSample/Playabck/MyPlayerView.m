//
//  MyPlayerView.m
//  AVPlayerSample
//
//  Created by Karthick C on 14/05/18.
//  Copyright © 2018 Karthick C. All rights reserved.
//


#import "MyPlayerView.h"

@interface MyPlayerView(){
    //TODO : Add internal variables here
}
//TODO : Add internal Properties here
@end

@implementation MyPlayerView

+ (Class) layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayerLayer *)  playerLayer{
    return ((AVPlayerLayer *)[self layer]);
}

@end
