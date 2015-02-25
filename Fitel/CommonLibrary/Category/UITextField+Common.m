//
//  UITextField+Common.m
//  TCLSales
//
//  Created by 陈耀武 on 14-1-17.
//  Copyright (c) 2014年 iLunch. All rights reserved.
//

#import "UITextField+Common.h"

@implementation UITextField (Common)

+ (instancetype)textFieldWithTip:(NSString *)tip size:(CGSize)tipSize;
{
    UITextField *input = [[UITextField alloc] init];
    input.backgroundColor = [UIColor clearColor];
    input.textAlignment = NSTextAlignmentLeft;
    input.keyboardType = UIKeyboardTypeDefault;
    input.returnKeyType = UIReturnKeyDone;
    input.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    input.borderStyle = UITextBorderStyleNone;
    input.font = [[FontHelper shareHelper] textFont];
    
    input.leftViewMode = UITextFieldViewModeAlways;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tipSize.width, tipSize.height)];
    label.text = tip;
    label.backgroundColor = [UIColor clearColor];
    input.leftView = label;
    label.textAlignment = NSTextAlignmentRight;
    label.font = [[FontHelper shareHelper] textFont];
    CommonRelease(label);
    
    return CommonReturnAutoReleased(input);

}

@end
