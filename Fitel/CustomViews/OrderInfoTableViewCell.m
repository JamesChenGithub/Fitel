//
//  OrderInfoTableViewCell.m
//  iLunch
//
//  Created by James on 15-1-17.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import "OrderInfoTableViewCell.h"

@implementation OrderShopInfoTableViewCell
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
    _shopInfo = [[HeaderTitleView alloc] init];
    [self.contentView addSubview:_shopInfo];
}

- (void)configOwnViews
{
    MenuItem *headInfo = [[MenuItem alloc] initWithTitle:@"地王大厦1818号" icon:[UIImage imageNamed:@"icon_shop1"] action:nil];
    [_shopInfo setHeadInfo:headInfo];
}

- (void)relayoutFrameOfSubViews
{
    [_shopInfo setFrameAndLayout:self.contentView.bounds];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self relayoutFrameOfSubViews];
}
@end

@implementation OrderAllItemInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.textLabel.textAlignment = NSTextAlignmentRight;
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.textLabel.textColor = kMainTextColor;
        self.backgroundColor = RGB(245, 245, 245);
        
        [self configOwnViews];
    }
    return self;
}

- (void)configOwnViews
{
    
    NSString *count = @"3";
    NSString *account = @"共  ￥45";
    
    NSString *info = [NSString stringWithFormat:@"%@  份美食  %@", count, account];
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:info];
    
    [attriString addAttribute:NSForegroundColorAttributeName value:kPriceTextColor range:NSMakeRange(0, count.length)];
    [attriString addAttribute:NSForegroundColorAttributeName value:kMainTextColor range:NSMakeRange(count.length, info.length - count.length - account.length)];
    [attriString addAttribute:NSForegroundColorAttributeName value:kPriceTextColor range:NSMakeRange(info.length - account.length, account.length)];
    
    self.textLabel.attributedText = attriString;
}

@end

@implementation OrderPaymentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        [self configOwnViews];
    }
    return self;
}

- (void)configOwnViews
{
    self.textLabel.text = @"支付方式";
}

@end

@implementation OrderPaymentWayTableViewCell

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
    _aliPayment = [[PaymentButton alloc] initAliPayment];
    [_aliPayment addTarget:self action:@selector(onClickPayment:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_aliPayment];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = kLightGrayColor;
    [self.contentView addSubview:_line];
    
    _wechatPayment = [[PaymentButton alloc] initWeChatPayment];
    [_wechatPayment addTarget:self action:@selector(onClickPayment:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_wechatPayment];
}

- (void)onClickPayment:(PaymentButton *)pay
{
    if (pay.selected)
    {
        return;
    }
    _wechatPayment.selected = pay == _wechatPayment;
    _aliPayment.selected = pay == _aliPayment;
}

- (void)configOwnViews
{
    _aliPayment.selected = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self relayoutFrameOfSubViews];
}

- (void)relayoutFrameOfSubViews
{
    CGRect bounds = self.contentView.bounds;
    bounds = CGRectInset(bounds, kDefaultMargin, 0);
    
    [_aliPayment sizeWith:CGSizeMake(bounds.size.width/2 - 2, bounds.size.height)];
 
    [_wechatPayment sameWith:_aliPayment];
    [_wechatPayment layoutToRightOf:_aliPayment margin:2];
    
    [_line sizeWith:CGSizeMake(1, bounds.size.height - kDefaultMargin * 2)];
    [_line layoutParentCenter];
}

@end
