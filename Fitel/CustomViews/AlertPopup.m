//
//  AlertPopup.m
//  iLunch
//
//  Created by James on 4/30/14.
//  Copyright (c) 2014 James. All rights reserved.
//

#import "AlertPopup.h"

@implementation AlertPopup

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message
{
    if (self = [super init])
    {
        _title.text = title;
        
        _message.text = message;
        
        _alertButtons = [NSMutableArray array];
        
        self.backgroundColor = kAppModalBackgroundColor;
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 8;
    }
    return self;
}


- (void)addOwnViews
{
    _title = [[UILabel alloc] init];
    _title.backgroundColor = kClearColor;
    _title.textColor = kWhiteColor;
    _title.textAlignment = NSTextAlignmentCenter;
    _title.font = [[FontHelper shareHelper] boldFontWithSize:16];
    [self addSubview:_title];
    
//    UIImage *line = [UIImage imageWithColor:kWhiteColor size:CGSizeMake(1, 1)];
//    _line = [[UIImageView alloc] initWithImage:line];
//    _line.frame = CGRectZero;
//    [self addSubview:_line];
    
    _message = [[UILabel alloc] init];
    _message.backgroundColor = kClearColor;
    _message.textColor = kWhiteColor;
    _message.numberOfLines = 0;
    _message.lineBreakMode = NSLineBreakByWordWrapping;
//    _message.textAlignment = NSTextAlignmentLeft;
    _message.font = [UIFont systemFontOfSize:14];;
    [self addSubview:_message];
    
//    _bottomLine = [[UIImageView alloc] init];
//    _bottomLine.backgroundColor = kWhiteColor;
//    [self addSubview:_bottomLine];
}

- (void)addButtonWithTitle:(NSString *)title
{
    [self addButtonWithTitle:title action:nil];
}

- (void)addButtonWithTitle:(NSString *)title action:(CommonBlock)block
{
//    if (_alertButtons.count > 0)
//    {
//        UIImageView *split = [[UIImageView alloc] init];
//        split.backgroundColor = [kWhiteColor colorWithAlphaComponent:0.2];
//        [self addSubview:split];
//        [_alertButtons addObject:split];
//    }
    
    __weak typeof(self) weakSelf = self;
    MenuButton *button = nil;
    if (block)
    {
        button = [[MenuButton alloc] initWithTitle:title action:^(id<MenuAbleItem> menu) {
            block(weakSelf);
        }];
    }
    else
    {
        button = [[MenuButton alloc] initWithTitle:title action:^(id<MenuAbleItem> menu) {
            if (weakSelf)
            {
                [weakSelf closePopup];
            }
        }];
    }
    
    [button setBackgroundImage:[UIImage imageWithColor:kAlertButtonNormalColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:kAlertButtonPressedColor] forState:UIControlStateHighlighted];
//    button.showsTouchWhenHighlighted = YES;
    [self addSubview:button];
    [_alertButtons addObject:button];
}


#define kAlertWidth 280
#define kHorMargin  13

#define kTitleHeight 44
#define kLineHeight 44
#define kButtonHeight 44

#define kButtonWidth 80

- (CGSize)messageSize
{
    CGSize messageSize = [_message textSizeIn:CGSizeMake(kAlertWidth - 2*kHorMargin, HUGE_VALF)];
    NSInteger count = (NSInteger)(messageSize.height + 22)/44;
//    if (count > 1)
//    {
//        _message.textAlignment = NSTextAlignmentLeft;
//    }
//    else
//    {
//        _message.textAlignment = NSTextAlignmentCenter;
//        
//    }
    messageSize.height = (count + 1)*44;
    return messageSize;
}

- (CGSize)adjustSize
{
    CGSize messageSize = [self messageSize];
    
    CGFloat alertHeight = 0;
    
    
    if ([NSString isEmpty:_title.text])
    {
        alertHeight = messageSize.height + kButtonHeight;
    }
    else
    {
        alertHeight = kTitleHeight + messageSize.height + kButtonHeight;
    }
    
    //    if (alertHeight < 250) {
    //        alertHeight = 250;
    //    }
    return CGSizeMake(kAlertWidth, (NSInteger)alertHeight + 1);
}

- (CGRect)showRect
{
    //    if (CGRectEqualToRect(_showRect, CGRectZero))
    //    {
    CGRect rect = self.popupParent.bounds;
    CGRect showRect = CGRectInset(rect, (rect.size.width - self.showSize.width)/2, (rect.size.height - self.showSize.height)/2);
    _showRect = showRect;
    //    }
    //
    return _showRect;
}

- (CGSize)showSize
{
    if (CGSizeEqualToSize(_showSize, CGSizeZero))
    {
        if (_alertButtons.count == 0)
        {
            [self addButtonWithTitle:kCancel_Str];
        }
        CGSize size = [self adjustSize];
        
        
        _showSize = size;
    }
    return  _showSize;
}

- (void)relayoutFrameOfSubViews
{
    CGRect rect = self.bounds;
    
    if (![NSString isEmpty:_title.text])
    {
        CGRect titleRect = rect;
        titleRect.size.height = kTitleHeight;
        _title.frame = titleRect;
        
        titleRect.origin.y += titleRect.size.height;
        titleRect.size.height = 1;
        _line.frame = titleRect;
        
        rect.origin.y += kTitleHeight ;
        rect.size.height -= kTitleHeight;
    }
    
    CGSize messageSize = [self messageSize];
    CGRect messageRect = rect;
    messageRect.origin.x += (rect.size.width - messageSize.width)/2;
    messageSize.height -= 1;
    messageRect.size = messageSize;
    _message.frame = messageRect;
    
    
    
    CGRect blineRect = messageRect;
    blineRect.origin.y = messageRect.origin.y + messageRect.size.height;
    blineRect.size.height = 1;
    _bottomLine.frame = blineRect;
    

    
    
    NSInteger buttonCount = _alertButtons.count/2 + 1;
    
    //    CGFloat horInterval = (titleRect.size.width - buttonCount * kButtonWidth) / (buttonCount + 1);
//    CGFloat horInterval = 0;
    
    CGRect buttonRect = rect;
    buttonRect.size.height = kButtonHeight;
    buttonRect.origin.y += rect.size.height - buttonRect.size.height;
    buttonRect.size.width = buttonRect.size.width/buttonCount;
    
    for (UIView *view in _alertButtons)
    {
//        if ([view isKindOfClass:[MenuButton class]])
//        {
//            CGRect brect = buttonRect;
//            brect.size.width -= 1;
            [view setFrameAndLayout:buttonRect];
            buttonRect.origin.x += buttonRect.size.width;
//        }
//        else
//        {
//            CGRect splintRect = buttonRect;
//            splintRect.size.width = 1;
//            splintRect.origin.x += buttonRect.size.width ;
//            splintRect.origin.y += 5;
//            splintRect.size.height -= 5;
//            [view setFrameAndLayout:splintRect];
//            buttonRect.origin.x += buttonRect.size.width + horInterval;
//        }
    }
}






@end
