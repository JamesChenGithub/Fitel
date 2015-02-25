//
//  UIImage+TintColor.h
//  TintColor
//
//  Created by 陈耀武 on 13-9-23.
//  Copyright (c) 2013年 ywchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TintColor)

// tint只对里面的图案作更改颜色操作
- (UIImage *)imageWithTintColor:(UIColor *)tintColor;
- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;
- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor;

//- (UIImage *)imageWithFillColor:(UIColor *)tintColor;
//- (UIImage *)imageWithGradientFillColor:(UIColor *)tintColor;

@end
