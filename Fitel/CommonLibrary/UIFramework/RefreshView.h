//
//  RefreshView.h
//  iLunch
//
//  Created by James on 15-2-4.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    ELoadingOver,
    EWillLoading,
    EReleaseLoading,
    ELoading,
}RefreshLoadingState;


@interface HeadRefreshView : UIView<RefreshAbleView>
{
@protected
    UILabel                 *_loading;
    UIActivityIndicatorView *_indicator;
    
@protected
    RefreshLoadingState _state;
}

@property (nonatomic, assign) NSInteger refreshHeight;

@property (nonatomic, readonly) RefreshLoadingState state;

@end

@interface FootRefreshView : HeadRefreshView

@end
