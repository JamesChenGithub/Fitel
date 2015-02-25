//
//  NavigationViewController.h
//  PizusComics
//
//  Created by 陈耀武 on 13-7-3.
//  Copyright (c) 2013年 pizus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationViewController : UINavigationController


@property (nonatomic, assign) BOOL asChild;

@property (nonatomic, assign) CGSize childSize;

//- (void)setNavigationBarAppearance;

- (void)layoutSubviewsFrame;

@end
