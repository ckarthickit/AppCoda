//
//  main.m
//  UserInterfaceDesignTypesDemo
//
//  Created by Karthick C on 14/09/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UserInterfaceApp.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSLog(@"%s",__func__);
        //NSLog(@"%@: %@ -> %@",[NSThread currentThread], [NSRunLoop currentRunLoop], [NSOperationQueue currentQueue]);
        //NSLog(@"Operations: %@", [[NSOperationQueue currentQueue]operations]);
        return UIApplicationMain(argc, argv, NSStringFromClass([UserInterfaceApp class]), NSStringFromClass([AppDelegate class]));
    }
}
