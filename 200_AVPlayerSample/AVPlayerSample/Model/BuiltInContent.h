//
//  BuiltInContent.h
//  AVPlayerSample
//
//  Created by Karthick C on 11/07/18.
//  Copyright © 2018 Karthick C. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuiltInContent : NSObject
@property(nonatomic,readonly) NSString *contentName;
@property(nonatomic,readonly) NSString *contentURL;
-(instancetype)initWithName:(NSString *) name url: (NSString*) url;
@end
