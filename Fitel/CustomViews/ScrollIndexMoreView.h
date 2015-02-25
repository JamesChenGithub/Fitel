//
//  ScrollIndexMoreView.h
//  iLunch
//
//  Created by James on 15-1-10.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import "ScrollIndexView.h"

@interface ScrollIndexMoreView : ScrollIndexView
{
    MenuButton *_like;
    MenuButton *_more;
}

- (instancetype)initWithMenus:(NSArray *)array likeAction:(CommonBlock)like moreAction:(CommonBlock)action;

@end
