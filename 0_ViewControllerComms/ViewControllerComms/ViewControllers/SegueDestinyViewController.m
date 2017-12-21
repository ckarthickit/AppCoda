//
//  SegueDestinyViewController.m
//  ViewControllerComms
//
//  Created by Karthick C on 01/10/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import "SegueDestinyViewController.h"

@interface SegueDestinyViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation SegueDestinyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = self.title;
    // Do any additional setup after loading the view.
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
- (IBAction)dismissSegueTouchUp:(UIButton *)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
