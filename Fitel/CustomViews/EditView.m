//
//  EditView.m
//  TCLSales
//
//  Created by ken liu on 14-1-18.
//  Copyright (c) 2014年 Insigma. All rights reserved.
//

#import "EditView.h"

@interface EditView ()

@property (nonatomic, copy) StartEditAction editAction;

@property (nonatomic, copy) EditDoneAction action;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, assign) NSInteger lineNumber;

@end

@implementation EditView

#define kSingleHeight 30

- (void)setText:(NSString *)text
{
    _textField.text = text;
    _textView.text = text;
}

- (NSString *)text
{
    if (_textField) {
        return _textField.text;
    }
    
    if (_textView) {
        return _textView.text;
    }
    return nil;
}

- (NSInteger)height
{
    return _lineNumber * kSingleHeight;
}

- (void)addTitle:(NSString *)title
{
    self.titleLabel = [[UILabel alloc] init];
    _titleLabel.text = title;
    _titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _titleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_titleLabel];
    _titleLabel.textAlignment = NSTextAlignmentRight;
}

- (instancetype)initWithStartAction:(StartEditAction)startAction  doneAction:(EditDoneAction)action
{
    if (self = [super init])
    {
        self.editAction = startAction;
        self.action = action;
        _lineNumber = 1;
        self.textField = [[UITextField alloc] init];
        self.textField.returnKeyType = UIReturnKeyDone;
        self.textField.delegate = self;
        self.textField.borderStyle = UITextBorderStyleRoundedRect;
        self.textField.font = [UIFont boldSystemFontOfSize:14];
        [self addSubview:self.textField];
    }
    return self;
}

- (instancetype)initSingleLineWithTitle:(NSString *)title startAction:(StartEditAction)startAction  doneAction:(EditDoneAction)action
{
    if (self = [super init])
    {
        self.editAction = startAction;
        self.action = action;
        _lineNumber = 1;
        [self addTitle:title];
        
        self.textField = [[UITextField alloc] init];
        self.textField.returnKeyType = UIReturnKeyDone;
        self.textField.delegate = self;
        self.textField.borderStyle = UITextBorderStyleRoundedRect;
        self.textField.font = self.titleLabel.font;
//        self.textField.borderStyle = UITextBorderStyleLine;
        [self addSubview:self.textField];
    }
    return self;
}

- (instancetype)initMuiltLineWithTitle:(NSString *)title maxLine:(NSInteger)line startAction:(StartEditAction)startAction  doneAction:(EditDoneAction)action
{
    if (self = [super init])
    {
        self.editAction = startAction;
        self.action = action;
        _lineNumber = line;
        [self addTitle:title];
        
        self.textView = [[UITextView alloc] init];
        self.textView.returnKeyType = UIReturnKeyDone;
        self.textView.delegate = self;
        self.textView.font = self.titleLabel.font;
        self.textView.layer.cornerRadius = 2;
        self.textView.backgroundColor = [UIColor flatWhiteColor];
        [self addSubview:self.textView];
    }
    return self;
}

- (void)relayoutFrameOfSubViews
{
    CGRect rect = self.bounds;
    
    if (rect.size.height > self.height)
    {
        rect = CGRectInset(rect, 5, 0);
    }
    else
    {
        rect = CGRectInset(rect, 5, 0);
    }
    
    rect.origin.y += 5;
    rect.size.height -= 5;
    CGRect editRect = rect;
    
    if (_titleLabel)
    {
        rect.size.width = self.titleWidth;
        
        _titleLabel.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, kSingleHeight);
        
        editRect.origin.x += rect.size.width + 5;
        editRect.size.width -= rect.size.width + 5;
        
        _textField.frame = editRect;
        _textView.frame = editRect;
        
        if (_textView) {
            CGRect titleFrame = _titleLabel.frame;
            titleFrame.origin.y += 5;
            titleFrame.size.height -= 5;
            _titleLabel.frame = titleFrame;
        }
    }
    else
    {
        _textField.frame = editRect;
        _textView.frame = editRect;
    }
}

- (void)addBorder
{
    if (!self.hasBorder) {
        return;
    }
    UIColor *c = [UIColor blackColor];
    // 可编辑时的样式
    _textField.layer.borderWidth = 0.5;
    _textField.layer.borderColor = c.CGColor;
    
    _textView.layer.borderWidth = 0.5;
    _textView.layer.borderColor = c.CGColor;
}

- (void)removeBorder
{
    _textField.layer.borderWidth = 0;
    _textField.layer.borderColor = nil;
    
    _textView.layer.borderWidth = 0;
    _textView.layer.borderColor = nil;
}


- (void)setHasBorder:(BOOL)hasBorder
{
    _hasBorder = hasBorder;
    _hasBorder ? [self addBorder] : [self removeBorder];
}

- (void)setEnabled:(BOOL)enabled
{
    
    if (enabled)
    {
        [self addBorder];
    }
    else
    {
        if (!_hasBorder)
        {
            // 为可编辑时的样式
            [self removeBorder];
        }
        else
        {
            // 可编辑时的样式
            [self addBorder];
        }
        
        [self resignFirstResponder];
    }
    
    if (self.editBackgroundColor)
    {
        self.textField.backgroundColor = self.editBackgroundColor;
        self.textView.backgroundColor = self.editBackgroundColor;
        self.textView.layer.cornerRadius = 5;
    }
    
    _textField.enabled = enabled;
    _textView.editable = enabled;
    
    if (enabled == NO) {
        UIColor *disColor = [UIColor darkGrayColor];
        _textField.textColor = disColor;
        _textView.textColor = disColor;
    }
    else
    {
        UIColor *enColor = [UIColor blackColor];
        _textField.textColor = enColor;
        _textView.textColor = enColor;
    }
}

- (void)setEditBackgroundColor:(UIColor *)editBackgroundColor
{
    _editBackgroundColor = editBackgroundColor;
    self.textField.backgroundColor = self.editBackgroundColor;
//    self.textView.backgroundColor = [UIColor flatWhiteColor];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (_action)
    {
        _action(self);
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (_editAction) {
        return _editAction(self);
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (_action) {
        _action(self);
    }
}


- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (_action) {
        _action(self);
    }
}
- (BOOL)resignFirstResponder
{
    if (_textField) {
        return [_textField resignFirstResponder];
    }
    
    if (_textView) {
        return [_textView resignFirstResponder];
    }
    
    return NO;
}
- (BOOL)becomeFirstResponder
{
    if (_textField) {
        return [_textField becomeFirstResponder];
    }
    
    if (_textView) {
        return [_textView becomeFirstResponder];
    }
    
    return NO;
}

- (UIColor *)textColor
{
    if (_textField) {
        return _textField.textColor;
    }
    
    if (_textView) {
        return _textView.textColor;
    }
    return nil;
}

- (void)setTextColor:(UIColor *)c
{
    _textField.textColor = c;
    _textView.textColor = c;
}

- (UIFont *)font
{
    if (_textField) {
        return _textField.font;
    }
    
    if (_textView) {
        return _textView.font;
    }
    return nil;
}

- (void)setFont:(UIFont *)font
{
    _textField.font = font;
    _textView.font = font;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    _textField.textAlignment = textAlignment;
    _textView.textAlignment = textAlignment;
}

- (NSTextAlignment)textAlignment
{
    if (_textField) {
        return _textField.textAlignment;
    }
    
    if (_textView) {
        return _textView.textAlignment;
    }
    return NSTextAlignmentLeft;
}

- (void)setPlaceHolder:(NSString *)ph
{
    _textField.placeholder = ph;
    _textView.text = ph;
}

- (NSString *)placeHolder
{
    if (_textField) {
        return _textField.placeholder;
    }
    
    if (_textView) {
        return _textView.text;
    }
    return nil;
}


- (void)setNumKeyboard
{
    _textField.keyboardType = UIKeyboardTypePhonePad;
    _textView.keyboardType = UIKeyboardTypePhonePad;
}

- (void)setFloatNumKeyboard
{
    _textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    _textView.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
}

- (void)addRigtImage:(UIImage *)image
{
    if (_textField) {
        _textField.rightViewMode = UITextFieldViewModeAlways;
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(0, 0, 40, 30);
        _textField.rightView = imageView;
//        imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
//        _textField.backgroundColor = [UIColor clearColor];
//        _textField.borderStyle = UITextBorderStyleNone;
    }
}

- (void)setSecurity:(BOOL)sec
{
    _textField.secureTextEntry = sec;
}

@end
