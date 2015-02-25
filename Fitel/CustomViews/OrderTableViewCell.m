//
//  OrderTableViewCell.m
//  iLunch
//
//  Created by James on 15-1-20.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTitleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self addOwnViews];
        [self configOwnViews];
    }
    return self;
}

- (void)addOwnViews
{
    _orderNum = [[UILabel alloc] init];
    _orderNum.font = [UIFont systemFontOfSize:14];
    _orderNum.textAlignment = NSTextAlignmentLeft;
    _orderNum.textColor = kDarkGrayColor;
    [self.contentView addSubview:_orderNum];
    
    
    _orderDate = [[UILabel alloc] init];
    _orderDate.font = [UIFont systemFontOfSize:14];
    _orderDate.textAlignment = NSTextAlignmentRight;
    _orderDate.textColor = kDarkGrayColor;
    [self.contentView addSubview:_orderDate];
}

- (void)configOwnViews
{
    _orderNum.text = @"订单号：123412341234123412";
    _orderDate.text = @"12-12 14:14";
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self relayoutFrameOfSubViews];
}

- (void)relayoutFrameOfSubViews
{
    CGRect rect = self.contentView.bounds;
    rect = CGRectInset(rect, kDefaultMargin, 0);
    
    [_orderNum sizeWith:CGSizeMake(rect.size.width * 2 / 3, rect.size.height)];
    [_orderNum alignParentLeftWithMargin:kDefaultMargin];
    
    [_orderDate sizeWith:CGSizeMake(rect.size.width / 3, rect.size.height)];
    [_orderDate alignParentRightWithMargin:kDefaultMargin];
}

@end

@implementation OrderContatTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.textLabel.textColor = kDarkGrayColor;
        self.imageView.image = [UIImage imageNamed:@"icon_user"];
        
        [self configOwnViews];
    }
    return self;
}

- (void)configOwnViews
{
    self.textLabel.text = @"黄小明";
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self relayoutFrameOfSubViews];
}


- (void)relayoutFrameOfSubViews
{
    [self.imageView alignParentLeftWithMargin:kDefaultMargin];
    [self.textLabel layoutToRightOf:self.imageView];
}


@end
