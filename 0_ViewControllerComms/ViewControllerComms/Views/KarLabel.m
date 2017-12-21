//
//  KarLabel.m
//  ViewControllerComms
//
//  Created by Karthick C on 04/10/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import "KarLabel.h"

@implementation KarLabel

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

//
//  KarButton.m
//  ViewControllerComms
//
//  Created by Karthick C on 03/10/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

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
    [self setBackgroundColor:[UIColor greenColor]];
}

@end
