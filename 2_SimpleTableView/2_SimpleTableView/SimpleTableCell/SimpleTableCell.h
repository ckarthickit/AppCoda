//
//  SimpleTableCell.h
//  2_SimpleTableView
//
//  Created by Karthick C on 19/11/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleTableCell : UITableViewCell
#define SIMPLE_TABLE_CELL_HEIGHT  78
@property (nonatomic,weak) IBOutlet UILabel *nameLabel;
@property (nonatomic,weak) IBOutlet UILabel *prepTimeLabel;
@property (nonatomic,weak) IBOutlet UIImageView *thumnailImageView;

@end
