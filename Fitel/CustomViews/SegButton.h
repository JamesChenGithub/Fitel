//
//  SegButton.h
//  iLunch
//
//  Created by James on 15-1-10.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegButton : MenuButton
{
    UIImageView *_selectBottom;
}

@property (nonatomic, copy) CommonBlock selectAction;

@end
