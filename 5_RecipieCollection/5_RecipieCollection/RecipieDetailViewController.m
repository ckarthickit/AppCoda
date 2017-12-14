//
//  RecipieDetailViewController.m
//  5_RecipieCollection
//
//  Created by Karthick C on 14/12/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import "RecipieDetailViewController.h"

@interface RecipieDetailViewController ()
@property (nonatomic,weak) IBOutlet UINavigationBar *navBar;
@property (nonatomic,weak) IBOutlet UIImageView *recipieImage;
@end

@implementation RecipieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(self.recipie) {
        self.navBar.topItem.title = self.recipie.name;
        self.recipieImage.image = [UIImage imageNamed:self.recipie.thumbnail];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions

-(IBAction) closeViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
