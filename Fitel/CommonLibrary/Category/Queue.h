//
//  Queue.h
//  iLunchCommon
//
//  Created by James on 3/5/14.
//  Copyright (c) 2014 iLunch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Queue : NSObject
{
@protected
    NSInteger _length;
@private
    NSMutableArray *_queue;
    
}

@property (nonatomic, assign) NSInteger length;

- (instancetype)initWithCapacity:(NSUInteger)numItems;

+ (instancetype)queueWithCapacity:(NSUInteger)numItems;

- (BOOL)isLimited;

//- (BOOL)isEmpty;

- (NSUInteger)count;

- (BOOL)enQueue:(id)obj;

- (id)deQueue;

- (void)clearQueue;

- (id)first;

@end
