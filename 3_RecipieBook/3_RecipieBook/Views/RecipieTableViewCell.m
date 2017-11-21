//
//  RecipieTableViewCell.m
//  3_RecipieBook
//
//  Created by Karthick C on 20/11/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import "RecipieTableViewCell.h"

@implementation RecipieTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    static BOOL isFirst = YES;
//    if(isFirst) {
//        NSLog(@"%@", [NSThread callStackSymbols]);
//        isFirst = NO;
//    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
