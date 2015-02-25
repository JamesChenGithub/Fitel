//
//  UIView+ModifyFrame.h
//  iLunchCommon
//
//  Created by 陈耀武 on 14-2-21.
//  Copyright (c) 2014年 iLunch. All rights reserved.
//

#define kSupportModifyFrame 0
#if kUnSupportModifyFrame

#import <UIKit/UIKit.h>





@interface UIView (ModifyFrame)

@property float x;
@property float y;
@property CGPoint origin;
@property float width;
@property float height;

@property CGSize boundsSize;

- (CGPoint)originRelativeToWindow;
- (CGPoint)centerRelativeToWindow;
- (CGRect)relativeToWindow;

@end

@interface UIViewController (ModifyFrame)

@property float x;
@property float y;
@property float width;
@property float height;
@property CGSize boundsSize;


@end

#endif