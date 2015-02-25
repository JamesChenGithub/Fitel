//
//  Singleton.h
//  CommonLibrary
//
//  Created by 陈耀武 on 12-11-4.
//  Copyright (c) 2012年. All rights reserved.
//

#import <Foundation/Foundation.h>

// 单例接口
@protocol SingletonAble <NSObject>

//@optional
//+ (instancetype)sharedInstance;

@end

@interface SingletonBase : NSObject<SingletonAble>
// 重写NSObject的init方法,与deallo方法
@end


@interface SingletonMgr : NSObject
{
@private
    NSMutableArray *_singletonsArray;   // 保存存系统中的单例
}

@property (nonatomic, retain) NSMutableArray *singletonsArray;

/*
 * 功能：获取单例管理者实例至
 */
+ (instancetype)shareInstance;

/*
 * 功能：添加单例至_singletonsArray中移除aSingleton
 */
- (void)add:(SingletonBase *)aSingleton;

/*
 * 功能：从_singletonsArray中移除aSingleton
 */
- (void)remove:(SingletonBase *)aSingleton;

+ (void)uninstall;


@end