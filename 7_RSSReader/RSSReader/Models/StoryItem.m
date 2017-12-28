//
//  StoryItem.m
//  RSSReader
//
//  Created by Karthick C on 21/12/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import "StoryItem.h"

@implementation StoryItem
- (instancetype)init {
    return nil;
}

- (instancetype)initWithTitle:(NSString *)title link:(NSString *)link description:(NSString *)description {
    self = [super init];
    if(self) {
        _title = title;
        _link = link;
        _shortDescription = description;
    }
    return self;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"(title=%@,link=%@,shortDesc=%@)",_title,_link,_shortDescription];
}
@end
