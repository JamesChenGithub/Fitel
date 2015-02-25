//
//  ScrollIndexView.m
//  iLunch
//
//  Created by James on 15-1-10.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import "ScrollIndexView.h"

@implementation ScrollIndexView

- (void)createWith:(MenuItem *)item needLine:(BOOL)need
{
    SegButton *button = [[SegButton alloc] initWithMenu:item];
    
    __weak typeof(self) ws = self;
    
    button.selectAction = ^(SegButton *but) {
        [ws selectIndex:but];
    };
    [_scrollView addSubview:button];
    [_menuButtons addObject:button];
    
    if (need)
    {
        [self addLine];
    }
}

- (void)addLine
{
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = kLightGrayColor;
    
    [_scrollView addSubview:line];
    
    [_splitLines addObject:line];
}

- (instancetype)initWithMenus:(NSArray *)array
{
    if (self = [super init])
    {
        if (array.count)
        {
            _menuButtons = [NSMutableArray array];
            _splitLines = [NSMutableArray array];
            
            _menus = [NSMutableArray arrayWithArray:array];
            
            NSInteger count = array.count;
            for (id<MenuAbleItem> item in array)
            {
                NSInteger index = [array indexOfObject:item];
                BOOL need = index != count-1;
                [self createWith:item needLine:need];
            }
            
            [self selectIndex:_menuButtons[0]];
        }
        
    }
    return self;
}

- (NSInteger)index
{
    return [_menuButtons indexOfObject:_selectedIndex];
}

- (void)addOwnViews
{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor flatWhiteColor];
    [self addSubview:_scrollView];
}

- (void)selectIndexOf:(NSInteger)index
{
    if (index >= 0 && index < _menuButtons.count)
    {
        SegButton *btn = _menuButtons[index];
        [btn onClick:btn];
    }
}

- (void)selectIndex:(SegButton *)button
{
    BOOL handleNext = YES;
    NSInteger index = [_menuButtons indexOfObject:button];
    if (_willClick)
    {
        id<MenuAbleItem> item = _menus[index];
        handleNext = _willClick(item);
    }
    if (handleNext)
    {
        if (button == _selectedIndex)
        {
            return;
        }
        
        _selectedIndex.selected = NO;
        _selectedIndex = button;
        _selectedIndex.selected = YES;
        
        MenuItem *item = _menus[index];
        [item menuAction];
    }
    
}

#define kMinIndexWidth 80

- (void)relayoutScrollView:(CGRect)rect
{
    _scrollView.frame = rect;
    
    CGRect bounds = _scrollView.bounds;
    
    NSInteger menuCount = _menuButtons.count;
    NSInteger lineCount = _splitLines.count;
    
    if (menuCount)
    {
        CGFloat kWidth = bounds.size.width / _menuButtons.count;
        
        BOOL isScroll = kWidth <= kMinIndexWidth;
        kWidth = kWidth <= kMinIndexWidth ? kMinIndexWidth : kWidth;
        
        
        _scrollView.contentSize = isScroll ? CGSizeMake(kWidth * _menuButtons.count, 0) : CGSizeMake(0, 0);
        
        CGRect rect = bounds;
        rect.size.width = kWidth;
        for (NSInteger i = 0; i < menuCount; i++)
        {
            UIButton *button = _menuButtons[i];
            button.frame = rect;
            rect.origin.x += kWidth;
        }
        
        for (NSInteger i = 0; i < lineCount; i++)
        {
            UIButton *btn = _menuButtons[i];
            UIView *view = _splitLines[i];
            
            [view sizeWith:CGSizeMake(1, btn.frame.size.height - kDefaultMargin*2)];
            [view layoutParentVerticalCenter];
            [view layoutToRightOf:btn];
        }
        
    }

}

- (void)relayoutFrameOfSubViews
{
    CGRect bounds = self.bounds;
    [self relayoutScrollView:CGRectInset(bounds, 0, 1)];
}

@end
