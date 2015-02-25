//
//  NetworkUtility.h
//  woMusic
//
//  Created by 陈耀武 on 12-11-11.
//  Copyright (c) 2012年 pizus. All rights reserved.
//

#import <Foundation/Foundation.h>

// 网络断开通知
extern NSString *const kNetworkUtilityNotReachableNotification;
// 切换到Wifi
extern NSString *const kNetworkUtilityWifiConnectNotification;
// 切换到移动网络
extern NSString *const kNetworkUtilityMONETConnectNotification;

@interface NetworkUtility : SingletonBase
{
    Reachability *_reachablity;
    NSInteger _lastReachabilityStatus;
}

+ (NetworkUtility *)sharedNetworkUtility;

- (void)startCheckWifi;

- (BOOL)isReachable;

- (BOOL)isReachableViaWiFi;

- (NSString *)wifiSSID;

@end
