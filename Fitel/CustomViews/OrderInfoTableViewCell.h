//
//  OrderInfoTableViewCell.h
//  iLunch
//
//  Created by James on 15-1-17.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderShopInfoTableViewCell : UITableViewCell
{
    HeaderTitleView *_shopInfo;
}

@end

@interface OrderAllItemInfoTableViewCell : UITableViewCell

@end

@interface OrderPaymentTableViewCell : UITableViewCell

@end

@interface OrderPaymentWayTableViewCell : UITableViewCell
{
    PaymentButton *_aliPayment;
    UIView *_line;
    PaymentButton *_wechatPayment;
}

@end
