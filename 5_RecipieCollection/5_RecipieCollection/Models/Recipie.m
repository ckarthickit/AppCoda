//
//  Recipie.m
//  5_RecipieCollection
//
//  Created by Karthick C on 13/12/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import "Recipie.h"

@interface Recipie()
@property (nonatomic,readwrite) NSString *name;
@property (nonatomic,readwrite) NSString *thumbnail;
@end
@implementation Recipie

- (instancetype) initWithName:(NSString *) name thumbnail:(NSString *) thumbnail {
    self = [super init];
    if(self) {
        self.name = name;
        self.thumbnail = thumbnail;
    }
    return self;
}
@end
