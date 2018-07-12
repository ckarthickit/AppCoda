//
//  MyAVURLAsset.h
//  AVPlayerSample
//
//  Created by Karthick C on 12/07/18.
//  Copyright © 2018 Karthick C. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface MyAVURLAsset : AVURLAsset
- (instancetype)initWithURL:(NSURL *)URL options:(NSDictionary<NSString *,id> *)options;
@end
