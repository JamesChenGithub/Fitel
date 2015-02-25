//
//  HeaderTitleView.m
//  iLunch
//
//  Created by James on 15-1-10.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import "HeaderTitleView.h"

@implementation HeaderTitleView

- (instancetype)init
{
    if (self = [super init])
    {
        self.backgroundColor = [UIColor flatWhiteColor];
    }
    return self;
}

- (instancetype)initWith:(MenuItem *)item
{
    if (self = [super init])
    {
        self.headInfo = item;
        [self addBottomLine];
    }
    return self;
}

- (void)addBottomLine
{
    _bottomLine = [[UIView alloc] init];
    _bottomLine.backgroundColor = kLightGrayColor;
    [self addSubview:_bottomLine];
}

- (void)setHeadInfo:(MenuItem *)headInfo
{
    if (_headInfo == headInfo)
    {
        return;
    }
    
    _headInfo = headInfo;
    _locateIcon.image = [headInfo icon];
    _buildingName.text = [headInfo title];
}

- (void)addOwnViews
{
    _locateIcon = [[UIImageView alloc] init];
//    _locateIcon.image = [UIImage imageNamed:@"icon_place1"];
    [self addSubview:_locateIcon];
    
    _buildingName = [[UILabel alloc] init];
    _buildingName.textColor = kMainTextColor;
    _buildingName.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_buildingName];
    
    _nextIndicator = [[UIImageView alloc] init];
    _nextIndicator.image = [UIImage imageNamed:@"btn_)"];
    [self addSubview:_nextIndicator];
    

    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClick:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];
}

//- (void)configOwnViews
//{
//    _buildingName.text = @"帝一大厦1818号";
//}

- (void)onClick:(UITapGestureRecognizer *)ges
{
    if (ges.state == UIGestureRecognizerStateEnded)
    {
        [self.headInfo menuAction];
    }
}
- (void)relayoutFrameOfSubViews
{
    CGRect bounds = self.bounds;
    [_locateIcon sizeWith:_locateIcon.image.size];
    [_locateIcon layoutParentVerticalCenter];
    [_locateIcon alignParentLeftWithMargin:8];
    
    [_nextIndicator sizeWith:_nextIndicator.image.size];
    [_nextIndicator layoutParentVerticalCenter];
    [_nextIndicator alignParentRight];
    
    [_buildingName sizeWith:bounds.size];
    [_buildingName layoutToRightOf:_locateIcon margin:8];
    [_buildingName scaleToLeftOf:_nextIndicator margin:8];
    
    if (_bottomLine)
    {
        [_bottomLine sizeWith:CGSizeMake(bounds.size.width, 1)];
        [_bottomLine alignParentBottom];
    }
}



@end
