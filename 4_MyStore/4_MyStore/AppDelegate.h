//
//  AppDelegate.h
//  4_MyStore
//
//  Created by Karthick C on 23/11/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

