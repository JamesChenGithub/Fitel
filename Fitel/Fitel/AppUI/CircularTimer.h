//
//  CircularTimer.h
//
//  Copyright (c) 2013 Crowd Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

typedef void (^CircularTimerEndEvent)(TrainKeyValue *trainKV);

@interface CircularTimer : UIView
{
    UILabel *_timerText;
    NSTimer *_timer;
    NSInteger _duration;
    
    SystemSoundID _startID;
    SystemSoundID _endId;
    
}

@property (nonatomic, readonly) UILabel *timerText;
@property (nonatomic, assign) CGFloat elapseTime;
@property (nonatomic, strong) TrainKeyValue *trainKV;
@property (nonatomic, strong) UIColor *progressColor;

@property (nonatomic, copy) CircularTimerEndEvent waitEndEvent;
@property (nonatomic, copy) CircularTimerEndEvent runEndEvent;
@property (nonatomic, copy) CircularTimerEndEvent sleepEndEvent;

- (void)start;

- (void)stop;

- (void)pause;
- (void)pauseOrResume;
- (void)resume;


@end
