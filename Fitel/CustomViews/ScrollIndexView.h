//
//  ScrollIndexView.h
//  iLunch
//
//  Created by James on 15-1-10.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef BOOL (^WillClickIndexHandler) (id<MenuAbleItem> item);

@interface ScrollIndexView : UIView
{
    UIScrollView *_scrollView;

    NSMutableArray *_menus;
    
    NSMutableArray *_menuButtons;
    NSMutableArray *_splitLines;
    
    SegButton *_selectedIndex;
    
}

@property (nonatomic, copy) WillClickIndexHandler willClick;

- (instancetype)initWithMenus:(NSArray *)array;

- (void)createWith:(MenuItem *)item needLine:(BOOL)need;

- (void)selectIndex:(UIButton *)button;

- (void)selectIndexOf:(NSInteger)index;

- (void)relayoutScrollView:(CGRect)rect;

- (NSInteger)index;


// protected
- (void)addLine;

@end
