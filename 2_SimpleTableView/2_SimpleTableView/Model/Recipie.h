//
//  Recipie.h
//  2_SimpleTableView
//
//  Created by Karthick C on 21/11/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipie : NSObject
@property (nonatomic,strong,readonly) NSString *name;
@property (nonatomic,strong,readonly) NSString *thumbnailName;
@property (nonatomic,strong,readonly) NSString *prepTime;
-(instancetype) initWithName:(NSString *) name thumbnail:(NSString *) thumbnailName prepTime:(NSString *) prepTime;
@end
