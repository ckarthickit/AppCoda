//
//  BuiltInContent.m
//  AVPlayerSample
//
//  Created by Karthick C on 11/07/18.
//  Copyright © 2018 Karthick C. All rights reserved.
//

#import "BuiltInContent.h"
@interface BuiltInContent()
@property(nonatomic) NSString *contentName;
@property(nonatomic) NSString *contentURL;
@end

@implementation BuiltInContent

-(instancetype)initWithName:(NSString *) name url: (NSString*) url {
    if(self = [super init]) {
        self.contentName = name;
        self.contentURL = url;
    }
    return self;
}
@end
