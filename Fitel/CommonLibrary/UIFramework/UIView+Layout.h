//
//  UIView+Layout.h
//  iLunch
//
//  Created by James Chen on 2/28/13.
//  Copyright (c) 2013 ken liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Layout)

- (void)addOwnViews;

- (void)configOwnViews;

//- (void)configWith:(NSMutableDictionary *)jsonDic;

- (void)autoLayoutSubViews;

// 是否使用自动布局
- (BOOL)isAutoLayout;

// 外部通过此功能进行设置
- (void)setFrameAndLayout:(CGRect)rect;

// 对于一些自定义的UIView，在设置Frame后，如需要重新调整局的话
// 作为所以控修改其自身内部子控件的入口
// 所有的自定义View最好不要从initWithFrams里面进行设置其子View的frame,
// 统一在些处进行设置
- (void)relayoutFrameOfSubViews;

- (void)addBottomLine:(CGRect)rect;

- (void)addBottomLine:(UIColor *)color inRect:(CGRect)rect;

@end
