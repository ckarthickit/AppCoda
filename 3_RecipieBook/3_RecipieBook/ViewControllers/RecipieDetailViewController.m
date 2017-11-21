//
//  RecipieDetailViewController.m
//  3_RecipieBook
//
//  Created by Karthick C on 21/11/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import "RecipieDetailViewController.h"

@interface RecipieDetailViewController ()
@property (nonatomic,weak) IBOutlet UILabel *recipieDescriptionLabel;
@end

@implementation RecipieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if([self recipieDescription]) {
        self.recipieDescriptionLabel.text = [NSString stringWithFormat:@"Selected Recipie: %@",self.recipieDescription];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"destn: %@", [segue destinationViewController]);
}

@end
