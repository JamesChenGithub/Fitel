//
//  AppInfoView.m
//  iLunch
//
//  Created by James on 14-7-22.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "AppInfoView.h"

@implementation AppInfoView

- (instancetype)initWith:(UIImage *)appIcon name:(NSString *)name slogan:(NSString *)slogan
{
    if (self = [super init])
    {
        _appIcon = [UIImageView imageViewWithImage:appIcon];
        _appIcon.layer.cornerRadius = 22;
        [self addSubview:_appIcon];
        
        _appName = [UILabel labelWith:name boldFont:20];
        [self addSubview:_appName];
        
        _appSlogan = [UILabel labelWith:@"保护你的车生活" boldFont:16];
        [self addSubview:_appSlogan];
    }
    return self;
}


#define kContentHeight 44

- (void)relayoutFrameOfSubViews
{
    CGRect rect = self.bounds;
    rect = CGRectInset(rect, 0, (rect.size.height - kContentHeight)/2);
    
    CGRect appIconRect = rect;
    appIconRect.size.width = appIconRect.size.height;
    _appIcon.frame = appIconRect;
    
    rect.origin.x += appIconRect.size.width + 10;
    rect.size.width -= appIconRect.size.height + 10;
    rect.size.height /= 2;
    
    _appName.frame = rect;
    
    rect.origin.y += rect.size.height;
    _appSlogan.frame = rect;
}


@end
