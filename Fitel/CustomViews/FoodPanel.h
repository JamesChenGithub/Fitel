//
//  FoodPanel.h
//  iLunch
//
//  Created by James on 15-1-10.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodPanel : UIView
{
    UIScrollView *_panel;
    NSMutableArray *_foodButtons;
    NSMutableArray *_foodItems;
}

- (instancetype)initWithMenus:(NSArray *)array;

- (void)show;

- (void)dismiss;

@end
