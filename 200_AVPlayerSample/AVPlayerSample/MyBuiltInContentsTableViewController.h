//
//  MyBuiltInContentsTableViewController.h
//  AVPlayerSample
//
//  Created by Karthick C on 11/07/18.
//  Copyright © 2018 Karthick C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuiltInContentSelectionDelegate.h"
@interface MyBuiltInContentsTableViewController : UITableViewController
@property (nonatomic) id<BuiltInContentSelectionDelegate> builtInContentSelectionDelegate;
@end
