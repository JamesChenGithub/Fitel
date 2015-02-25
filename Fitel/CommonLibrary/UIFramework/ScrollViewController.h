//
//  ScrollViewController.h
//  iLunch
//
//  Created by James on 4/2/14.
//  Copyright (c) 2014 James. All rights reserved.
//

#import "CommonBaseViewController.h"

@interface ScrollViewController : BaseViewController
{
@protected
    UIScrollView *_scrollView;
}

- (void)configContentSize;

@end
