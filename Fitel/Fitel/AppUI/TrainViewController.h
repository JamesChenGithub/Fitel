//
//  TrainViewController.h
//  Fitel
//
//  Created by James on 2/25/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "BaseViewController.h"


@interface TrainKeyValueButton : UIButton

- (instancetype)initWith:(NSString *)title;

@end

@interface TrainKeyListView : UIView
{
    UIScrollView *_scrollView;
}

@property (nonatomic, strong) NSMutableArray *trainList;

- (void)select;


@end

@interface TrainTimerView : UIView

@end


@interface TrainViewController : BaseViewController
{
    UIImageView *_videoImageView;
    __weak UIView *_playerView;
    UIButton *_backButton;
    CircularTimer *_timerView;
    TrainKeyListView *_listView;
    
    MPMoviePlayerController *_player;
}

@property (nonatomic, strong) TrainKeyValue *trainKeyValue;

@end
