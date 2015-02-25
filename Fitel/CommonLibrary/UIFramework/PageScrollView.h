//
//  PageScrollView.h
//  iLunch
//
//  Created by James Chen on 3/5/13.
//  Copyright (c) 2013 ken liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PageScrollView;

@protocol PageScrollViewDelegate <NSObject>

//- (void)onPageScrollView:(PageScrollView *)pageView scrollTransitionTo:(UIScrollView *)scrollView;
- (void)onPageScrollView:(PageScrollView *)pageView scrollToPage:(NSInteger)pageIndex;

@end


@interface PageScrollView : UIView<UIScrollViewDelegate>
{
@protected
    CGPoint         _startOffset;
    CGPoint         _startPoint;
    CGPoint         _endPoint;
    NSInteger       _pageIndex;
    BOOL            _pageControlUsed;
    UIPageControl  *_pageControl;
    UIScrollView   *_scrollView;
    NSMutableArray *_pages;
    __unsafe_unretained id<PageScrollViewDelegate> _delegate;
}


@property (nonatomic, strong) UIScrollView      *scrollView;

@property (nonatomic, strong) NSArray    *pages;

@property (nonatomic, unsafe_unretained) id<PageScrollViewDelegate> delegate;

@property (nonatomic, readonly) UIPageControl *pageControl;

@property (nonatomic, assign) NSInteger pageIndex;



// 设置相应的内容并且重新布局
- (void)setFrameAndLayout:(CGRect)rect withPages:(NSArray *)pages;

- (void)scrollTo:(NSInteger)pageIndex;

- (NSInteger)pageCount;

- (void)changeToPage:(NSInteger)page manual:(BOOL)isManual;

@end
