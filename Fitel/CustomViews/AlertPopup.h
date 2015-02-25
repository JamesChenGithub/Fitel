//
//  AlertPopup.h
//  iLunch
//
//  Created by James on 4/30/14.
//  Copyright (c) 2014 James. All rights reserved.
//

#import "PopupView.h"


@interface AlertPopup : PopupContentView
{
@private
    UILabel *_title;
    
    UIImageView *_line;
    
    UILabel *_message;
    
    UIImageView *_bottomLine;
    
    NSMutableArray *_alertButtons;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message;

// 添加button
- (void)addButtonWithTitle:(NSString *)title;

- (void)addButtonWithTitle:(NSString *)title action:(CommonBlock)block;


@end
