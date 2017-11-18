//
//  ViewController.m
//  1_Hello
//
//  Created by Karthick C on 18/11/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTouchHelloWorldButton:(UIButton *)sender {
#if 0
    UIAlertView *helloAlertView = [[UIAlertView alloc] initWithTitle:@"My First App" message:@"Hello World!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [helloAlertView show];
#else
    UIAlertController *helloAllerController = [UIAlertController alertControllerWithTitle:@"My First App" message:@"Hello World !" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *helloAlertOKAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^void(UIAlertAction *action) {}];
    [helloAllerController addAction:helloAlertOKAction];
    [self presentViewController:helloAllerController animated:YES completion:^void(void){}];
#endif
}

@end
