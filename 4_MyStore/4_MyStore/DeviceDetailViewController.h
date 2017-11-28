//
//  DeviceDetailViewController.h
//  4_MyStore
//
//  Created by Karthick C on 27/11/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface DeviceDetailViewController : UIViewController
@property (strong,nonatomic) NSManagedObject *device;
@end
