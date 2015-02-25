//
//  UITextField+UITextField_Tip.m
//  iLunch
//
//  Created by James on 15-1-7.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import "UITextField+UITextField_Tip.h"

@implementation UITextField (UITextField_Tip)

//- (instancetype)init
//{
//    if (self = [super initWithFrame:CGRectZero])
//    {
//        self.font = [UIFont systemFontOfSize:14];
//    }
//    return self;
//}

- (void)addLeftTip:(NSString *)left
{
    self.leftViewMode = UITextFieldViewModeAlways;
    
    UILabel *lb= [UILabel labelWith:left];
    lb.textColor = kMainTextColor;
    lb.font = [UIFont systemFontOfSize:14];
    CGSize size = [lb textSizeIn:CGSizeMake(320, 320)];
    lb.frame = CGRectFromCGSize(size);
    self.leftView = lb;
}


- (void)addLeftIcon:(UIImage *)left
{
    self.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *lb= [[UIImageView alloc] init];
    lb.image = left;
    lb.frame = CGRectFromCGSize(left.size);
    self.leftView = lb;
}

- (void)addRightTip:(NSString *)right action:(CommonBlock)action
{
    self.rightViewMode = UITextFieldViewModeAlways;
    
    MenuButton *btn = nil;
    
    if (action)
    {
        __weak typeof(self) ws = self;
        btn = [[MenuButton alloc] initWithTitle:right action:^(id<MenuAbleItem> menu) {
            action(ws);
        }];
    }
    else
    {
        btn = [[MenuButton alloc] initWithTitle:right action:nil];
    }

    CGSize size = [btn.titleLabel textSizeIn:CGSizeMake(320, 320)];
    size.width += 16;
    btn.frame = CGRectFromCGSize(size);
    self.rightView = btn;
}

- (void)addRightImage:(UIImage *)right action:(CommonBlock)action
{
    self.rightViewMode = UITextFieldViewModeAlways;
    
    MenuButton *btn = nil;

    if (action)
    {
        __weak typeof(self) ws = self;
        btn = [[MenuButton alloc] initWithTitle:nil icon:right action:^(id<MenuAbleItem> menu) {
            action(ws);
        }];
    }
    else
    {
        btn = [[MenuButton alloc] initWithTitle:nil icon:right action:nil];
    }
    CGSize size = right.size;
    size.width += 16;
    btn.frame = CGRectFromCGSize(size);
    self.rightView = btn;
}

- (instancetype)initLeftWith:(NSString *)left
{
    if (self = [self init])
    {
        self.font = [UIFont systemFontOfSize:14];
        [self addLeftTip:left];
    }
    return self;
}

- (instancetype)initLeftIconWith:(UIImage *)left
{
    if (self = [self init])
    {
        [self addLeftIcon:left];
    }
    return self;
}

- (instancetype)initLeftWith:(NSString *)left rightWith:(NSString *)right
{
    return [self initLeftWith:left rightWith:right action:nil];
}

- (instancetype)initLeftWith:(NSString *)left rightWith:(NSString *)right action:(CommonBlock)action
{
    if (self = [self initLeftWith:left])
    {
        [self addRightTip:right action:action];
    }
    return self;
}

- (instancetype)initLeftWith:(NSString *)left rightImageWith:(UIImage *)right action:(CommonBlock)action
{
    if (self = [self initLeftWith:left])
    {
        [self addRightImage:right action:action];
    }
    return self;
}

@end
