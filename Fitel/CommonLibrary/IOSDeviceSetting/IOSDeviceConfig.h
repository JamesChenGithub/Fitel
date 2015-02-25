//
//  IOSDeviceConfig.h
//  iLunch
//
//  Created by ken liu on 13-1-11.
//  Copyright (c) 2013年 ken liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IOSDeviceConfig : SingletonBase

// 固有属性
@property (nonatomic, readonly) BOOL isIPad;

@property (nonatomic, readonly) BOOL isIPhone;

@property (nonatomic, readonly) BOOL isIPhone4;

@property (nonatomic, readonly) BOOL isIPhone5;

@property (nonatomic, readonly) BOOL isIOS7;

@property (nonatomic, readonly) BOOL isIOS6;

@property (nonatomic, readonly) BOOL isIOS6Later;

@property (nonatomic, readonly) BOOL isIOS7Later;

// 全局设置
@property (nonatomic, readonly) BOOL isPortrait;

//@property (nonatomic, readonly) NSString *deviceUUID;

//@property (nonatomic, assign)   float    navigationHeight;





+ (IOSDeviceConfig *)sharedConfig;


@end
