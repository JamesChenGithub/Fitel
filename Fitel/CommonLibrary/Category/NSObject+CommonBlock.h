//
//  NSObject+CommonBlock.h
//  iLunchCommon
//
//  Created by James on 3/11/14.
//  Copyright (c) 2014 iLunch. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CommonBlock)(id selfPtr);

typedef void (^CommonCompletionBlock)(id selfPtr, BOOL isFinished);

@interface NSObject (CommonBlock)

- (void)excuteBlock:(CommonBlock)block;

- (void)performBlock:(CommonBlock)block;

//- (void)cancelBlock:(CommonBlock)block;

- (void)performBlock:(CommonBlock)block afterDelay:(NSTimeInterval)delay;



- (void)excuteCompletion:(CommonCompletionBlock)block withFinished:(NSNumber *)finished;

- (void)performCompletion:(CommonCompletionBlock)block withFinished:(BOOL)finished;

//- (void)cancelCompletion:(CommonCompletionBlock)block;

//- (void)performCompletion:(CommonCompletionBlock)block withFinished:(BOOL)finished afterDelay:(NSTimeInterval)delay;



@end
