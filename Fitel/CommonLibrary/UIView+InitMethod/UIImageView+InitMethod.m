//
//  UIImageView+InitMethod.m
//  iLunch
//
//  Created by James on 14-7-21.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "UIImageView+InitMethod.h"

@implementation UIImageView (InitMethod)


+ (instancetype)imageViewWithColor:(UIColor *)color
{
    UIImageView *view = [[UIImageView alloc] init];
    view.backgroundColor = color;
    return view;
}

+ (instancetype)imageViewWithColor:(UIColor *)color size:(CGSize)size
{
    UIImage *image = [UIImage imageWithColor:color size:size];
    return [self imageViewWithImage:image];
}

+ (instancetype)imageViewWithRandomColor:(CGSize)size
{
    UIImage *image = [UIImage randomColorImageWith:size];
    return [self imageViewWithImage:image];
}

+ (instancetype)imageViewWithImage:(UIImage *)image
{
    UIImageView *view = [[UIImageView alloc] init];
    view.image = image;
    return view;
}

@end
