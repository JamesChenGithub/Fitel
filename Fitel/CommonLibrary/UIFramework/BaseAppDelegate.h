//
//  BaseAppDelegate.h
//  iLunchCommon
//
//  Created by James on 3/6/14.
//  Copyright (c) 2014 iLunch. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface BaseAppDelegate : UIResponder<UIApplicationDelegate>
{
@protected
    UIBackgroundTaskIdentifier _backgroundTaskIdentifier;
}

@property (strong, nonatomic) UIWindow *window;

+ (instancetype)sharedAppDelegate;

// 进入主界面逻辑
- (void)enterMainUI;

- (UINavigationController *)navigationViewController;

- (UIViewController *)topViewController;

- (void)pushViewController:(UIViewController *)viewController;

- (UIViewController *)popViewController;

- (NSArray *)popToRootViewController;

@end
