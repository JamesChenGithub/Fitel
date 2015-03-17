//
//  CircularTimer.h
//
//  Copyright (c) 2013 Crowd Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>



typedef void (^CircularTimerEndEvent)(TrainKeyValue *trainKV);


@interface CircularTimer : UIView
{
    UILabel *_timerText;
    NSTimer *_timer;
    NSInteger _duration;
    
    AVPlayer *_player;
    BOOL _isPaused;
    
    
    
    
}

@property (nonatomic, readonly) UILabel *timerText;
@property (nonatomic, assign) CGFloat elapseTime;
@property (nonatomic, strong) TrainKeyValue *trainKV;
@property (nonatomic, strong) UIColor *progressColor;

@property (nonatomic, copy) CircularTimerEndEvent waitEndEvent;
@property (nonatomic, copy) CircularTimerEndEvent runEndEvent;
@property (nonatomic, copy) CircularTimerEndEvent sleepEndEvent;

@property (nonatomic, readonly) BOOL isPaused;

- (void)start;

- (void)stop;

- (void)pause;
- (void)pauseOrResume;
- (void)resume;


@end
