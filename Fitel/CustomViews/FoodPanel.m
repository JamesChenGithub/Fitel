//
//  FoodPanel.m
//  iLunch
//
//  Created by James on 15-1-10.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import "FoodPanel.h"

@implementation FoodPanel

- (void)createButton:(MenuItem *)item
{
    ImageTitleButton *button = [[ImageTitleButton alloc] initWithStyle:EImageTopTitleBottom];
    [button setImage:[item icon] forState:UIControlStateNormal];
    [button setTitle:[item title] forState:UIControlStateNormal];
    [button setTitleColor:kMainTextColor forState:UIControlStateNormal];
    button.imageSize = [item icon].size;
    
    __weak typeof(self) ws = self;
    [button setClickAction:^(id<MenuAbleItem> menu) {
        [ws dismiss];
        [item menuAction];
    }];
    
    [_panel addSubview:button];
    [_foodButtons addObject:button];
}

- (instancetype)initWithMenus:(NSArray *)array
{
    if (self = [super init])
    {
        if (array.count)
        {
            _foodItems = [NSMutableArray arrayWithArray:array];
            
            _foodButtons = [NSMutableArray array];
            
            for (MenuItem *item in array)
            {
                [self createButton:item];
            }
        }
        
        self.backgroundColor = kAppModalDimbackgroundColor;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapBlank:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

- (void)onTapBlank:(UITapGestureRecognizer *)tap
{
    if (tap.state == UIGestureRecognizerStateEnded)
    {
        [self dismiss];
    }

}

- (void)show
{
    [self fadeIn:0.3 delegate:nil];
    
}

- (void)dismiss
{

    [UIView animateWithDuration:0.3 animations:^{
        [self fadeOut:0.3 delegate:nil];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)addOwnViews
{
    _panel = [[UIScrollView alloc] init];
    _panel.showsHorizontalScrollIndicator = NO;
    _panel.showsVerticalScrollIndicator = NO;
    _panel.backgroundColor = kWhiteColor;
    [self addSubview:_panel];
    
}

- (void)relayoutFrameOfSubViews
{
    CGRect rect = self.bounds;
    
    [_panel sizeWith:CGSizeMake(rect.size.width, 64*2)];
    
    [_panel gridViews:_foodButtons inColumn:5 size:CGSizeMake(64, 64) margin:CGSizeMake((self.bounds.size.width - 320)/4, 0) inRect:_panel.bounds];
    _panel.contentSize = CGSizeMake(0, 0);
}

@end
