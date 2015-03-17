//
//  UIViewController+Layout.h
//  Fitel
//
//  Created by James on 3/13/14.
//  Copyright (c) 2014 James. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (AsChild)

- (void)setAsChild:(BOOL)asChild;

- (BOOL)asChild;

- (void)setChildSize:(CGSize)childSize;

- (CGSize)childSize;

@end

@interface UIViewController (Layout)

- (void)layoutOnViewWillAppear;

- (void)layoutSubviewsFrame;

- (void)layoutOnIPhone;

- (void)layoutOnIPadInPortrait;

- (void)layoutOnIPadInLandScape;

- (void)addOwnViews;

- (void)configOwnViews;


@end

//@interface UIViewController (DeviceListChangeNotify)
//
//- (void)addDeviceListChangeObserver;
//- (void)onDeviceListChanged;
//
//@end

@interface UITabBarController (Layout)

@end

