//
//  ShoppingCartView.h
//  iLunch
//
//  Created by James on 15-1-10.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCartView : UIView
{
    UIButton *_cart;
    UILabel  *_account;
    MenuButton *_order;
}

@property (nonatomic, copy) MenuAction orderAction;

- (instancetype)initWith:(CommonBlock)cartAction;

@end
