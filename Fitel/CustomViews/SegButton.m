//
//  SegButton.m
//  iLunch
//
//  Created by James on 15-1-10.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import "SegButton.h"

@implementation SegButton

- (instancetype)initWithMenu:(MenuItem *)item
{
    if (![NSString isEmpty:[item title]])
    {
        return  [self initWithTitle:[item title] action:item.action];
    }
    else
    {
        return  [self initWithTitle:nil icon:[item icon] action:item.action];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _selectBottom = [[UIImageView alloc] init];
        _selectBottom.image = [UIImage imageNamed:@"menu_mark"];
        [self addSubview:_selectBottom];
        _selectBottom.hidden = YES;
        
        [self setTitleColor:kMainTextColor forState:UIControlStateNormal];
        [self setTitleColor:kThemeColor forState:UIControlStateSelected];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    _selectBottom.hidden = !selected;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_selectBottom sizeWith:_selectBottom.image.size];
    [_selectBottom layoutParentHorizontalCenter];
    [_selectBottom alignParentBottom];
}

- (void)onClick:(id)sender
{
    if (_selectAction)
    {
        _selectAction(self);
    }
    
    DebugLog(@"");
}

@end
