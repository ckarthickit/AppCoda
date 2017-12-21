//
//  AppDelegate.m
//  UserInterfaceDesignTypesDemo
//
//  Created by Karthick C on 14/09/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

#define ENABLE_VIEW_CREATION_PROGRAMATTIC 0
#define ENABLE_VIEW_CREATION_WITH_NIB 0
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"%s->%@",__func__,[self class]);
    NSLog(@"==appState= %d",(int)[[UIApplication sharedApplication] applicationState]);
    NSLog(@"==launchOptions=====> %@", launchOptions);
    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds] ;
    if(self.window) {
        self.window.backgroundColor = UIColor.whiteColor;
        
#if ENABLE_VIEW_CREATION_PROGRAMATTIC
        self.window.rootViewController = [[MainViewController alloc] init];
        
        UIView *rootView = [[UIView alloc]init];
        [rootView setFrame:self.window.frame];
        UILabel *label = [[UILabel alloc] init];
        CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
        NSLog(@"####### %.2f,%.2f,%.2f,%.2f ##########",statusBarFrame.origin.x, statusBarFrame.origin.y, statusBarFrame.size.width,statusBarFrame.size.height);
        [label setFrame: CGRectMake(statusBarFrame.origin.x + 10, statusBarFrame.origin.y + 10, 100, 40)];
        [label setFrame:statusBarFrame];
        [label setBackgroundColor:[UIColor yellowColor]];
        [label setText:@"Hello World !"];
        [rootView addSubview:label];
        self.window.rootViewController.view = rootView;
#elif ENABLE_VIEW_CREATION_WITH_NIB
        self.window.rootViewController = [[MainViewController alloc] init];
        
        NSLog(@"creating via Nib");
        UINib *mainNib = [UINib nibWithNibName:@"NibView" bundle:nil];
        NSArray<UIView*> *views = [mainNib instantiateWithOwner:self.window.rootViewController options:nil];
        NSLog(@"top level views length %lu", (unsigned long)[views count]);
        UIView *rootView = [views firstObject];
        [rootView setBackgroundColor:[UIColor yellowColor]];
        self.window.rootViewController.view = rootView;
#else
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"SBView" bundle:nil];
        //self.window.rootViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"default"];
        //THE BELOW CODE WILL WORK AS I HAVE CONFIGURED AN INITAL VIEW CONTROLLER FOR THE STORY-BOARD
        [mainStoryboard instantiateViewControllerWithIdentifier:@"main"];
        self.window.rootViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"main"];
#endif
        
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    NSLog(@"creating bg window");
//    UIScreen *mainScreen = [UIScreen mainScreen];
//    UIWindow *bgWindow = [[UIWindow alloc] initWithFrame:CGRectMake(50, 50, 400, 400)];
//    bgWindow.screen = mainScreen;
//    bgWindow.backgroundColor = [UIColor yellowColor];
//    bgWindow.hidden = NO;
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
