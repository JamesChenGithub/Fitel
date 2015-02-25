//
//  ScrollBaseViewController.m
//  iLunch
//
//  Created by James on 3/18/14.
//  Copyright (c) 2014 James. All rights reserved.
//

#import "ScrollBaseViewController.h"

@interface ScrollBaseViewController ()


@end

@implementation ScrollBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _isExpanded = YES;
}

- (void)setBarTintColor
{
    if ([IOSDeviceConfig sharedConfig].isIOS7)
    {
        [self.overlay setBackgroundColor:self.navigationController.navigationBar.barTintColor];
    }
    else
    {
        [self.overlay setBackgroundColor:[UIColor orangeColor]];
    }
}

- (void)followScrollView:(UIView *)scrollableView
{
    if (self.scrollableView)
    {
        [self.scrollableView removeGestureRecognizer:self.panGesture];
    }
	self.scrollableView = scrollableView;
	self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
	[self.panGesture setMaximumNumberOfTouches:1];
	[self.panGesture setDelegate:self];
	[self.scrollableView addGestureRecognizer:self.panGesture];
    
	CGRect frame = self.navigationController.navigationBar.frame;
	frame.origin = CGPointZero;
    
	self.overlay = [self crateOverlay:frame];
    
    [self configOverlay];
}

- (UIView *)crateOverlay:(CGRect)frame
{
    return [[UIView alloc] initWithFrame:frame];
}

- (void)configOverlay
{
    [self setBarTintColor];
    
	
	[self.overlay setUserInteractionEnabled:NO];
	[self.navigationController.navigationBar addSubview:self.overlay];
	[self.overlay setAlpha:0];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

//- (CGFloat)statusHeight
//{
//    BOOL isStatusHidden = [IOSDeviceConfig sharedConfig].isIOS6 ? [UIApplication sharedApplication].statusBarHidden : [self prefersStatusBarHidden];
//    return isStatusHidden ? 0 : 20;
//}
//
//- (CGFloat)offset
//{
//    BOOL isStatusHidden = [IOSDeviceConfig sharedConfig].isIOS6 ? [UIApplication sharedApplication].statusBarHidden : [self prefersStatusBarHidden];
//    return isStatusHidden ? 44 : 24;
//}

//#define kOffset [self offset]
//#define kStatusHeight [self statusHeight]

#define kOffset 44
#define kStatusHeight 0

//// 显示状态栏时
//#define kOffset 24
//#define kStatusHeight 20

- (void)onScrollUp:(CGFloat)delta
{
    CGRect frame;
    if (self.isCollapsed)
    {
        return;
    }
    
    frame = self.navigationController.navigationBar.frame;
    
    if (frame.origin.y - delta < -kOffset)
    {
        delta = frame.origin.y + kOffset;
    }
    
    frame.origin.y = MAX(-kOffset, frame.origin.y - delta);
    self.navigationController.navigationBar.frame = frame;
    
    if (frame.origin.y == -kOffset)
    {
        self.isCollapsed = YES;
        self.isExpanded = NO;
    }
    
    [self updateSizingWithDelta:delta];
    
    if ([self.scrollableView isKindOfClass:[UIScrollView class]])
    {
        [(UIScrollView*)self.scrollableView setContentOffset:CGPointMake(((UIScrollView*)self.scrollableView).contentOffset.x, ((UIScrollView*)self.scrollableView).contentOffset.y - delta)];
    }
}

- (void)onScrollDown:(CGFloat)delta
{
    CGRect frame;
    if (self.isExpanded)
    {
        return;
    }
    
    frame = self.navigationController.navigationBar.frame;
    
    if (frame.origin.y - delta > kStatusHeight)
    {
        delta = frame.origin.y - kStatusHeight;
    }
    frame.origin.y = MIN(kStatusHeight, frame.origin.y - delta);
    self.navigationController.navigationBar.frame = frame;
    
    if (frame.origin.y == kStatusHeight)
    {
        self.isExpanded = YES;
        self.isCollapsed = NO;
    }
    
    [self updateSizingWithDelta:delta];
}

#define kScrollHorOffset 20

- (void)handlePan:(UIPanGestureRecognizer *)gesture
{
    switch (gesture.state)
    {
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [gesture translationInView:[self.scrollableView superview]];
            float delta = self.lastContentOffset.y - translation.y;
            self.lastContentOffset = translation;
            
            if (delta == 0)
            {
                return;
            }
            
            if (delta > 0)
            {
                [self onScrollUp:delta];
            }
            else
            {
                [self onScrollDown:delta];
            }
        }
            
            break;
        case UIGestureRecognizerStateEnded:
        {
            self.lastContentOffset = CGPointZero;
            [self checkForPartialScroll];
        }
            break;
        default:
            break;
    }
    
}

- (void)checkForPartialScrollEnd
{
    
}

- (void)checkForPartialScroll
{
	CGFloat pos = self.navigationController.navigationBar.frame.origin.y;
	__block CGFloat delta = 0;
	// Get back down
	if (pos >= -2)
    {
		[UIView animateWithDuration:0.2 animations:^{
			CGRect frame;
			frame = self.navigationController.navigationBar.frame;
            delta = frame.origin.y - kStatusHeight;
			frame.origin.y = MIN(kStatusHeight, frame.origin.y - delta);
			self.navigationController.navigationBar.frame = frame;
			
			self.isExpanded = YES;
			self.isCollapsed = NO;
		} completion:^(BOOL finished) {
            [self updateSizingWithDelta:delta];
            [self checkForPartialScrollEnd];
        }];
	}
    else
    {
		// And back up
		[UIView animateWithDuration:0.2 animations:^{
			CGRect frame;
			frame = self.navigationController.navigationBar.frame;
			CGFloat delta = frame.origin.y + kOffset;
			frame.origin.y = MAX(-kOffset, frame.origin.y - delta);
			self.navigationController.navigationBar.frame = frame;
			
			self.isExpanded = NO;
			self.isCollapsed = YES;
		} completion:^(BOOL finished) {
            [self updateSizingWithDelta:delta];
            [self checkForPartialScrollEnd];
        }];
	}
}


- (void)updateSizingWithDelta:(CGFloat)delta
{
    DebugLog(@"delta = %f", delta);
    
	CGRect frame = self.navigationController.navigationBar.frame;
	
	float alpha = (frame.origin.y + kOffset) / frame.size.height;
	[self.overlay setAlpha:1 - alpha];
	self.navigationController.navigationBar.tintColor = [self.navigationController.navigationBar.tintColor colorWithAlphaComponent:alpha];
	
    
    UIView *scrollSuperView = self.scrollableView.superview;
	frame = scrollSuperView.frame;
	frame.origin.y = self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height;
	frame.size.height = frame.size.height + delta;
	scrollSuperView.frame = frame;
	
	frame = self.scrollableView.layer.frame;
	frame.size.height += delta;
	self.scrollableView.layer.frame = frame;
    self.scrollableView.frame = frame;
}

@end
