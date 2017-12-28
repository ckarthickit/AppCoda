//
//  StoriesDetailViewController.m
//  RSSReader
//
//  Created by Karthick C on 21/12/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import "StoriesDetailViewController.h"

@interface StoriesDetailViewController () <UIWebViewDelegate> {
}
@property (nonatomic,weak) IBOutlet UIWebView *webView;
@property (nonatomic,weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (copy,nonatomic) NSString *url;
@end

@implementation StoriesDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_webView setDelegate:self];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    [_activityIndicator setHidden: YES];
}


-(void)webViewDidStartLoad:(UIWebView *)webView {
    [_activityIndicator setHidden:NO];
    [_activityIndicator setHidesWhenStopped:YES];
    [_activityIndicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [_activityIndicator stopAnimating];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [_activityIndicator stopAnimating];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
