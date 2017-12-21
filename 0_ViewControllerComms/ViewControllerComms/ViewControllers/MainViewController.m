//
//  ViewController.m
//  ViewControllerComms
//
//  Created by Karthick C on 26/09/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import "MainViewController.h"
#import "PrimaryContextViewController.h"

#define PROGRAMATTIC_SEGUE_ID "programatic_segue"
@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIButton *showVCButton;

@end

@implementation MainViewController

- (void)loadView {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    //NSLog(@"%@", [NSThread callStackSymbols]);
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s",__PRETTY_FUNCTION__);
    NSLog(@"================");
    [self.showVCButton addTarget:self action:@selector(showPrimaryContextViewController:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

-(void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%s",__PRETTY_FUNCTION__);
    NSLog(@"%s: my root view window = %@",__PRETTY_FUNCTION__, self.view.window);
    NSLog(@"%s: my app window = %@",__PRETTY_FUNCTION__, [UIApplication sharedApplication].keyWindow);
    NSLog(@"%s: my app delegate window = %@",__PRETTY_FUNCTION__, [UIApplication sharedApplication].delegate.window);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

-(void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"%s",__PRETTY_FUNCTION__);
    NSLog(@"presentingViewController = %@", self.presentingViewController);
    NSLog(@"presentedViewController = %@", self.presentedViewController);
    NSLog(@"%s: my root view window = %@",__PRETTY_FUNCTION__, self.view.window);
    NSLog(@"%s: my app window = %@",__PRETTY_FUNCTION__, [UIApplication sharedApplication].keyWindow);
    NSLog(@"%s: my app delegate window = %@",__PRETTY_FUNCTION__, [UIApplication sharedApplication].delegate.window);
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

-(void) viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    NSLog(@"%s",__PRETTY_FUNCTION__);
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"%s",__PRETTY_FUNCTION__);
    // Dispose of any resources that can be recreated.
}

- (void)addChildViewController:(UIViewController *)childController {
    NSLog(@"%s -> %@", __PRETTY_FUNCTION__, childController);
    [super addChildViewController:childController];
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [super dismissViewControllerAnimated:flag completion:completion];
}

//READ DOC FOR THIS
- (UIViewController *)targetViewControllerForAction:(SEL)action sender:(id)sender {
    NSLog(@"%s %@",__PRETTY_FUNCTION__, NSStringFromSelector(action));
    UIViewController *targetViewController = [super targetViewControllerForAction:action sender:sender];
    //NSLog(@"%@", [NSThread callStackSymbols]);
    NSLog(@"targetVC = %@", targetViewController);
    return nil;
}

//-(UIModalPresentationStyle)modalPresentationStyle {
//    return UIModalPresentationNone ;
//}

-(void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    NSLog(@"%s: viewControllerToPresent= %@",__PRETTY_FUNCTION__, viewControllerToPresent);
    NSLog(@"%@", [NSThread callStackSymbols]);
    return [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return [super performSegueWithIdentifier:identifier sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"segue is %@, id=%@", segue, segue.identifier);
    if([segue.identifier isEqualToString: NSStringFromClass([segue.destinationViewController class])]) {
        NSLog(@"Transistion to %@", segue.identifier);
        segue.destinationViewController.title = @"XIB Segue";
    }else if([segue.identifier isEqualToString:@PROGRAMATTIC_SEGUE_ID]) {
        segue.destinationViewController.title = @"Programattic Segue";
    }
}


#pragma mark Programmatic IBActions

- (void) showPrimaryContextViewController : (UIButton *) sender {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    UIViewController *primaryContextVC = [[PrimaryContextViewController alloc] init];
    primaryContextVC.title = @"Primary Context";
    [super showViewController:primaryContextVC sender:sender];
}

- (IBAction)showDetailViewControllerButtonTouchUp:(UIButton *)sender {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    UIViewController *primaryDetailContextVC = [[PrimaryContextViewController alloc] init];
    primaryDetailContextVC.title = @"Primary Detail Context";
    [self showDetailViewController:primaryDetailContextVC sender:sender];
}

- (IBAction)presentViewController:(UIButton *)sender {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    UIViewController *seondaryContextVC = [[PrimaryContextViewController alloc] init];
    seondaryContextVC.title = @"Secondary Context";
    [self presentViewController:seondaryContextVC animated:YES completion:nil];
}
- (IBAction)programatticSegueTouchUp:(UIButton *)sender {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    __weak MainViewController *weakSelf = self;
    __block UIStoryboardSegue *segue = [UIStoryboardSegue segueWithIdentifier:@PROGRAMATTIC_SEGUE_ID source:self destination:[[PrimaryContextViewController alloc]init] performHandler:^void(void){
        NSLog(@"perform_segue");
        NSLog(@"%@", [NSThread callStackSymbols]);
        MainViewController *strongSelf = weakSelf;
        [strongSelf prepareForSegue:segue sender:nil];
        [segue.sourceViewController presentViewController:segue.destinationViewController animated:YES completion:nil];
    }];
    [segue perform];
    //we can optionally call prepareForSegue ourself if needed
}

- (IBAction)dismissViewController:(UIButton *)sender {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
