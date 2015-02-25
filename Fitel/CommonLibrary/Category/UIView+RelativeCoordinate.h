//
//  UIView+RelativeCoordinate.h
//  iLunch
//
//  Created by James on 5/21/14.
//  Copyright (c) 2014 James. All rights reserved.
//

#import <UIKit/UIKit.h>

#if kSupportEMT
@protocol AddMusicPanAbleItem;
#endif

@interface UIView (RelativeCoordinate)

- (BOOL)isSubContentOf:(UIView *)aSuperView;

- (CGRect)relativePositionTo:(UIView *)aSuperView;

#if kSupportEMT
- (UIView<AddMusicPanAbleItem> *)addMusicPanAbleView;
#endif

@end
