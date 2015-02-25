//
//  CommonBaseViewController.h
//  iLunch
//
//  Created by James Chen on 2/28/13.
//  Copyright (c) 2013 ken liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonBaseViewController : UIViewController
{
@protected
    UIImageView *_backgroundView;
}

@property (nonatomic, strong) UIImageView           *backgroundView;

@property (nonatomic, assign) BOOL asChild;
@property (nonatomic, assign) CGSize childSize;


- (BOOL)hasBackgroundView;

- (BOOL)sameWithIOS6;

- (void)configParams;

- (void)addBackground;

- (void)configBackground;



- (void)layoutBackground;

//- (void)layoutOnViewWillAppear;
//
//- (void)layoutSubviewsFrame;
//
//- (void)layoutOnIPhone;
//
//- (void)layoutOnIPadInPortrait;
//
//- (void)layoutOnIPadInLandScape;




@end

@interface CommonBaseViewController (AutoLayout)

// 是否支持autoLayout
- (BOOL)isAutoLayout;

// 添加自动布局相关的constraints
- (void)autoLayoutOwnViews;

@end