//
//  ViewControllerCommsApp.m
//  ViewControllerComms
//
//  Created by Karthick C on 01/10/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import "ViewCtrlCommsApp.h"

@interface ViewCtrlCommsApp()
@end
@implementation ViewCtrlCommsApp

- (instancetype)init {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self = [super init];
    if(self) {
        [self addObserver:self forKeyPath:@"keyWindow" options:NSKeyValueObservingOptionOld| NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"changed : %@", keyPath);
}

- (BOOL)sendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent *)event {
    NSLog(@"%s action=%@, target=%@, from=%@, event=%@",__PRETTY_FUNCTION__, NSStringFromSelector(action), target, sender, event);
    NSLog(@"%@", [NSThread callStackSymbols]);
    return [super sendAction:action to:target from:sender forEvent:event];
}
@end
