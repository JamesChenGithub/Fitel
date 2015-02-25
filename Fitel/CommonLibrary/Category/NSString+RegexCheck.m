//
//  NSString+RegexCheck.m
//  TCLSales
//
//  Created by 陈耀武 on 14-2-13.
//  Copyright (c) 2014年 iLunch. All rights reserved.
//

#import "NSString+RegexCheck.h"


@implementation NSString (RegexCheck)

- (BOOL)matchRegex:(NSString *)regex
{
    //SELF MATCHES一定是大写
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return  [predicate evaluateWithObject:self];
}
@end
