//
//  ShoppingCartView.m
//  iLunch
//
//  Created by James on 15-1-10.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import "ShoppingCartView.h"

@interface ShoppingCartView ()

@property (nonatomic, copy) CommonBlock cartAction;

@end

@implementation ShoppingCartView

- (instancetype)initWith:(CommonBlock)cartAction
{
    if (self = [super init])
    {
        self.cartAction = cartAction;
        self.backgroundColor = [UIColor flatWhiteColor];
        self.layer.borderWidth = 1;
        self.layer.borderColor = kLightGrayColor.CGColor;
    }
    return self;
}

- (void)addOwnViews
{
    __weak typeof(self) ws = self;
    _cart = [[MenuButton alloc] initWithTitle:nil icon:[UIImage imageNamed:@"icon_shop"] action:^(id<MenuAbleItem> menu) {
        if (ws.cartAction)
        {
            ws.cartAction(ws);
        }
    }];
    [self addSubview:_cart];
    
    _account = [[UILabel alloc] init];
    [self addSubview:_account];
    
    _order = [[MenuButton alloc] init];
    [_order setBackgroundImage:[UIImage imageNamed:@"btn_ok"] forState:UIControlStateNormal];
    [_order setTitle:@"选好了" forState:UIControlStateNormal];
    [_order setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self addSubview:_order];
}

- (void)setOrderAction:(MenuAction)orderAction
{
    [_order setClickAction:orderAction];
}

- (void)configOwnViews
{
    NSString *sum = @"2份  合计  ";
    NSString *price = @"36元";
    
    NSString *info = [NSString stringWithFormat:@"%@%@", sum, price];
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:info];
    
    [attriString addAttribute:NSForegroundColorAttributeName value:kMainTextColor range:NSMakeRange(0, sum.length)];
    [attriString addAttribute:NSForegroundColorAttributeName value:kPriceTextColor range:NSMakeRange(sum.length, price.length)];

    _account.attributedText = attriString;
}

- (void)relayoutFrameOfSubViews
{
    CGRect rect = self.bounds;
    [_cart sizeWith:CGSizeMake(rect.size.height, rect.size.height)];
    
    UIImage *bg = [_order backgroundImageForState:UIControlStateNormal];
    
    [_order sizeWith:bg.size];
    [_order layoutParentVerticalCenter];
    [_order alignParentRightWithMargin:kDefaultMargin];
    
    [_account sameWith:_order];
    [_account layoutToRightOf:_cart margin:kDefaultMargin];
    [_account scaleToLeftOf:_order margin:kDefaultMargin];
}

@end
