//
//  Stack.h
//  iLunchCommon
//
//  Created by James on 3/5/14.
//  Copyright (c) 2014 iLunch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSMutableArray

+ (instancetype)stack;

- (void)push:(id)obj;

- (id)pop;

- (NSArray *)popTo:(id)obj;

@end
