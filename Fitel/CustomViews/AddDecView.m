//
//  AddDecView.m
//  iLunch
//
//  Created by James on 15-1-9.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import "AddDecView.h"

@implementation AddDecView

#define kDefaultSize CGSizeMake(94, 28)

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:CGRectFromCGSize(kDefaultSize)]) {
        
    }
    return self;
}


- (void)addOwnViews
{
    _editBg = [[UIImageView alloc] init];
    _editBg.image = [UIImage imageNamed:@"number_edit_bg"];
    _editBg.userInteractionEnabled = YES;
    [self addSubview:_editBg];
    
    _dec = [[UIButton alloc] init];
    [_dec setImage:[UIImage imageNamed:@"btn_red00"] forState:UIControlStateNormal];
    [_dec setImage:[UIImage imageNamed:@"btn_red01"] forState:UIControlStateSelected];
    [_dec addTarget:self action:@selector(onDec) forControlEvents:UIControlEventTouchUpInside];
    [_editBg addSubview:_dec];
    
    _number = [[UITextField alloc] init];
    _number.borderStyle = UITextBorderStyleNone;
    _number.font = [UIFont systemFontOfSize:13];
    _number.textAlignment = NSTextAlignmentCenter;
    _number.keyboardType = UIKeyboardTypePhonePad;
    _number.enabled = NO;
    [_editBg addSubview:_number];
    
    _add = [[UIButton alloc] init];
    [_add setImage:[UIImage imageNamed:@"btn_add00"] forState:UIControlStateNormal];
    [_add setImage:[UIImage imageNamed:@"btn_add01"] forState:UIControlStateSelected];
    [_add addTarget:self action:@selector(onAdd) forControlEvents:UIControlEventTouchUpInside];
    [_editBg addSubview:_add];
}

- (void)relayoutFrameOfSubViews
{
    _editBg.frame = self.bounds;
    
    [_dec sizeWith:[_dec imageForState:UIControlStateNormal].size];
    
    [_add sizeWith:[_add imageForState:UIControlStateNormal].size];
    [_add alignParentRight];
    
    [_number sameWith:_dec];
    [_number layoutToRightOf:_dec];
    [_number scaleToLeftOf:_add];
}

- (void)setNumberValue:(NSInteger)numberValue
{
    if (numberValue >= 1)
    {
        _number.text = [NSString stringWithFormat:@"%ld", numberValue];
    }
}

- (NSInteger)numberValue
{
    return _number.text.integerValue;
}

- (void)onDec
{
    NSInteger integer = _number.text.integerValue;
    if (integer > 1)
    {
        _number.text = [NSString stringWithFormat:@"%ld", --integer];
    }
}

- (void)onAdd
{
    NSInteger integer = _number.text.integerValue;
    _number.text = [NSString stringWithFormat:@"%ld", ++integer];
    
}

@end
