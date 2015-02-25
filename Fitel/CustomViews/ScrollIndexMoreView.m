//
//  ScrollIndexMoreView.m
//  iLunch
//
//  Created by James on 15-1-10.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import "ScrollIndexMoreView.h"

@interface ScrollIndexMoreView ()

@property (nonatomic, copy) CommonBlock likeAction;
@property (nonatomic, copy) CommonBlock moreAction;

@end

@implementation ScrollIndexMoreView

- (void)addLine
{
    
}

- (instancetype)initWithMenus:(NSArray *)array likeAction:(CommonBlock)like moreAction:(CommonBlock)action
{
    if (self = [super initWithMenus:array])
    {
        self.likeAction = like;
        self.moreAction = action;
    }
    return self;
}

- (void)addOwnViews
{
    [super addOwnViews];
    
    __weak typeof(self) ws = self;
    
    _like  = [[MenuButton alloc] initWithTitle:nil icon:[UIImage imageNamed:@"menu_icon_heart"] action:^(id<MenuAbleItem> menu) {
        [ws selectIndex:nil];
        if (ws.likeAction)
        {
            ws.likeAction(ws);
        }
        
    }];
    [self addSubview:_like];
    
    _more = [[MenuButton alloc] initWithTitle:nil icon:[UIImage imageNamed:@"menu_icon_all"] action:^(id<MenuAbleItem> menu) {
        if (ws.moreAction)
        {
            ws.moreAction(ws);
        }
    }];
    [_more setBackgroundImage:[UIImage imageNamed:@"pic_bg"] forState:UIControlStateNormal];
    [self addSubview:_more];
}

- (void)relayoutFrameOfSubViews
{
    CGRect bounds = self.bounds;
    
    [_more sizeWith:CGSizeMake(bounds.size.height, bounds.size.height)];
    [_more alignParentRight];
    
    [_like sameWith:_more];
    [_like layoutToLeftOf:_more];
    
    bounds.size.width -= 2*bounds.size.height;
    
    [self relayoutScrollView:bounds];
}


@end
