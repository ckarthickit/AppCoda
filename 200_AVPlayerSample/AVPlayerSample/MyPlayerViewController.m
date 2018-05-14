//
//  ViewController.m
//  AVPlayerSample
//
//  Created by Karthick C on 14/05/18.
//  Copyright © 2018 Karthick C. All rights reserved.
//
#import "MyPlayerViewController.h"
#import "MyPlayerView.h"
#import "MyPlayerController.h"

@interface MyPlayerViewController ()
@property (weak, nonatomic) IBOutlet MyPlayerView *playerView;
@property (weak, nonatomic) IBOutlet UITextField *playerURL;
@end

@implementation MyPlayerViewController {
    MyPlayerController *_playerController;
}

- (MyPlayerController *) playerController {
    if(_playerController == nil) {
        _playerController = [[MyPlayerController alloc] init];
    }
    return _playerController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playContent:(UIButton *)playButton {
    if([[self playerController] isPlaying] == NO) {
        NSString *playerURLString = [self.playerURL text];
        NSURL *url = [NSURL URLWithString:playerURLString];
        NSLog(@"playing URL = %@", [url absoluteString]);
        [[self playerController] setLayer:[_playerView playerLayer]];
        [[self playerController] playURL:url];
    }else {
        [[self playerController] play];
    }
}

- (IBAction)pauseContent:(UIButton *)sender {
    [[self playerController] pause];
}


- (IBAction)stopContent:(UIButton *)stopButton {
    [[self playerController] shutdown];
    _playerController = nil;
}

@end
