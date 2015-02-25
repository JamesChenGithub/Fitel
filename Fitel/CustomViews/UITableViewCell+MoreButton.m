//
//  UITableViewCell+MoreButton.m
//  iLunch
//
//  Created by James on 15-1-18.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import "UITableViewCell+MoreButton.h"

@implementation CellMoreMenuItem

- (instancetype)initIcon:(UIImage *)icon backColor:(UIColor *)color action:(MenuAction)action
{
    if (self = [super initWithTitle:nil icon:icon action:action])
    {
        self.backColor = color;
    }
    return self;
}

@end

@implementation UITableViewCell (MoreButton)

- (void)addMoreMenus:(NSArray *)array
{
    if (array.count)
    {
        UIView *view = [[UIView alloc] init];
        view.tag = 90000;
        [self insertSubview:view belowSubview:self.contentView];
        
        for (CellMoreMenuItem *item in array)
        {
            MenuButton *button = [[MenuButton alloc] initWithMenu:item];
            [button setBackgroundColor:item.backColor];
            [view addSubview:button];
        }
        
        UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipeLeft:)];
        swip.direction = UISwipeGestureRecognizerDirectionLeft;
        [self.contentView addGestureRecognizer:swip];
        
        UISwipeGestureRecognizer *swipR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipeRight:)];
        swipR.direction = UISwipeGestureRecognizerDirectionRight;
        [self.contentView addGestureRecognizer:swipR];
    
    }
}

- (void)onSwipeLeft:(UISwipeGestureRecognizer *)swip
{
    if (swip.state == UIGestureRecognizerStateEnded)
    {
        CGRect rect = self.contentView.frame;
        if (rect.origin.x > 0)
        {
            UIView *view = [self viewWithTag:90000];
            CGRect frame = view.frame;
            
            rect.origin.x -= frame.size.width;
            [UIView animateWithDuration:0.3 animations:^{
                self.contentView.frame = rect;
            }];
        }
        
    }
}

- (void)onSwipeRight:(UISwipeGestureRecognizer *)swip
{
    if (swip.state == UIGestureRecognizerStateEnded)
    {
        CGRect rect = self.contentView.frame;
        if (rect.origin.x < 0)
        {
            UIView *view = [self viewWithTag:90000];
            CGRect frame = view.frame;
            
            rect.origin.x += frame.size.width;
            [UIView animateWithDuration:0.3 animations:^{
                self.contentView.frame = rect;
            }];
   
        }
    }
}


- (void)relayoutMenuButtons
{
    CGRect bounds = self.bounds;
    bounds = CGRectInset(bounds, 0, 1);
    UIView *view = [self viewWithTag:90000];
    [view sizeWith:CGSizeMake(bounds.size.height * view.subviews.count, bounds.size.height)];
    [view layoutParentVerticalCenter];
    [view alignParentRight];
    
    
    bounds = view.bounds;
    CGRect rect = bounds;
    rect.size.width = bounds.size.height;
    
    for (UIView *but in view.subviews)
    {
        but.frame = rect;
        rect.origin.x += rect.size.width;
    }

}

@end
