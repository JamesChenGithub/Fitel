//
//  MenuItem.h
//  Fitel
//
//  Created by 陈耀武 on 14-1-16.
//  Copyright (c) 2014年 Fitel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuItem : NSObject<MenuAbleItem>

@property (nonatomic, copy) MenuAction action;

@end
