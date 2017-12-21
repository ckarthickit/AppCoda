//
//  UserInterfaceApp.m
//  UserInterfaceDesignTypesDemo
//
//  Created by Karthick C on 14/09/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//
#import "UserInterfaceApp.h"
@implementation UserInterfaceApp

- (instancetype)init {
    return [super init];
}

- (void)setDelegate:(id<UIApplicationDelegate>)delegate {
    NSLog(@"%s: %@", __func__, delegate);
    //NSLog(@"%@",[NSThread callStackSymbols]);
    [super setDelegate:delegate];
}
- (UIApplicationState)applicationState {
    UIApplicationState state = [super applicationState];
    NSLog(@"===apSelf===>%@,%d", self, (int) state);
    //NSLog(@"==appState==>%@",[NSThread callStackSymbols]);
    return state;
}

- (NSString *)description {
    return [super description];
}

- (UIContentSizeCategory)preferredContentSizeCategory {
    //NSLog(@"==preferredContentSizeCategory==>%@",[NSThread callStackSymbols]);
    return  [super preferredContentSizeCategory];
}

- (void)setValue:(id)value forKey:(NSString *)key {
    NSLog(@"%s: %@ (%@,%@)", __func__, [[NSThread callStackSymbols] objectAtIndex:1], value, key);
    [super setValue:value forKey:key];
}
- (id)valueForKey:(NSString *)key {
    NSLog(@"%s: %@ (%@)", __func__, [[NSThread callStackSymbols] objectAtIndex:1], key);
    return [super valueForKey: key];
}

@end
