//
//  HeaderTitleView.h
//  iLunch
//
//  Created by James on 15-1-10.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderTitleView : UIView
{
    UIImageView *_locateIcon;
    UILabel *_buildingName;
    UIImageView *_nextIndicator;
    UIView  *_bottomLine;
}

@property (nonatomic, strong) MenuItem *headInfo;

- (instancetype)initWith:(MenuItem *)item;
- (instancetype)initWithButNoBottomLine:(MenuItem *)item;

@end
