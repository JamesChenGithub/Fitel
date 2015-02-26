//
//  AppDelegate.m
//  Fitel
//
//  Created by James on 2/17/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "AppDelegate.h"


@interface TabBarController : UITabBarController
@end

@implementation TabBarController

- (NSUInteger)supportedInterfaceOrientations
{
    UIViewController *topnav = self.selectedViewController;
    if ([topnav isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)topnav;
        if ([nav.topViewController isKindOfClass:[TrainViewController class]])
        {
            return UIInterfaceOrientationMaskAll;
        }
    }
    
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}



@end



@interface AppDelegate ()

@property (nonatomic, strong) UITabBarController *tabBarController;

@end

@implementation AppDelegate

- (UINavigationController *)navigationViewController
{
    
    UINavigationController *nav = (UINavigationController *)(self.tabBarController.selectedViewController);
    return nav;
}

- (void)enterMainUI
{
    [[UITabBar appearance] setBackgroundImage:kTabBar_Background_Image];
    [[UITabBar appearance] setTintColor:kThemeColor];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kBlackColor, NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kThemeColor, NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    
    MainViewController *mainvc = [NSObject loadClass:[MainViewController class]];
    NavigationViewController *mainNav = [[NavigationViewController alloc] initWithRootViewController:mainvc];
    mainNav.interactivePopGestureRecognizer.enabled = YES;
    mainNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:kTabBar_Main_Title_Str image:kTabBar_Main_Normal_Icon selectedImage:kTabBar_Main_Select_Icon];
    mainvc.title = mainNav.tabBarItem.title;
    
    CalculateViewController *disvc = [NSObject loadClass:[CalculateViewController class]];
    NavigationViewController *disNav = [[NavigationViewController alloc] initWithRootViewController:disvc];
    disNav.interactivePopGestureRecognizer.enabled = YES;
    disNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:kTabBar_Calculate_Title_Str image:kTabBar_Discovery_Normal_Icon selectedImage:kTabBar_Discovery_Select_Icon];
    disvc.title = disNav.tabBarItem.title;
    
    SettingViewController *minevc = [NSObject loadClass:[SettingViewController class]];
    NavigationViewController *mineNav = [[NavigationViewController alloc] initWithRootViewController:minevc];
    mineNav.interactivePopGestureRecognizer.enabled = YES;
    mineNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:kTabBar_Setting_Title_Str image:kTabBar_Mine_Normal_Icon selectedImage:kTabBar_Mine_Select_Icon];
    minevc.title = mineNav.tabBarItem.title;
    
    self.tabBarController = [[TabBarController alloc] init];
    [self.tabBarController setViewControllers:@[mainNav, disNav, mineNav]];
    self.window.rootViewController = self.tabBarController;
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [super applicationWillTerminate:application];
    [_cacheEngine cancelAllOperations];
}

- (MKNetworkEngine *)cacheEngine
{
    if (!_cacheEngine)
    {
        _cacheEngine = [[MKNetworkEngine alloc] initWithHostName:@"112.74.104.11"];
//        [_cacheEngine useCache];
    }
    return _cacheEngine;
}
@end
