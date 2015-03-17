//
//  UIViewController+Layout.m
//  Fitel
//
//  Created by James on 3/13/14.
//  Copyright (c) 2014 James. All rights reserved.
//

#import "UIViewController+Layout.h"

@implementation UIViewController (AsChild)


- (void)setAsChild:(BOOL)asChild
{
}

- (BOOL)asChild
{
    return NO;
}

- (void)setChildSize:(CGSize)childSize
{
    
}

- (CGSize)childSize
{
    return CGSizeZero;
}




@end

@implementation UIViewController (Layout)

- (BOOL)shouldAutorotate
{
    BOOL isPad = [IOSDeviceConfig sharedConfig].isIPad;

    if (isPad)
    {
        [self layoutSubviewsFrame];
    }

    return isPad;

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return [self shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (void)layoutOnIPhone
{
    // iPhone上的布局
}

- (void)layoutOnIPadInPortrait
{
    // iPad竖屏布局
    [self layoutOnIPhone];
}

- (void)layoutOnIPadInLandScape
{
    // iPad横屏布局
    [self layoutOnIPhone];
}

- (void)layoutSubviewsFrame
{
    // App 根据需求决定如何进行布局
    IOSDeviceConfig *app = [IOSDeviceConfig sharedConfig];

    if (app.isIPad)
    {
        if (app.isPortrait)
        {
            [self layoutOnIPadInPortrait];
        }
        else
        {
            [self layoutOnIPadInLandScape];
        }
    }
    else
    {
        [self layoutOnIPhone];
    }
}


- (void)layoutOnViewWillAppear
{
    [self layoutSubviewsFrame];
}

- (void)addOwnViews
{
    // 此处添加界面中的控件
    
}

- (void)configOwnViews
{
    // 此处配置界面中的控件的值
}

@end

@implementation UITabBarController (Layout)

- (BOOL)shouldAutorotate
{
    return [self.selectedViewController shouldAutorotate];
}

@end


//@implementation UIViewController (DeviceListChangeNotify)
//
//
//
//- (void)addDeviceListChangeObserver
//{
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(onDeviceListChanged)
//                                                 name:kAliveDevicesChangedNotification
//                                               object:nil];
//}
//
//- (void)onDeviceListChanged
//{
//}
//
//@end
