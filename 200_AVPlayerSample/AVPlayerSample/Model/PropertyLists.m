//
//  PropertyLists.m
//  AVPlayerSample
//
//  Created by Karthick C on 11/07/18.
//  Copyright © 2018 Karthick C. All rights reserved.
//

#import "PropertyLists.h"
#import "BuiltInContent.h"

static NSString * const KEY_NAME = @"name";
static NSString * const KEY_URL = @"contentURL";

static NSMutableArray<BuiltInContent*> *builtInContents;
@implementation PropertyLists
+ (NSArray<BuiltInContent*> *) builtInContents {
    if(builtInContents == nil) {
        [self loadBuiltInContents];
    }
    return builtInContents;
}


+(void) loadBuiltInContents {
    builtInContents = [[NSMutableArray alloc] init];
    NSString *builtInContentsPath = [[NSBundle mainBundle] pathForResource:@"BuiltInContents" ofType:@"plist"];
    NSArray *builtInContentsArray = [NSArray arrayWithContentsOfFile:builtInContentsPath];
    for(NSDictionary *item in builtInContentsArray) {
        NSString *name = item[KEY_NAME];
        NSString *url = item[KEY_URL];
        BuiltInContent *content = [[BuiltInContent alloc] initWithName:name url:url];
        [builtInContents addObject:content];
    }
}
@end
