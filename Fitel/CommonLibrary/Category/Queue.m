//
//  Queue.m
//  iLunchCommon
//
//  Created by James on 3/5/14.
//  Copyright (c) 2014 iLunch. All rights reserved.
//

#import "Queue.h"

@implementation Queue

- (instancetype)initWithCapacity:(NSUInteger)numItems
{
    if (self = [super init])
    {
        _queue = [NSMutableArray arrayWithCapacity:numItems];
        _length = numItems;
    }
    return self;
}

+ (instancetype)queueWithCapacity:(NSUInteger)numItems
{
    return [[Queue alloc] initWithCapacity:numItems];
}

+ (instancetype)arrayWithCapacity:(NSUInteger)numItems
{
    return [Queue queueWithCapacity:numItems];
}

- (NSInteger)length
{
    return _length;
}

- (NSUInteger)count
{
    return [_queue count];
}

- (BOOL)isLimited
{
    @synchronized(self)
    {
        return self.count == _length;
    }
}

- (BOOL)enQueue:(id)obj
{
    @synchronized(self)
    {
        if (obj)
        {
            if ([self count] < _length)
            {
                [_queue addObject:obj];
                return YES;
            }
            return NO;
        }
        
        return NO;
    }
}

- (id)deQueue
{
    @synchronized(self)
    {
        id last = [_queue firstObject];
        [_queue removeObject:last];
        return last;
    }
}

- (void)clearQueue
{
    @synchronized(self)
    {
        [_queue removeAllObjects];
    }
}

- (id)first
{
    @synchronized(self)
    {
        return [_queue firstObject];
    }
}


@end
