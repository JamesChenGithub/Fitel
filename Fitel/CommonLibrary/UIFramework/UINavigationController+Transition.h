//
//  UINavigationController+Transition.h
//  iLunch
//
//  Created by James on 3/18/14.
//  Copyright (c) 2014 James. All rights reserved.
//

#import <UIKit/UIKit.h>

//@interface UINavigationBar (CustomBackgroundImage)
//
//@end

@interface UINavigationController (Transition)

- (CATransition *)pushAnimation;
- (CATransition *)popAnimation;

- (void)pushViewController:(UIViewController *)viewController withAnimation:(void (^)(void))animation duration:(CGFloat)duration;

- (void)pushViewController:(UIViewController *)viewController withTransition:(CATransition *)transition;

- (UIViewController *)popViewControllerTransition:(CATransition *)transition;

- (NSArray *)popToRootViewControllerTransition:(CATransition *)transition;

- (NSArray *)popToViewController:(UIViewController *)viewController withTransition:(CATransition *)transition;

@end
