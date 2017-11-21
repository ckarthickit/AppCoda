//
//  AboutViewController.m
//  3_RecipieBook
//
//  Created by Karthick C on 21/11/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import "AboutViewController.h"
@interface AboutViewController ()
@property (nonatomic,weak) IBOutlet UIWebView *webView;
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *aboutHTMLResourcePath = [[NSBundle mainBundle] pathForResource:@"about" ofType:@"html"];
    NSLog(@"aboutHTMLResourcePath: %@", aboutHTMLResourcePath);
    NSURL *aboutURL = [NSURL fileURLWithPath:aboutHTMLResourcePath];
    NSURLRequest *aboutURLReq = [NSURLRequest requestWithURL:aboutURL];
    [self.webView loadRequest:aboutURLReq];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
