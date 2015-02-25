//
//  UIImageView+InitMethod.h
//  iLunch
//
//  Created by James on 14-7-21.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (InitMethod)

+ (instancetype)imageViewWithColor:(UIColor *)color;

+ (instancetype)imageViewWithColor:(UIColor *)color size:(CGSize)size;

+ (instancetype)imageViewWithRandomColor:(CGSize)size;

+ (instancetype)imageViewWithImage:(UIImage *)image;

@end
