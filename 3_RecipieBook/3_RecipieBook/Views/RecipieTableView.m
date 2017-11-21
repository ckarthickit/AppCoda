//
//  RecipieTableView.m
//  3_RecipieBook
//
//  Created by Karthick C on 20/11/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import "RecipieTableView.h"
#import "UIKit/UIKit.h"
@implementation RecipieTableView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    return self;
}

-(void)registerNib:(UINib *)nib forCellReuseIdentifier:(NSString *)identifier {
     //NSLog(@"%s: %@->%@",__PRETTY_FUNCTION__,nib,identifier);
    [super registerNib:nib forCellReuseIdentifier:identifier];
}
- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier {
    //NSLog(@"%s: %@->%@",__PRETTY_FUNCTION__,cellClass,identifier);
    [super registerClass:cellClass forCellReuseIdentifier:identifier];
}

- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier {
    return [super dequeueReusableCellWithIdentifier:identifier];
}

- (void)insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    //NSLog(@"%s", __PRETTY_FUNCTION__);
    [super insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

@end
