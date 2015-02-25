//
//  NavigationViewController.m
//
//  Created by 陈耀武 on 13-7-3.
//  Copyright (c) 2013年 pizus. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    [self setNavigationBarAppearance];
//}
////
////- (void)setTitle:(NSString *)title
////{
////    [super setTitle:title];
////}
////
//- (void)setNavigationBarAppearance
//{
//    
//}

- (BOOL)shouldAutorotate
{
    BOOL rorate = [self.viewControllers.lastObject shouldAutorotate];
    return rorate;
}


- (NSUInteger)supportedInterfaceOrientations
{
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
}


//ios5.0 横竖屏
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return [self shouldAutorotate];
}

- (void)viewWillLayoutSubviews
{
    if (![self asChild])
    {
        [super viewWillLayoutSubviews];
    }
    else
    {
        if (CGSizeEqualToSize(self.childSize, CGSizeZero)) {
            [super viewWillLayoutSubviews];
        }
        else
        {
            self.view.bounds = CGRectFromCGSize([self childSize]);
        }
    }
}





- (void)pushAnimation:(UIViewController *)viewController
{
    [self.view.layer addAnimation:[self pushAnimation] forKey:kCATransition];
}

- (void)popAnimation:(UIViewController *)viewController
{
    [self.view.layer addAnimation:[self popAnimation] forKey:kCATransition];
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.topViewController.navigationItem.backBarButtonItem = backItem;
    
    if (animated)
    {
        [super pushViewController:viewController animated:YES];
        return;
    }
    
    UIViewController *pushV = (UIViewController *) self.topViewController;
    if ([pushV respondsToSelector:@selector(pushAnimation:)])
    {
        [pushV performSelector:@selector(pushAnimation:) withObject:viewController];
        [super pushViewController:viewController animated:NO];
    }
    else
    {
        [super pushViewController:viewController animated:NO];
        [self pushAnimation:pushV];
    }
    
}

- (void)popAnimationOver
{
    [super popViewControllerAnimated:NO];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if (animated)
    {
        return [super popViewControllerAnimated:YES];
    }
    
    UIViewController *popV = (UIViewController *) self.topViewController;
    if ([popV respondsToSelector:@selector(popAnimation:)])
    {
        [popV performSelector:@selector(popAnimation:) withObject:popV];
        return [super popViewControllerAnimated:NO];
    }
    else
    {
        [self popAnimation:popV];
        return [super popViewControllerAnimated:NO];
    }
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    if (animated)
    {
        return [super popToRootViewControllerAnimated:animated];
    }
    [self.view.layer addAnimation:[self popAnimation] forKey:kCATransition];
    return [super popToRootViewControllerAnimated:NO];
}

- (void)pushViewControllerFromBottom:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:NO];
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transition.autoreverses = NO;
    
    
    [self.view.layer addAnimation:transition forKey:kCATransition];
    
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (!animated)
    {
        return [super popToViewController:viewController animated:animated];
    }
    
    UIViewController *popV = (UIViewController *) self.topViewController;
    if ([popV respondsToSelector:@selector(popAnimation:)])
    {
        [popV performSelector:@selector(popAnimation:) withObject:popV];
        return [super popToViewController:viewController animated:NO];
    }
    else
    {
        [self popAnimation:popV];
        return [super popToViewController:viewController animated:NO];
    }
}

- (void)layoutSubviewsFrame
{
    [super layoutSubviewsFrame];
    [self.topViewController layoutSubviewsFrame];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return [self.topViewController preferredStatusBarStyle];
}


@end
