//
//  PaymentButton.h
//  iLunch
//
//  Created by James on 15-1-17.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentButton : MenuButton
{
    UIImageView *_payCheck;
}

- (instancetype)initAliPayment;
- (instancetype)initWeChatPayment;

@end
