//
//  NSDate+_Common.h
//  TCLSales
//
//  Created by ken liu on 14-1-21.
//  Copyright (c) 2014年 iLunch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Common)

+ (instancetype)minimumDate;

+ (instancetype)minimumDateFromString:(NSString *)dateString;

+ (instancetype)yesterdayDate;

+ (NSString *)yesterdayString;

+ (NSString *)todayString;


@end
