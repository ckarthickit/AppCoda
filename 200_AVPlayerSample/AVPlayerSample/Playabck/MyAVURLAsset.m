//
//  MyAVURLAsset.m
//  AVPlayerSample
//
//  Created by Karthick C on 12/07/18.
//  Copyright © 2018 Karthick C. All rights reserved.
//

#import "MyAVURLAsset.h"
@interface MyAVURLAsset()<AVAssetResourceLoaderDelegate>
@end

@implementation MyAVURLAsset{
    dispatch_queue_t _backgroundQueue;
}

- (instancetype)initWithURL:(NSURL *)URL options:(NSDictionary<NSString *,id> *)options {
    if(self = [super initWithURL:URL options:options]) {
        _backgroundQueue = dispatch_queue_create("com.kar.ios.avassetloader", NULL);
        [self.resourceLoader setDelegate:self queue:_backgroundQueue];
    }
    return self;
}

- (BOOL)isPlayable {
    return [super isPlayable];
}

-(CMTime)duration {
    return [super duration];
}

- (void)loadValuesAsynchronouslyForKeys:(NSArray<NSString *> *)keys completionHandler:(void (^)(void))handler {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return [super loadValuesAsynchronouslyForKeys:keys completionHandler:handler];
}

- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return [super addObserver:observer forKeyPath:keyPath options:options context:context];
}

#pragma  mark - AVAssetResourceLoaderDelegate

-(BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForLoadingOfRequestedResource:(AVAssetResourceLoadingRequest *)loadingRequest {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return NO;
}

@end
