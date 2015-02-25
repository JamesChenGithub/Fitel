//
//  ScrollViewController.m
//  iLunch
//
//  Created by James on 4/2/14.
//  Copyright (c) 2014 James. All rights reserved.
//

#import "ScrollViewController.h"

@interface ScrollViewController ()

@end

@implementation ScrollViewController

- (void)loadView
{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _scrollView.backgroundColor = kAppBakgroundColor;
    [self.view addSubview:_scrollView];
    
    self.view = _scrollView;
}

- (void)layoutSubviewsFrame
{
    [super layoutSubviewsFrame];
    [self configContentSize];
}

- (void)configContentSize
{
    // TODO: 设置ContentSize
}

@end
