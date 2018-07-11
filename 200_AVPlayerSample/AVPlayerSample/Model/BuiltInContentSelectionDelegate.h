//
//  BuiltInContentSelectionDelegate.h
//  AVPlayerSample
//
//  Created by Karthick C on 11/07/18.
//  Copyright © 2018 Karthick C. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BuiltInContent;
@protocol BuiltInContentSelectionDelegate <NSObject>
@required
- (void) didSelectBuiltInItem: (BuiltInContent *) content;
@end
