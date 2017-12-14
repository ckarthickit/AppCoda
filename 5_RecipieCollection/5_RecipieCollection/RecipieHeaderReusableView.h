//
//  RecipieHeaderViewCollectionReusableView.h
//  5_RecipieCollection
//
//  Created by Karthick C on 14/12/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipieHeaderReusableView : UICollectionReusableView
@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UIImageView *background;
@end
