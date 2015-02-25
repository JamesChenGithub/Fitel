//
//  CheckButton.h
//  TCLSales
//
//  Created by 陈耀武 on 14-1-19.
//  Copyright (c) 2014年 iLunch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CheckButton;

typedef void (^CheckButtonAction)(CheckButton *btn);

@interface CheckButton : UIControl

@property (nonatomic, strong) MenuButton *button;
@property (nonatomic, strong) UILabel *title;

@property (nonatomic, assign) BOOL isCheck;

@property (nonatomic, copy) CheckButtonAction checkAction;


- (instancetype)initNormal:(UIImage *)image selectedImage:(UIImage *)simage title:(NSString *)title checkAction:(CheckButtonAction)action;

@end
