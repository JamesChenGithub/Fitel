
//
//  PaymentButton.m
//  iLunch
//
//  Created by James on 15-1-17.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import "PaymentButton.h"

@implementation PaymentButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _payCheck = [[UIImageView alloc] init];
        _payCheck.image = [UIImage imageNamed:@"unchecked"];
        _payCheck.highlightedImage = [UIImage imageNamed:@"checked"];
        [self addSubview:_payCheck];
    }
    return self;
}

- (instancetype)initAliPayment
{
    if (self = [super init])
    {
        [self setImage:[UIImage imageNamed:@"icon_alipay"] forState:UIControlStateNormal];
        [self setTitle:@"支付宝" forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}
- (instancetype)initWeChatPayment
{
    if (self = [super init])
    {
        [self setImage:[UIImage imageNamed:@"icon_wechat"] forState:UIControlStateNormal];
        [self setTitle:@"微信支付" forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}



- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    _payCheck.highlighted = selected;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self relayoutFrameOfSubViews];
}

- (void)relayoutFrameOfSubViews
{
    CGRect rect = self.bounds;
    
    [_payCheck sizeWith:_payCheck.image.size];
    [_payCheck alignParentRight];
    [_payCheck layoutParentVerticalCenter];
    
    rect.size.width -= _payCheck.image.size.width;
    
    
    UIImage *img = [self imageForState:UIControlStateNormal];
    CGSize titleSize = [self.titleLabel textSizeIn:rect.size];
    
    CGFloat width = img.size.width + kDefaultMargin + titleSize.width + 2;
    
    rect = CGRectInset(rect, (rect.size.width - width)/2, 0);
    
    CGRect imgRect = rect;
    imgRect.origin.y += (rect.size.height - img.size.height)/2;
    imgRect.size= img.size;
    
    self.imageView.frame = imgRect;
    rect.origin.x += img.size.width + kDefaultMargin;
    rect.size.width -= img.size.width + kDefaultMargin;
    self.titleLabel.frame = rect;
}

@end
