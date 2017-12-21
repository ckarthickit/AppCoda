//
//  PrimaryContextViewController.m
//  ViewControllerComms
//
//  Created by Karthick C on 30/09/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import "PrimaryContextViewController.h"

@interface PrimaryContextViewController ()

@property (nonatomic,weak) UILabel *contentTitle;
@property (nonatomic,weak) UIButton *dismissButton;
@end

@implementation PrimaryContextViewController

- (void)loadView {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    UINib *primaryContextViewControllerNib = [UINib nibWithNibName:@"PrimaryContextViewController" bundle:nil];
    NSArray<UIView *> *viewHierarchy = [primaryContextViewControllerNib instantiateWithOwner:self options:nil];
    self.view = [viewHierarchy firstObject];
    [self.view setBackgroundColor:[UIColor colorWithRed:255/255 green:255/255 blue:128/255 alpha:0.7]];
    //[self.view setBackgroundColor:[UIColor yellowColor]];
    
    self.contentTitle = [self findViewByRestorationID:@"contentTitle"];
    self.dismissButton = [self findViewByRestorationID:@"dismissButton"];
}

- (id) findViewByRestorationID: (NSString *) restorationID {
    return [PrimaryContextViewController findViewAmong:self.view.subviews byRestorationID:restorationID];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"PrimaryContextViewController title : %@", self.title);
    self.contentTitle.text = self.title;
    [self.dismissButton addTarget:self action:@selector(dismissButtonTouchup:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"presentingViewController = %@", self.presentingViewController);
    NSLog(@"presentedViewController = %@", self.presentedViewController);
    NSLog(@"%s: my root view window = %@",__PRETTY_FUNCTION__, self.view.window);
    NSLog(@"%s: my app window = %@",__PRETTY_FUNCTION__, [UIApplication sharedApplication].keyWindow);
    NSLog(@"%s: my app delegate window = %@",__PRETTY_FUNCTION__, [UIApplication sharedApplication].delegate.window);
}

- (UIModalTransitionStyle)modalTransitionStyle {
    NSLog(@"%s",__PRETTY_FUNCTION__);
    static UIModalTransitionStyle mystyle = 1;
    if(self.view.window == nil) {
        unsigned int trans = arc4random() % 3;
        NSLog(@"changed to %d", trans);
        //return trans;
        NSLog(@"self.window= %@" , self.view.window);
        mystyle = trans;
    }
    return mystyle;
}

- (UIModalPresentationStyle)modalPresentationStyle {
    //return [super modalPresentationStyle];
    return UIModalPresentationOverFullScreen;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma  mark - Programatic Target Action

- (void) dismissButtonTouchup: (UIButton *) sender {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"parentVC= %@", self.parentViewController);
    //NSLog(@"modalVC= %@", self.modalViewController);
    NSLog(@"presentingVC= %@", self.presentingViewController);
#if 0
    [self dismissViewControllerAnimated:YES completion:nil];
#else
    [self.presentingViewController dismissViewControllerAnimated:YES completion: nil];
#endif
}

#pragma mark - Utility Methods

+ (id) findViewAmong: (NSArray<UIView*> *) views byRestorationID: (NSString *) restorationID {
    if([views count] > 0) {
        for(UIView *view in views) {
            if([restorationID isEqualToString:view.restorationIdentifier]) {
                return view;
            }
        }
        for(UIView *view in views) {
            UIView *internalView = [self findViewAmong:view.subviews byRestorationID:restorationID];
            if(internalView != nil) {
                return internalView;
            }
        }
    }
    return nil;
}

@end
