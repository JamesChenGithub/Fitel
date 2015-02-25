//
//  ImageTitleButton.h
//  iLunch
//
//  Created by James on 3/21/14.
//  Copyright (c) 2014 James. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    EImageTopTitleBottom,
    ETitleTopImageBottom,
    EImageLeftTitleRight,
    ETitleLeftImageRight,
    
    EImageLeftTitleRightLeft,
    EImageLeftTitleRightCenter,
    ETitleLeftImageRightCenter,
    ETitleLeftImageRightLeft,

    
}ImageTitleButtonStyle;

@interface ImageTitleButton : MenuButton
{
@protected
    UIEdgeInsets _margin;
    CGSize _padding;
    CGSize _imageSize;
    ImageTitleButtonStyle _style;
}

@property (nonatomic, assign) UIEdgeInsets margin;
@property (nonatomic, assign) CGSize padding;
@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, assign) ImageTitleButtonStyle style;

- (instancetype)initWithStyle:(ImageTitleButtonStyle)style;

- (instancetype)initWithStyle:(ImageTitleButtonStyle)style maggin:(UIEdgeInsets)margin;

- (instancetype)initWithStyle:(ImageTitleButtonStyle)style maggin:(UIEdgeInsets)margin padding:(CGSize)padding;

- (void)setTintColor:(UIColor *)color;

@end
