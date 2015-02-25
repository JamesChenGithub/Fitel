//
//  UILabel+UILabel_Common.h
//  TCLSales
//
//  Created by ken liu on 14-1-18.
//  Copyright (c) 2014年 iLunch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Common)


+ (instancetype)label;

+ (instancetype)labelWithTitle:(NSString *)title;

- (CGSize)contentSize;

- (CGSize)textSizeIn:(CGSize)size;

@end
