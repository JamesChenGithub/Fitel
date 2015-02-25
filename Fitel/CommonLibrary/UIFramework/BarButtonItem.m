//
//  BarButtonItem.m
//  iLunch
//
//  Created by James on 4/15/14.
//  Copyright (c) 2014 James. All rights reserved.
//

#import "BarButtonItem.h"

@implementation BarButtonItem

#define kXOff 12
#define kBarItemHeight 44
#define kTintColor RGB(85, 140, 230)
//UIColorFromRGB(0x00E5EE)

- (id)initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action
{
    if ([IOSDeviceConfig sharedConfig].isIOS6)
    {
        UIButton *button = [[UIButton alloc] init];
        UIColor *color = kTintColor;
        [button setImage:[image imageWithTintColor:color] forState:UIControlStateNormal];
        CGSize size = image.size;
        button.frame = CGRectMake(kXOff, (44 - kBarItemHeight)/2, size.width + kXOff*2 , kBarItemHeight);
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        self = [super initWithCustomView:button];
        
        return self;
    }
    else
    {
        self = [super initWithImage:image style:style target:target action:action];
        return self;
    }
}

- (id)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action
{
    if ([IOSDeviceConfig sharedConfig].isIOS6)
    {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:kTintColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        CGSize size = [button.titleLabel textSizeIn:CGSizeMake(HUGE_VAL, kBarItemHeight)];
        button.frame = CGRectMake(kXOff, (44 - kBarItemHeight)/2, size.width + kXOff*2 , kBarItemHeight);
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        self = [super initWithCustomView:button];
        return self;
    }
    else
    {
        self = [super initWithTitle:title style:style target:target action:action];
        return self;
    }
}


@end
