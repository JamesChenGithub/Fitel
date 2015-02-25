
//
//  Stack.m
//  iLunchCommon
//
//  Created by James on 3/5/14.
//  Copyright (c) 2014 iLunch. All rights reserved.
//

#import "Stack.h"

@implementation Stack

+ (instancetype)stack
{
    return [self array];
}

- (void)push:(id)obj
{
    if (obj) {
        [self addObject:obj];
    }
}

- (id)pop
{
    id last = [self lastObject];
    [self removeLastObject];
    return last;
}

- (NSArray *)popTo:(id)obj
{
    if ([self containsObject:obj])
    {
        NSInteger index = [self indexOfObject:obj];
        NSRange range = NSMakeRange(index + 1, self.count - index - 1);
        NSArray *array = [self subarrayWithRange:range];
        [self removeObjectsInRange:range];
        return array;
    }
    return nil;
}

@end
