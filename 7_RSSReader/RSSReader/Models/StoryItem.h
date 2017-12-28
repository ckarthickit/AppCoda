//
//  StoryItem.h
//  RSSReader
//
//  Created by Karthick C on 21/12/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoryItem : NSObject
@property (readonly,nonatomic) NSString *title;
@property (readonly,nonatomic) NSString *link;
@property (readonly,nonatomic) NSString *shortDescription;

-(instancetype) initWithTitle: (NSString *) title link: (NSString *) link description: (NSString *) description;
@end
