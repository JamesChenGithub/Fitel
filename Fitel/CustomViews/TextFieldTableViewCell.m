//
//  TextFieldTableViewCell.m
//  iLunch
//
//  Created by James on 15-1-7.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import "TextFieldTableViewCell.h"

@implementation AddNewAddressGenderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        UIImage *uncheck = kAddressManage_Gender_Uncheck_Icon;
        UIImage *check = kAddressManage_Gender_Checked_Icon;
        
        _male = [[ImageTitleButton alloc] initWithStyle:EImageLeftTitleRightCenter];
        [_male setImage:uncheck forState:UIControlStateNormal];
        [_male setImage:check forState:UIControlStateSelected];
        _male.imageSize = uncheck.size;
        [_male setTitleColor:kBlackColor forState:UIControlStateNormal];
        [_male setTitle:@"先生" forState:UIControlStateNormal];
        [_male addTarget:self action:@selector(onCheck:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_male];
        
        _line = [[UIImageView alloc] init];
        _line.backgroundColor = kLightGrayColor;
        [self.contentView addSubview:_line];
        
        _female = [[ImageTitleButton alloc] initWithStyle:EImageLeftTitleRightCenter];
        [_female setImage:uncheck forState:UIControlStateNormal];
        [_female setImage:check forState:UIControlStateSelected];
        _female.imageSize = uncheck.size;
        [_female setTitleColor:kBlackColor forState:UIControlStateNormal];
        [_female setTitle:@"女士" forState:UIControlStateNormal];
        [_female addTarget:self action:@selector(onCheck:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_female];
    }
    return self;
}

- (void)onCheck:(UIButton *)button
{
    if (button == _male)
    {
        _female.selected = NO;
        if (!_male.selected)
        {
            _male.selected = YES;
        }
    }
    else
    {
        _male.selected = NO;
        if (!_female.selected)
        {
            _female.selected = YES;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self relayoutFrameOfSubViews];
}

- (void)relayoutFrameOfSubViews
{
    CGRect bounds = self.contentView.bounds;
    
    [_line sizeWith:CGSizeMake(1, bounds.size.height - 10)];
    [_line layoutParentCenter];
    
    [_male sizeWith:CGSizeMake(100, bounds.size.height)];
    [_male layoutToLeftOf:_line margin:5];
    
    [_female sameWith:_male];
    [_female layoutToRightOf:_line margin:5];
}

@end

@implementation TextFieldTableViewCell

- (instancetype)initWith:(NSString *)tip reuseIdentifier:(NSString *)reuseIdentifier
{
    return [self initWith:tip placeHolder:nil reuseIdentifier:reuseIdentifier];
}

- (instancetype)initWith:(NSString *)tip placeHolder:(NSString *)holder reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])
    {
        _edit = [[UITextField alloc] initLeftWith:tip];
        _edit.placeholder = holder;
        [self.contentView addSubview:_edit];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (instancetype)initWith:(NSString *)tip placeHolder:(NSString *)holder locateIcon:(UIImage *)icon reuseIdentifier:(NSString *)reuseIdentifier
{
    return [self initWith:tip placeHolder:holder locateIcon:icon action:nil reuseIdentifier:reuseIdentifier];
}
- (instancetype)initWith:(NSString *)tip placeHolder:(NSString *)holder locateIcon:(UIImage *)icon action:(CommonBlock)act reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])
    {
        _edit = [[UITextField alloc] initLeftWith:tip rightImageWith:icon action:act];
        _edit.placeholder = holder;
        [self.contentView addSubview:_edit];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self relayoutFrameOfSubViews];
}

- (void)relayoutFrameOfSubViews
{
    CGRect bounds = self.contentView.bounds;
    _edit.frame = CGRectInset(bounds, 6, 3);
}

@end

