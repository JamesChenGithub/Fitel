//
//  UIView+RelativeCoordinate.m
//  iLunch
//
//  Created by James on 5/21/14.
//  Copyright (c) 2014 James. All rights reserved.
//

#import "UIView+RelativeCoordinate.h"

@implementation UIView (RelativeCoordinate)

- (BOOL)isSubContentOf:(UIView *)aSuperView
{
    if (self == aSuperView)
    {
        return YES;
    }
    else
    {
        return [self.superview isSubContentOf:aSuperView];
    }
}


- (CGRect)relativePositionTo:(UIView *)aSuperView
{
    BOOL isSubContentOf = [self isSubContentOf:aSuperView];
    
    while (isSubContentOf)
    {
        return [self relativeTo:aSuperView];
    }
    
    return CGRectZero;
    
}

- (CGRect)relativeTo:(UIView *)aSuperView
{
    CGPoint originPoint = CGPointZero;
    UIView *view = self;
    while (!(view == aSuperView))
    {
        originPoint.x += view.frame.origin.x;
        originPoint.y += view.frame.origin.y;
        
        view = view.superview;
        
        if ([view isKindOfClass:[UIScrollView class]])
        {
            originPoint.x -= ((UIScrollView *) view).contentOffset.x;
            originPoint.y -= ((UIScrollView *) view).contentOffset.y;
        }
    }
    
    // TODO:如果SuperView是UIWindow,需要结合Transform计算
    return CGRectMake(originPoint.x, originPoint.y, self.frame.size.width, self.frame.size.height);
}

#if kSupportEMT
- (UIView<AddMusicPanAbleItem> *)addMusicPanAbleView
{
    if ([self isKindOfClass:[UIWindow class]]) {
        return nil;
    }
    else
    {
        if ([self conformsToProtocol:@protocol(AddMusicPanAbleItem)])
        {
            return (UIView<AddMusicPanAbleItem> *)self;
        }
        else
        {
            return [self.superview addMusicPanAbleView];
        }
    }
}
#endif

@end
