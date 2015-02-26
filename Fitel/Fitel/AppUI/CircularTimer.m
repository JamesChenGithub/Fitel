//
//  CircularTimer.m
//
//  Copyright (c) 2013 Crowd Studio. All rights reserved.
//

#import "CircularTimer.h"

@interface CircularTimer ()


@property (nonatomic, assign) SEL pauseAction;

@end

@implementation CircularTimer

- (void)dealloc
{
    [self stop];
    
    AudioServicesRemoveSystemSoundCompletion(_startID);
    AudioServicesDisposeSystemSoundID(_endId);
    AudioServicesRemoveSystemSoundCompletion(_endId);
    AudioServicesDisposeSystemSoundID(_endId);
    
    
}

- (void)addOwnViews
{
    _timerText = [[UILabel alloc] init];
    _timerText.textAlignment = NSTextAlignmentCenter;
    _timerText.font = [UIFont systemFontOfSize:14];
    _timerText.lineBreakMode = NSLineBreakByWordWrapping;
    _timerText.numberOfLines = 0;
    _timerText.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_timerText];
    self.backgroundColor = kClearColor;
    
    // 要播放的音频文件地址
    NSString *urlPath =  [[NSBundle mainBundle] pathForResource:@"start" ofType:@"m4a"];
    NSURL *url = [NSURL fileURLWithPath:urlPath];
    // 声明需要播放的音频文件ID[unsigned long]
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &_startID);
//     AudioServicesAddSystemSoundCompletion(_startID, NULL, NULL, &playFinished, (__bridge void *)(self));
    
    // 要播放的音频文件地址
    NSString *endurlPath =  [[NSBundle mainBundle] pathForResource:@"end" ofType:@"m4a"];
    NSURL *endurl = [NSURL fileURLWithPath:endurlPath];
    // 声明需要播放的音频文件ID[unsigned long]
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(endurl), &_endId);
//     AudioServicesAddSystemSoundCompletion(_endId, NULL, NULL, &playFinished, (__bridge void *)(self));
    

}

void playFinished(SystemSoundID ssID, void* clientData)
{
    AudioServicesRemoveSystemSoundCompletion(ssID);
    AudioServicesDisposeSystemSoundID(ssID);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self relayoutFrameOfSubViews];
}

- (void)relayoutFrameOfSubViews
{
    CGRect rect = self.bounds;
    [_timerText sizeWith:CGSizeMake(rect.size.width/2, rect.size.height/2)];
    [_timerText layoutParentCenter];
}

- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    
    //    CGContextClearRect(context, rect);
    
    
    
    if (self.trainKV)
    {
        CGFloat selfRadius = MIN(rect.size.width, rect.size.height)/2;
        CGFloat selfInteralRadius = selfRadius - 10;
        //General circle info
        CGPoint center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
        float strokeWidth = selfRadius - selfInteralRadius;
        float radius = selfInteralRadius + strokeWidth / 2;
        
        //Background circle
        UIBezierPath *circle1 = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:DEGREES_TO_RADIANS(0.0f) endAngle:DEGREES_TO_RADIANS(360.0f) clockwise:YES];
        
        
        if (_elapseTime == _duration)
        {
            [kRedColor setStroke];
            circle1.lineWidth = strokeWidth;
            [circle1 stroke];
        }
        else
        {
            [kLightGrayColor setStroke];
            circle1.lineWidth = strokeWidth;
            [circle1 stroke];
            
            //Active circle
            float startAngle = 0.0f;
            float degrees = 360.0f;
            
            startAngle = 270.0f;
            float tempDegrees = _elapseTime * 360.0 / _duration;
            degrees = (tempDegrees < 90) ? 270 + tempDegrees : tempDegrees - 90;
            
            
            UIBezierPath *circle2 = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:DEGREES_TO_RADIANS(startAngle) endAngle:DEGREES_TO_RADIANS(degrees) clockwise:YES];
            [kPurpleColor setStroke];
            circle2.lineWidth = strokeWidth;
            [circle2 stroke];
            
            //            CGContextSetFillColorWithColor(context, kWhiteColor.CGColor);
            //            CGContextFillRect(context, rect);
        }
        
        
        UIBezierPath *circle3 = [UIBezierPath bezierPathWithArcCenter:center radius:selfInteralRadius startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(360.0f) clockwise:YES];
        [kWhiteColor setFill];
        [circle3 fill];
    }
    
    UIGraphicsPopContext();
}

- (void)setTrainKV:(TrainKeyValue *)trainKV
{
    if (trainKV)
    {
        _trainKV = trainKV;
        [self wait];
    }
    
}

- (void)wait
{
    if (self.trainKV)
    {
        [_timer invalidate];
        _elapseTime = 0;
        _duration = self.trainKV.playInterval;
        self.pauseAction = @selector(onWait);
        _timerText.text = [NSString stringWithFormat:@"倒计时\n%d", (int)(_duration - _elapseTime)];
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:self.pauseAction userInfo:nil repeats:YES];
    }

}

- (void)sleep
{
    if (self.trainKV)
    {
        [_timer invalidate];
        _elapseTime = 0;
        _duration = self.trainKV.playInterval;
        self.pauseAction = @selector(onSleep);
        _timerText.text = [NSString stringWithFormat:@"休息\n%d", (int)(_duration - _elapseTime)];
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:self.pauseAction userInfo:nil repeats:YES];
    }
}

- (void)onWait
{
    _elapseTime += 0.5;
    
    _timerText.text = [NSString stringWithFormat:@"倒计时\n%d", (int)(_duration - _elapseTime)];
    [self setNeedsDisplay];
    if (_elapseTime == _duration - 4.5)
    {
        AudioServicesPlayAlertSound(_startID);
    }
    
    if (_elapseTime >= _duration)
    {
        if (self.waitEndEvent)
        {
            self.waitEndEvent(self.trainKV);
        }
        
        [self start];
    }
}

- (void)onSleep
{
    _elapseTime += 0.5;
    
    _timerText.text = [NSString stringWithFormat:@"休息\n%d", (int)(_duration - _elapseTime)];
    [self setNeedsDisplay];
    if (_elapseTime == _duration - 4.5)
    {
        AudioServicesPlayAlertSound(_startID);
    }
    
    if (_elapseTime >= _duration)
    {
        if (self.sleepEndEvent)
        {
            self.sleepEndEvent(self.trainKV);
        }
        
        [self start];
    }
}

- (void)start
{
    if (self.trainKV)
    {
        [_timer invalidate];

        _elapseTime = 0;
        _duration = self.trainKV.duration;
        self.pauseAction = @selector(updateTime);
        _timerText.text = [NSString stringWithFormat:@"运动\n%d", (int)(_duration - _elapseTime)];
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:self.pauseAction userInfo:nil repeats:YES];
    }
    
}

- (void)updateTime
{
    _elapseTime += 0.5;
    
    _timerText.text = [NSString stringWithFormat:@"运动\n%d", (int)(_duration - _elapseTime)];
    [self setNeedsDisplay];
    if (_elapseTime == _duration - 0.5)
    {
        AudioServicesPlayAlertSound(_endId);
    }
    
    if (_elapseTime >= _duration)
    {
        if (self.runEndEvent)
        {
            self.runEndEvent(self.trainKV);
        }
        
        [self sleep];
    }
}

- (void)stop
{
    [_timer invalidate];
    _timer = nil;
    [self setNeedsDisplay];
}

- (void)pause
{
    [_timer invalidate];
    _timer = nil;
}
- (void)pauseOrResume
{
    if (_timer)
    {
        [self pause];
    }
    else
    {
        [self resume];
    }
}
- (void)resume
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:self.pauseAction userInfo:nil repeats:YES];
}

@end