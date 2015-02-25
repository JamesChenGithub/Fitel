//
//  CalculateResultViewController.h
//  Fitel
//
//  Created by James on 2/25/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "BaseViewController.h"

@interface CalculateResultCell : UIView
{
    UILabel *_result;
}

- (instancetype)initWith:(NSString *)result;

@end

@interface CalculateResultViewController : BaseViewController
{
    UILabel *_resultTitle;
    UIScrollView *_scrollview;
    UIButton *_closeButton;
    
    NSMutableArray *_array;
}

@property (nonatomic, assign) BOOL isMale;
@property (nonatomic, assign) CGFloat age;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat weight;
@property (nonatomic, assign) CGFloat type;

@end
