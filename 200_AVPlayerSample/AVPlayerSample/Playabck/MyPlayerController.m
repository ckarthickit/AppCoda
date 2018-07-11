//
//  MyPlayerController.m
//  AVPlayerSample
//
//  Created by Karthick C on 14/05/18.
//  Copyright © 2018 Karthick C. All rights reserved.
//


#import "MyPlayerController.h"
static NSString * const kMyPlayerPlaybackStatus = @"status";
static NSString * const kMyPlayerPlaybackRate = @"rate";
static NSString * const kMyPlayerPlaybackTimeControlStatus = @"timeControlStatus";

static NSString * const kMyPlayerItemPlaybackStatus = @"status";
static NSString * const kMyPlayerItemPlaybackDuration = @"duration";
static NSString * const kMyPlayerItemPlaybackTracks = @"tracks";
static NSString * const kMyPlayerItemPlaybackBufferEmpty = @"playbackBufferEmpty";
static NSString * const kMyPlayerItemPlaybackBufferFull = @"playbackBufferFull";
static NSString * const kMyPlayerItemPlaybackLikelyToKeepUp = @"playbackLikelyToKeepUp";
static NSString * const kMyPlayerItemPlaybackLoadedTimeRanges = @"loadedTimeRanges";
static NSString * const kMyPlayerItemPlaybackTimeMetadata = @"timedMetadata";

static NSString * kMyPlayerContext = @"com_kar_ios_MyPlayerContext";
static NSString * kMyPlayerItemContext = @"com_kar_ios_MyPlayerItemContext";

@implementation MyPlayerController{
    AVPlayer *_player;
    AVPlayerItem *_playerItem;
    AVPlayerLayer *_playlayer;
    BOOL _isPlayerObserversRegistered;
    BOOL _isPrepared;
    BOOL _isPlaying;
}


+ (void) setAudioCategoryAsPlayback {
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
}

- (instancetype)init {
    if(self = [super init]) {
        _isPlayerObserversRegistered = NO;
    }
    return self;
}

-(AVPlayer *) player {
    if(_player == nil) {
        _player = [[AVPlayer alloc] init];
        //Configure Actions
        _player.actionAtItemEnd = AVPlayerActionAtItemEndPause;
    }
    return _player;
}

- (void)setLayer:(AVPlayerLayer *)layer {
    if(_playlayer == layer) {
        return;
    }
    if(_playlayer != nil) {
        [_playlayer setPlayer: nil];
        _playlayer = nil;
    }
    _playlayer = layer;
    [self setupLayer];
}

- (void) setPlayerItem:(AVPlayerItem *) playerItem {
    if(_playerItem != nil) {
        //Unregister KVOs
        [_playerItem removeObserver:self forKeyPath:kMyPlayerPlaybackStatus context:&kMyPlayerItemContext];
        [_playerItem removeObserver:self forKeyPath:kMyPlayerItemPlaybackDuration context:&kMyPlayerItemContext];
        [_playerItem removeObserver:self forKeyPath:kMyPlayerItemPlaybackTracks context:&kMyPlayerItemContext];
        [_playerItem removeObserver:self forKeyPath:kMyPlayerItemPlaybackBufferEmpty context:&kMyPlayerItemContext];
        [_playerItem removeObserver:self forKeyPath:kMyPlayerItemPlaybackBufferFull context:&kMyPlayerItemContext];
        [_playerItem removeObserver:self forKeyPath:kMyPlayerItemPlaybackLikelyToKeepUp context:&kMyPlayerItemContext];
        [_playerItem removeObserver:self forKeyPath:kMyPlayerItemPlaybackLoadedTimeRanges context:&kMyPlayerItemContext];
        [_playerItem removeObserver:self forKeyPath:kMyPlayerItemPlaybackTimeMetadata context:&kMyPlayerItemContext];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemFailedToPlayToEndTimeNotification object:_playerItem];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:_playerItem];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemPlaybackStalledNotification object:_playerItem];
        _playerItem = nil;
    }
    _playerItem = playerItem;
    if(_playerItem != nil) {
        //Register KVOs
         NSKeyValueObservingOptions options = (NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew);
        [_playerItem addObserver:self forKeyPath:kMyPlayerPlaybackStatus options:options context:&kMyPlayerItemContext];
        [_playerItem addObserver:self forKeyPath:kMyPlayerItemPlaybackDuration options:options context:&kMyPlayerItemContext];
        [_playerItem addObserver:self forKeyPath:kMyPlayerItemPlaybackTracks options:options context:&kMyPlayerItemContext];
        [_playerItem addObserver:self forKeyPath:kMyPlayerItemPlaybackBufferEmpty options:options context:&kMyPlayerItemContext];
        [_playerItem addObserver:self forKeyPath:kMyPlayerItemPlaybackBufferFull options:options context:&kMyPlayerItemContext];
        [_playerItem addObserver:self forKeyPath:kMyPlayerItemPlaybackLikelyToKeepUp options:options context:&kMyPlayerItemContext];
        [_playerItem addObserver:self forKeyPath:kMyPlayerItemPlaybackLoadedTimeRanges options:options context:&kMyPlayerItemContext];
        [_playerItem addObserver:self forKeyPath:kMyPlayerItemPlaybackTimeMetadata options:options context:&kMyPlayerItemContext];
        
        //Observer for Notification Center
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyPlayerItemFailedToEnd:) name:AVPlayerItemFailedToPlayToEndTimeNotification object:_playerItem];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyPlayerItemDidReachend:) name:AVPlayerItemDidPlayToEndTimeNotification object:_playerItem];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyPlayerItemStalled:) name:AVPlayerItemPlaybackStalledNotification object:_playerItem];
    }
}

-(void) setupLayer {
    if(_playlayer != nil && _player != nil) {
        [_playlayer setPlayer:_player];
    }
}

-(void) setupObservers {
    
     NSKeyValueObservingOptions options = (NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew);
    if(_isPlayerObserversRegistered == NO) {
        NSLog(@"%s registering", __PRETTY_FUNCTION__);
        //Observe Properties of AVPlayer object
        [[self player] addObserver:self forKeyPath:kMyPlayerPlaybackStatus options:options context:&kMyPlayerContext];
        [[self player] addObserver:self forKeyPath:kMyPlayerPlaybackRate options:options context:&kMyPlayerContext];
        [[self player] addObserver:self forKeyPath:kMyPlayerPlaybackTimeControlStatus options:options context:&kMyPlayerContext];
        _isPlayerObserversRegistered = YES;
    }
    
}

-(void) dismantleObservers {
    if(_isPlayerObserversRegistered == YES)  {
        //Unregister Observers
        NSLog(@"%s unregistering", __PRETTY_FUNCTION__);
        [[self player] removeObserver:self forKeyPath:kMyPlayerPlaybackStatus context:&kMyPlayerContext];
        [[self player] removeObserver:self forKeyPath:kMyPlayerPlaybackRate context:&kMyPlayerContext];
        [[self player] removeObserver:self forKeyPath:kMyPlayerPlaybackTimeControlStatus context:&kMyPlayerContext];
    }
}

- (void)playURL:(NSURL *) url{
    //create AVPlayerItem
    [self setPlayerItem:[AVPlayerItem playerItemWithAsset:[AVAsset assetWithURL:url]]];
    //register KVO's
    [self setupObservers];
    //Assocaite Layer with Player
    [self setupLayer];
    self->_isPrepared = NO;
    [[self player] replaceCurrentItemWithPlayerItem:_playerItem];
}

-(BOOL) isPlaying {
    return self->_isPlaying;
}
-(void) play {
    [[self player] play];
}
-(void) pause {
    [[self player] pause];
}

- (void) shutdown {
    [self setLayer: nil];
    if(_player != nil) {
        [_player replaceCurrentItemWithPlayerItem: nil];
        [self dismantleObservers];
        [self setPlayerItem:nil];
        _player = nil;
    }
}

# pragma mark Player Callback

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if(context == (&kMyPlayerContext)) {
        NSLog(@"%s: player-keypath=%@, change=[%@]",__PRETTY_FUNCTION__, keyPath, change);
        if([keyPath isEqualToString:kMyPlayerPlaybackStatus]) {
            [self evaluatePlayerStatus];
        }
    }else if(context == (&kMyPlayerItemContext)) {
        NSLog(@"%s: playerItem-keypath=%@, change=[%@]",__PRETTY_FUNCTION__, keyPath, change);
        if([keyPath isEqualToString:kMyPlayerItemPlaybackDuration]) {
            NSKeyValueChange changeKind = [[change valueForKey:NSKeyValueChangeKindKey] integerValue];
            if(changeKind == NSKeyValueChangeSetting) {
                NSValue *value= [change valueForKey:NSKeyValueChangeNewKey];
                CMTime time = [value CMTimeValue];
                NSLog(@"duration_from_change = %lld scale=%d", time.value, time.timescale);
                NSLog(@"duration_from_player = %lld scale=%d", [[[self player] currentItem] duration].value,[[[self player] currentItem] duration].timescale);
            }
        }
    }
}

-(void) notifyPlayerItemDidReachend: (NSNotification *) notification {
    NSLog(@"%s notification_info=%@", __PRETTY_FUNCTION__, notification.userInfo);
}

-(void) notifyPlayerItemStalled: (NSNotification *) notification {
    NSLog(@"%s notification_info=%@", __PRETTY_FUNCTION__, notification.userInfo);
}

-(void) notifyPlayerItemFailedToEnd: (NSNotification *) notification {
    NSLog(@"%s notification_info=%@", __PRETTY_FUNCTION__, notification.userInfo);
}

#pragma mark Internal Handlers
-(void) evaluatePlayerStatus {
    if(self.player.status == AVPlayerStatusReadyToPlay) {
        NSLog(@"Gonna Play %@",[_player currentItem]);
        self->_isPrepared = YES;
        [self.player play];
        self->_isPlaying = YES;
    }
}
@end
