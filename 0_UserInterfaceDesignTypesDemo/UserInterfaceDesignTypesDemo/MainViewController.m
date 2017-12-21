//
//  ViewController.m
//  UserInterfaceDesignTypesDemo
//
//  Created by Karthick C on 14/09/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

- (instancetype)init {
    NSLog(@"%s->%@",__func__,[self class]);
    return [super init];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    NSLog(@"%s->%@",__func__,[self class]);
    return [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"%s->%@",__func__,[self class]);
}

-(void) viewWillAppear:(BOOL)animated {
    NSLog(@"%s->%@",__func__,[self class]);
}

-(void) viewDidAppear:(BOOL)animated {
    NSLog(@"%s->%@",__func__,[self class]);
}

-(void) viewWillLayoutSubviews {
    NSLog(@"%s->%@",__func__,[self class]);
}

-(void) viewDidLayoutSubviews{
    NSLog(@"%s->%@",__func__,[self class]);
}

-(void) viewWillDisappear:(BOOL)animated {
    NSLog(@"%s->%@",__func__,[self class]);
}

-(void) viewDidDisappear:(BOOL)animated {
    NSLog(@"%s->%@",__func__,[self class]);
}
-(void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    NSLog(@"%s->%@",__func__,[self class]);
}


-(void)loadView {
    //NSLog(@"%@: %@ -> %@",[NSThread currentThread], [NSRunLoop currentRunLoop], [NSOperationQueue currentQueue]);
    //NSLog(@"Operations: %@", [[NSOperationQueue currentQueue]operations]);
    NSLog(@"%s->%@",__func__,[self class]);
    [super loadView];
}

//NOTE : This method WON'T BE CALLED FOR THIS APP since we are LOADING the views to view controller  in app Launch itself
-(void) viewDidLoad {
    NSLog(@"%s->%@",__func__,[self class]);
    //UIStackView *view;
}

@end
