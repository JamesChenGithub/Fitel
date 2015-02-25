//
//  CircularTimer.h
//
//  Copyright (c) 2013 Crowd Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircularTimer : UIView
{
    UILabel *_timerText;
    NSTimer *_timer;
}

@property (nonatomic, readonly) UILabel *timerText;
@property (nonatomic, assign) NSInteger elapseTime;
@property (nonatomic, strong) TrainKeyValue *trainKV;

- (void)start;

- (void)stop;


@end
