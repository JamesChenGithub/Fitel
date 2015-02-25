//
//  DateSearchBar.m
//  iLunch
//
//  Created by James on 15-1-20.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import "DateSearchBar.h"

@implementation DateSearchBar

- (void)addOwnViews
{
    _date = [[UIButton alloc] init];
    [_date setImage:[UIImage imageNamed:@"icon_calendar"] forState:UIControlStateNormal];
    [_date addTarget:self action:@selector(onClickDate:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_date];
    
    
    _searchBg = [[UIImageView alloc] init];
    _searchBg.image = [UIImage imageNamed:@"bg_search_s"];
    _searchBg.userInteractionEnabled = YES;
    [self addSubview:_searchBg];
    

    
    UIButton *searchButton = [[UIButton alloc] init];
    UIImage *img = [UIImage imageNamed:@"btn_search1"];
    [searchButton setImage:img forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(onSearch:) forControlEvents:UIControlEventTouchUpInside];
    searchButton.frame = CGRectFromCGSize(img.size);
    _search = [[UITextField alloc] init];
    _search.delegate = self;
    _search.rightViewMode = UITextFieldViewModeAlways;
    _search.returnKeyType = UIReturnKeySearch;
    _search.rightView = searchButton;
    _search.placeholder = @"请输入订单号或菜品";
    [_searchBg addSubview:_search];
    
}



- (void)configOwnViews
{
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [self onSearch:nil];
    return YES;
}

- (void)onSearch:(UIButton *)button
{
    DebugLog(@"- (void)onSearch:(UIButton *)button");
    [_search resignFirstResponder];
    
    if (![NSString isEmpty:_search.text])
    {
        if ([_delegate respondsToSelector:@selector(onDateSearchBar:searchText:)])
        {
            [_delegate onDateSearchBar:self searchText:_search.text];
        }
    }
    
    
}
- (void)onClickDate:(UIButton *)button
{
    DebugLog(@"- (void)onClickDate:(UIButton *)button");
    if ([_delegate respondsToSelector:@selector(onDateSearchBar:clickDate:)])
    {
        [_delegate onDateSearchBar:self clickDate:button];
    }
}

- (void)relayoutFrameOfSubViews
{
    [_date sizeWith:[_date imageForState:UIControlStateNormal].size];
    [_date alignParentLeftWithMargin:kDefaultMargin];
    [_date layoutParentVerticalCenter];
    
    CGSize size = _searchBg.image.size;
    
    [_searchBg sizeWith:size];
    [_searchBg layoutParentVerticalCenter];
    [_searchBg layoutToRightOf:_date margin:kDefaultMargin];
    [_searchBg scaleToParentRightWithMargin:kDefaultMargin];
    
    [_search sizeWith:CGSizeMake(size.width - 15, 30)];
    [_search alignParentLeftWithMargin:15];
    [_search layoutParentVerticalCenter];
}

@end
