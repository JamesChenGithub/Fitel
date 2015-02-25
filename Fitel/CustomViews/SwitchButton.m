//
//  SwitchButton.m
//  iLunch
//
//  Created by James on 14-11-23.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "SwitchButton.h"

@implementation SwitchButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundImage:[UIImage imageNamed:@"VRM_i05_011_SwitchOff.png"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"VRM_i05_012_SwitchOn.png"] forState:UIControlStateSelected];
    }
    return self;
}

//- (void)setSelected:(BOOL)selected
//{
//    [super setSelected:selected];
//    if (selected)
//    {
//        [self setImage:[UIImage imageNamed:@"VRM_i05_011_SwitchOn.png"] forState:UIControlStateNormal];
//        [self setImage:[UIImage imageNamed:@"VRM_i05_011_SwitchOff.png"] forState:UIControlStateSelected];
//        [self setImage:[UIImage imageNamed:@"VRM_i05_011_SwitchOff.png"] forState:UIControlStateHighlighted];
//    }
//    else
//    {
//        [self setImage:[UIImage imageNamed:@"VRM_i05_011_SwitchOff.png"] forState:UIControlStateNormal];
//        [self setImage:[UIImage imageNamed:@"VRM_i05_011_SwitchOn.png"] forState:UIControlStateSelected];
//        [self setImage:[UIImage imageNamed:@"VRM_i05_011_SwitchOn.png"] forState:UIControlStateHighlighted];
//    }
//}

- (BOOL)on
{
    return self.selected;
}

- (void)setOn:(BOOL)on
{
    if (self.selected == on) {
        return;
    }
    self.selected = on;
}

@end
