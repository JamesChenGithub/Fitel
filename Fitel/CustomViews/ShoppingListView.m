//
//  ShoppingListView.m
//  iLunch
//
//  Created by James on 15-1-10.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import "ShoppingListView.h"

@implementation ShoppingListView

- (NSInteger)listCount
{
    return 2;
}

- (CGFloat)listItemHeight
{
    return 50;
}

- (void)addOwnViews
{
    _back = [[UIButton alloc] init];
    [_back addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_back];
    
    _tableView = [[UITableView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self addSubview:_tableView];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapBlank:)];
//    tap.numberOfTapsRequired = 1;
//    tap.numberOfTouchesRequired = 1;
//    [self addGestureRecognizer:tap];
    
    self.backgroundColor = kAppModalDimbackgroundColor;
}

- (void)onTapBlank:(UIGestureRecognizer *)tap
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

- (void)relayoutFrameOfSubViews
{
    CGRect rect = self.bounds;
    
    _back.frame = rect;
    
    NSInteger kCellheight = (NSInteger) [self listItemHeight];
    NSInteger kCount = [self listCount];
    
    NSInteger maxLine = ((NSInteger)(rect.size.height * 2 / 3))/(kCellheight);
    
    
    BOOL scroll = maxLine >= kCount;
    kCount = maxLine < kCount ? maxLine : kCount;

    [_tableView sizeWith:CGSizeMake(rect.size.width, kCellheight * kCount)];
    [_tableView alignParentBottom];
    
    if (!scroll)
    {
        _tableView.contentSize = CGSizeMake(0, 0);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self listCount];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self listItemHeight];
}

#define kFoodShoppingCartTableViewCell @"FoodShoppingCartTableViewCell"
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FoodShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFoodShoppingCartTableViewCell];
    if (!cell)
    {
        cell = [[FoodShoppingCartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kFoodShoppingCartTableViewCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
