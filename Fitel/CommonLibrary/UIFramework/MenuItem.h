//
//  MenuItem.h
//  TCLSales
//
//  Created by 陈耀武 on 14-1-16.
//  Copyright (c) 2014年 iLunch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuItem : NSObject<MenuAbleItem>

@property (nonatomic, copy) MenuAction action;

@end
