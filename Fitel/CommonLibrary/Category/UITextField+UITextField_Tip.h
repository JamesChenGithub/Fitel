//
//  UITextField+UITextField_Tip.h
//  iLunch
//
//  Created by James on 15-1-7.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (UITextField_Tip)

- (void)addLeftTip:(NSString *)left;

- (void)addRightTip:(NSString *)right action:(CommonBlock)action;

- (void)addRightImage:(UIImage *)right action:(CommonBlock)action;

- (instancetype)initLeftWith:(NSString *)left;

- (instancetype)initLeftIconWith:(UIImage *)left;

- (instancetype)initLeftWith:(NSString *)left rightWith:(NSString *)right;

- (instancetype)initLeftWith:(NSString *)left rightWith:(NSString *)right action:(CommonBlock)action;

- (instancetype)initLeftWith:(NSString *)left rightImageWith:(UIImage *)right action:(CommonBlock)action;


@end
