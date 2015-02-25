//
//  NSObject+CommonBlock.m
//  iLunchCommon
//
//  Created by James on 3/11/14.
//  Copyright (c) 2014 iLunch. All rights reserved.
//

#import "NSObject+CommonBlock.h"

@implementation NSObject (CommonBlock)

- (void)excuteBlock:(CommonBlock)block
{
    __weak typeof(self) selfPtr = self;
    if (block) {
        block(selfPtr);
    }
}

- (void)performBlock:(CommonBlock)block
{
    if (block)
    {
        [self performSelector:@selector(excuteBlock:) withObject:block];
    }
}

- (void)performBlock:(CommonBlock)block afterDelay:(NSTimeInterval)delay
{
    if (block)
    {
        [self performSelector:@selector(excuteBlock:) withObject:block afterDelay:delay];
    }
}

- (void)cancelBlock:(CommonBlock)block
{
    [[NSRunLoop currentRunLoop] cancelPerformSelector:@selector(excuteBlock:) target:self argument:block];
}


- (void)excuteCompletion:(CommonCompletionBlock)block withFinished:(NSNumber *)finished
{
    __weak typeof(self) selfPtr = self;
    if (block) {
        block(selfPtr, finished.boolValue);
    }
}

- (void)performCompletion:(CommonCompletionBlock)block withFinished:(BOOL)finished
{
    if (block)
    {
        [self performSelector:@selector(excuteCompletion:withFinished:) withObject:block withObject:[NSNumber numberWithBool:finished]];
    }
}

- (void)cancelCompletion:(CommonCompletionBlock)block
{
    [[NSRunLoop currentRunLoop] cancelPerformSelector:@selector(excuteCompletion:withFinished:) target:self argument:block];
}

//- (void)performCompletion:(CommonCompletionBlock)block withFinished:(BOOL)finished afterDelay:(NSTimeInterval)delay
//{
//    if (block)
//    {
//        self performSelector:<#(SEL)#> withObject:<#(id)#> afterDelay:<#(NSTimeInterval)#>
////        [self performSelector:@selector(excuteCompletion:withFinished:) withObject:block withObject:[NSNumber numberWithBool:finished] afterDelay:delay];
//    }
//}
@end
