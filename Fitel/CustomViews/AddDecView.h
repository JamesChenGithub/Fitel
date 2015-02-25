//
//  AddDecView.h
//  iLunch
//
//  Created by James on 15-1-9.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddDecView : UIView
{
    UIImageView *_editBg;
    UIButton    *_dec;
    UITextField *_number;
    UIButton    *_add;
}

@property (nonatomic, assign) NSInteger numberValue;


@end
