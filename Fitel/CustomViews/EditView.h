//
//  EditView.h
//  TCLSales
//
//  Created by ken liu on 14-1-18.
//  Copyright (c) 2014年 Insigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EditView;

typedef BOOL (^StartEditAction)(EditView *editView);;
typedef void (^EditDoneAction)(EditView *editView);

@interface EditView : UIControl<UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, assign) NSInteger titleWidth;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, strong) UIFont *font;

@property (nonatomic, assign) NSTextAlignment textAlignment;

@property (nonatomic, strong) UIColor *editBackgroundColor; // enable 可编辑区域的颜色

@property (nonatomic, assign) BOOL hasBorder;

@property (nonatomic, copy) NSString *placeHolder;

// without title
- (instancetype)initWithStartAction:(StartEditAction)startAction  doneAction:(EditDoneAction)action;

- (instancetype)initSingleLineWithTitle:(NSString *)title startAction:(StartEditAction)startAction  doneAction:(EditDoneAction)action;

- (instancetype)initMuiltLineWithTitle:(NSString *)title maxLine:(NSInteger)line startAction:(StartEditAction)startAction  doneAction:(EditDoneAction)action;

- (BOOL)resignFirstResponder;

- (BOOL)becomeFirstResponder;

- (void)setNumKeyboard;
- (void)setFloatNumKeyboard;

- (void)addRigtImage:(UIImage *)image;

- (void)setSecurity:(BOOL)sec;

@end
