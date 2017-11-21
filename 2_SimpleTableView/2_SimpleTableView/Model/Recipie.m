//
//  Recipie.m
//  2_SimpleTableView
//
//  Created by Karthick C on 21/11/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import "Recipie.h"

@implementation Recipie

-(instancetype)initWithName:(NSString *)name thumbnail:(NSString *)thumbnailName prepTime:(NSString *)prepTime {
    self = [super init];
    if(self) {
        _name = name;
        _thumbnailName = thumbnailName;
        _prepTime = prepTime;
    }
    return self;
}

@end
