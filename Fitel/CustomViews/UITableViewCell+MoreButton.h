//
//  UITableViewCell+MoreButton.h
//  iLunch
//
//  Created by James on 15-1-18.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellMoreMenuItem : MenuItem

@property (nonatomic, strong) UIColor *backColor;

- (instancetype)initIcon:(UIImage *)icon backColor:(UIColor *)color action:(MenuAction)action;

@end

@interface UITableViewCell (MoreButton)

- (void)addMoreMenus:(NSArray *)array;

- (void)relayoutMenuButtons;

@end
