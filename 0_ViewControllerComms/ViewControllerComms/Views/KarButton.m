//
//  KarButton.m
//  ViewControllerComms
//
//  Created by Karthick C on 03/10/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import "KarButton.h"

@implementation KarButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return [super init];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSLog(@"%s, %@", __PRETTY_FUNCTION__, aDecoder);
    NSLog(@"%@", [NSThread callStackSymbols]);
    return [super initWithCoder:aDecoder];
}

- (instancetype)initWithFrame:(CGRect)frame {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return [super initWithFrame:frame];
}

-(void)awakeFromNib {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"%@",[NSThread callStackSymbols]);
    [super awakeFromNib];
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    NSLog(@"%s target= %@, action=%@, events=%d",__PRETTY_FUNCTION__, target, NSStringFromSelector(action),(unsigned int) controlEvents);
    NSLog(@"%@", [NSThread callStackSymbols]);
    [super addTarget:target action:action forControlEvents:controlEvents];
}

@end
