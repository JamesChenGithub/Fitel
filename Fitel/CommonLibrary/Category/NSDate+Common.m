//
//  NSDate+_Common.m
//  TCLSales
//
//  Created by ken liu on 14-1-21.
//  Copyright (c) 2014年 iLunch. All rights reserved.
//

#import "NSDate+Common.h"

@implementation NSDate (Common)

+ (instancetype)minimumDate
{
    NSDateFormatter *formatter_minDate = [[NSDateFormatter alloc] init];
    [formatter_minDate setDateFormat:@"yyyy-MM-dd"];
    NSDate *minDate = [formatter_minDate dateFromString:@"2004-01-01"];
    formatter_minDate = nil;
    return minDate;
}

+ (instancetype)minimumDateFromString:(NSString *)dateString
{
    NSDateFormatter *formatter_minDate = [[NSDateFormatter alloc] init];
    [formatter_minDate setDateFormat:@"yyyy-MM-dd"];
    NSDate *minDate = [formatter_minDate dateFromString:dateString];
    formatter_minDate = nil;
    return minDate;
}

+ (instancetype)yesterdayDate
{
    NSTimeInterval nowdate = [[NSDate date] timeIntervalSinceNow];
    NSTimeInterval yesterdaydate = nowdate - 60*60*24;
    return [[NSDate alloc] initWithTimeIntervalSinceNow:yesterdaydate];
}

+ (NSString *)yesterdayString
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [dateFormat stringFromDate:[NSDate yesterdayDate]];
    return date;
}

+ (NSString *)todayString
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [dateFormat stringFromDate:[NSDate date]];
    return date;
}


@end
