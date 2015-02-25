//
//  ScrollBaseViewController.h
//  iLunch
//
//  Created by James on 3/18/14.
//  Copyright (c) 2014 James. All rights reserved.
//

#import "BaseViewController.h"

@interface ScrollBaseViewController : BaseViewController<UIGestureRecognizerDelegate>
{
@protected
    __weak UIView *_scrollableView;
    UIView *_overlay;
    CGPoint _lastContentOffset;
    BOOL    _isCollapsed;
    BOOL    _isExpanded;
    UIPanGestureRecognizer     *_panGesture;
}

@property (nonatomic, weak)   UIView    *scrollableView;
@property (nonatomic, strong) UIView    *overlay;
@property (nonatomic, assign) CGPoint   lastContentOffset;
@property (nonatomic, assign) BOOL      isCollapsed;
@property (nonatomic, assign) BOOL      isExpanded;
@property (nonatomic, assign) BOOL      isPanVailed;
@property (strong, nonatomic) UIPanGestureRecognizer* panGesture;

- (UIView *)crateOverlay:(CGRect)frame;

- (void)followScrollView:(UIView *)scrollableView;

- (void)updateSizingWithDelta:(CGFloat)delta;

- (void)checkForPartialScrollEnd;


@end
