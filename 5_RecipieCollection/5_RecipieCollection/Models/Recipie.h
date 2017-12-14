//
//  Recipie.h
//  5_RecipieCollection
//
//  Created by Karthick C on 13/12/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipie : NSObject
@property (nonatomic,readonly) NSString *name;
@property (nonatomic,readonly) NSString *thumbnail;
- (instancetype) initWithName:(NSString *) name thumbnail:(NSString *) thumbnail;
@end
