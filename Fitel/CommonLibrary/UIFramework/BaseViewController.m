//
//  BaseViewController.m
//  Fitel
//
//  Created by 陈耀武 on 14-1-15.
//  Copyright (c) 2014年 Fitel. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addBackItem];
#if kIsFitelSeller
    self.navigationController.navigationBar.hidden = NO;
#endif
}
#if kIsFitelSeller
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
#endif


- (void)addBackItem
{
//    UIImage *bicon = kNav_Back_Icon;
//    UIButton *button = [[UIButton alloc] init];
//    button.backgroundColor = kRedColor;
//    [button setImage:bicon forState:UIControlStateNormal];
//    button.frame = CGRectFromCGSize(bicon.size);
//    [button addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:button];
//    self.navigationItem.leftBarButtonItem = back;
}

- (void)goBack
{
    [[AppDelegate sharedAppDelegate] popViewController];
}


//- (BOOL)shouldAutorotate
//{
//    if ([IOSDeviceConfig sharedConfig].isPortrait)
//    {
//        return [super shouldAutorotate];
//    }
//    else
//    {
//        [super shouldAutorotate];
//        return YES;
//    }
//}


@end
