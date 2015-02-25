//
//  UIView+Layout.m
//  iLunch
//
//  Created by James Chen on 2/28/13.
//  Copyright (c) 2013 ken liu. All rights reserved.
//

#import "UIView+Layout.h"

@implementation UIView (Layout)

- (id)init
{
    if (self = [self initWithFrame:CGRectZero]) {
        
        if (![self isAutoLayout])
        {
            [self addOwnViews];
            [self configOwnViews];
        }
        else
        {
            [self autoLayoutSubViews];
        }
        
    }
    return self;
}

- (BOOL)isAutoLayout
{
    return NO;
}

- (void)autoLayoutSubViews
{
    
}

- (void)addOwnViews
{
    // 添加自己的控件
}

- (void)configOwnViews
{
    // 初始化控件的值
}

//- (void)configWith:(NSMutableDictionary *)jsonDic
//{
//    
//}

- (void)setFrameAndLayout:(CGRect)rect
{
    self.frame = rect;
    if (self.bounds.size.width != 0 && self.bounds.size.height != 0)
    {
        [self relayoutFrameOfSubViews];
    }
}
- (void)relayoutFrameOfSubViews
{
    // do nothing here
}

- (void)addBottomLine:(CGRect)rect
{
    [self addBottomLine:kLightGrayColor inRect:rect];
}

- (void)addBottomLine:(UIColor *)color inRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    
    //Set the stroke (pen) color
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context, 1.0);
    
    CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
   	CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    
    CGContextStrokePath(context);
    
    UIGraphicsPopContext();
}

@end
