//
//  RecipieDetailViewController.m
//  3_RecipieBook
//
//  Created by Karthick C on 21/11/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import "RecipieDetailViewController.h"

@interface RecipieDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *ingredientsTextView;
@property (weak, nonatomic) IBOutlet UILabel *prepTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *recipieImage;
@end

@implementation RecipieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(self.recipie) {
        self.title = self.recipie.name;
        self.ingredientsTextView.text = [RecipieDetailViewController ingredientsDescription:_recipie];
        self.prepTimeLabel.text = self.recipie.prepTime;
        self.recipieImage.image = [UIImage imageNamed:self.recipie.imageFile];
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

+ (NSString *) ingredientsDescription: (Recipie *) recipie {
    NSMutableString *ingredients = [[NSMutableString alloc]init];
    for(NSString *ingredient in recipie.ingredients) {
        [ingredients appendString: ingredient];
        [ingredients appendString:@"\n"];
    }
    return [ingredients description];
}

@end
