//
//  ViewController.m
//  AVPlayerSample
//
//  Created by Karthick C on 14/05/18.
//  Copyright © 2018 Karthick C. All rights reserved.
//
#import <AFNetworking/AFNetworking.h>
#import "MyPlayerViewController.h"
#import "MyPlayerView.h"
#import "MyPlayerController.h"
#import "BuiltInContentSelectionDelegate.h"
#import "BuiltInContent.h"

@interface MyPlayerViewController ()<UITextFieldDelegate,BuiltInContentSelectionDelegate>
@property (weak, nonatomic) IBOutlet MyPlayerView *playerView;
@property (weak, nonatomic) IBOutlet UITextField *playerURLView;
@property (nonatomic) BuiltInContent *selectedBuiltInContent;
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
    self.playerURLView.delegate = self;
    NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:defaultConfig];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playContent:(UIButton *)playButton {
    if([[self playerController] isPlaying] == NO) {
        NSString *playerURLString = [self.playerURLView text];
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

#pragma mark TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.playerURLView) {
        return [textField resignFirstResponder];
    }else {
        return NO;
    }
}

#pragma mark - BuiltInContentSelectionDelegate

- (void)didSelectBuiltInItem:(BuiltInContent *)content {
    self.selectedBuiltInContent = content;
    self.playerURLView.text = self.selectedBuiltInContent.contentURL;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"builtInContentList"]) {
        [segue.destinationViewController setValue:self forKey:@"builtInContentSelectionDelegate"];
    }
}

@end
