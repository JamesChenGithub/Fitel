//
//  UITextView+PlaceHolder.m
//  iLunch
//
//  Created by James on 15-1-11.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import "UIPlaceHolderTextView.h"


@implementation UIPlaceHolderTextView

- (void)dealloc
{
    [self removeobserver];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        [self addObserver];
    }
    return self;
}




-(void)addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginOfEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endOfEditing:) name:UITextViewTextDidEndEditingNotification object:self];
}

-(void)removeobserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark Setter/Getters
- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = placeHolder;
    [self endOfEditing:nil];
}

- (NSString *)text
{
    NSString *text = [super text];
    if ([text isEqualToString:_placeHolder])
    {
        return nil;
    }
    return text;
}

- (void)beginOfEditing:(NSNotification *)notification
{
    if ([super.text isEqualToString:_placeHolder])
    {
        super.text = nil;
        //字体颜色
        [super setTextColor:kLightGrayColor];
    }
//    else
//    {
//        [super setTextColor:kBlackColor];
//    }
    
}

- (void)endOfEditing:(NSNotification *)notification
{
    if ([NSString isEmpty:self.text])
    {
        super.text = _placeHolder;
        //注释颜色
        [super setTextColor:kLightGrayColor];
    }
}






@end
