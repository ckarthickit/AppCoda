//
//  Recipie.h
//  3_RecipieBook
//
//  Created by Karthick C on 21/11/17.
//  Copyright © 2017 Karthick C. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipie : NSObject

@property (nonatomic, strong) NSString *name; // name of recipe
@property (nonatomic, strong) NSString *prepTime; // preparation time
@property (nonatomic, strong) NSString *imageFile; // image filename of recipe
@property (nonatomic, strong) NSArray *ingredients; // ingredients

@end
