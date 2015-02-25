//
//  Singleton.m
//  CommonLibrary
//
//  Created by 陈耀武 on 12-11-4.
//  Copyright (c) 2012年. All rights reserved.
//

#import "Singleton.h"



@implementation SingletonMgr

@synthesize singletonsArray = _singletonsArray;

// 单例

static SingletonMgr *_singletonMgrInstance = nil;

+ (instancetype)shareInstance
{
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        _singletonMgrInstance = [[SingletonMgr alloc] init];
    });
    
    return _singletonMgrInstance;
}

- (void)add:(SingletonBase *)aSingleton
{
    if (![_singletonsArray containsObject:aSingleton]) {
        [_singletonsArray addObject:aSingleton];
    }
}

- (void)remove:(SingletonBase *)aSingleton
{
    if ([_singletonsArray containsObject:aSingleton]) {
        [_singletonsArray removeObject:aSingleton];
    }
    
    CommonRelease(aSingleton);
}

- (void)dealloc
{
    // 外部只用调用 SingletonMgr release 即可
    for (id<SingletonAble> singleton in _singletonsArray)
    {
        DebugLog(@"%@",singleton);
        CommonRelease(singleton)
    }
    CommonRelease(_singletonsArray);
//    [_singletonsArray release];
    CommonSuperDealloc();
}

+ (void)uninstall
{
    CommonRelease(_singletonMgrInstance);
    _singletonMgrInstance = nil;
}

@end


@implementation SingletonBase

// dealloc时不显示地从SingletonMgr中移出，［SingletonMgr dealloc］将所有添加的单例移出



- (instancetype)init
{
    if(self = [super init])
    {
        [[SingletonMgr shareInstance] add:self];
    }
    return self;
}



@end
