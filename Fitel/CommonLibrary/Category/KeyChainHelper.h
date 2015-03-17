//
//  KeyChainHelper.h
//  Fitel
//
//  Created by 陈耀武 on 14-2-19.
//  Copyright (c) 2014年 Fitel. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface KeyChainHelper : NSObject

+ (void)addService:(NSString *)service withKey:(NSString *)key;

+ (NSString *)serviceForKey:(NSString *)key;

@end
