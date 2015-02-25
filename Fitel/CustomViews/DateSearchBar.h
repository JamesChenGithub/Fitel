//
//  DateSearchBar.h
//  iLunch
//
//  Created by James on 15-1-20.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DateSearchBar;

@protocol DateSearchBarDelegate <NSObject>

- (void)onDateSearchBar:(DateSearchBar *)bar clickDate:(UIButton *)date;

- (void)onDateSearchBar:(DateSearchBar *)bar searchText:(NSString *)search;

@end

@interface DateSearchBar : UIView<UITextFieldDelegate>
{
    UIButton    *_date;
    UIImageView *_searchBg;
    UITextField *_search;
}

@property (nonatomic, weak) id<DateSearchBarDelegate> delegate;

@end
