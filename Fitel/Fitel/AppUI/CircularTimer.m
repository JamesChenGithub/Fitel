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
}

- (void)addOwnViews
{
    _timerText = [[UILabel alloc] init];
    _timerText.textAlignment = NSTextAlignmentCenter;
    _timerText.font = [UIFont systemFontOfSize:16];
    _timerText.adjustsFontSizeToFitWidth = YES;
    _timerText.lineBreakMode = NSLineBreakByWordWrapping;
    _timerText.numberOfLines = 0;
    
    _timerText.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_timerText];
    self.backgroundColor = kClearColor;
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
        CGFloat por = [IOSDeviceConfig sharedConfig].isPortrait ? 16 : 10;
        CGFloat selfInteralRadius = selfRadius - por ;
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
            [self.progressColor setStroke];
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
        self.progressColor = kDarkGrayColor;
        self.pauseAction = @selector(onWait);
        _timerText.text = [NSString stringWithFormat:kTrain_Wait_Format_Str, (int)(_duration - _elapseTime)];
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:self.pauseAction userInfo:nil repeats:YES];
    }
    
}

- (void)sleep
{
    if (self.trainKV)
    {
        [_timer invalidate];
        _elapseTime = 0;
        _duration = self.trainKV.playInterval;
        self.progressColor = kGreenColor;
        self.pauseAction = @selector(onSleep);
        _timerText.text = [NSString stringWithFormat:kTrain_Sleep_Format_Str, (int)(_duration - _elapseTime)];
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:self.pauseAction userInfo:nil repeats:YES];
    }
}

- (void)playStartSound
{
    NSString *urlPath =  [[NSBundle mainBundle] pathForResource:@"start" ofType:@"m4a"];
    NSURL *startURL = [NSURL fileURLWithPath:urlPath];
    _player = [[AVPlayer alloc] initWithURL:startURL];
    [_player play];
}

- (void)playEndSound
{
    NSString *endurlPath =  [[NSBundle mainBundle] pathForResource:@"end" ofType:@"m4a"];
    
    NSURL *endURL = [NSURL fileURLWithPath:endurlPath];
    _player = [[AVPlayer alloc] initWithURL:endURL];
    [_player play];
}

- (void)onWait
{
    _elapseTime += 0.2;
    
    _timerText.text = [NSString stringWithFormat:kTrain_Wait_Format_Str, (int)(_duration - _elapseTime)];
    [self setNeedsDisplay];
    if (fabs(_elapseTime - ( _duration - 4.8)) < 0.001)
    {
        [self playStartSound];
    }
    
    if (fabs(_elapseTime - _duration) < 0.001)
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
    _elapseTime += 0.2;
    
    _timerText.text = [NSString stringWithFormat:kTrain_Sleep_Format_Str, (int)(_duration - _elapseTime)];
    [self setNeedsDisplay];
    if (fabs(_elapseTime - ( _duration - 4.8))<0.001)
    {
        [self playStartSound];
    }
    
    if (fabs(_elapseTime - _duration) < 0.001)
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
        self.progressColor = kBlueColor;
        self.pauseAction = @selector(updateTime);
        _timerText.text = [NSString stringWithFormat:kTrain_Run_Format_Str, (int)(_duration - _elapseTime)];
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:self.pauseAction userInfo:nil repeats:YES];
    }
    
}

- (void)updateTime
{
    _elapseTime += 0.2;
    
    _timerText.text = [NSString stringWithFormat:kTrain_Run_Format_Str, (int)(_duration - _elapseTime)];
    [self setNeedsDisplay];
    if (fabs(_elapseTime - ( _duration - 0.6))<0.001)
    {
        [self playEndSound];
    }
    
    if (fabs(_elapseTime - _duration) < 0.001)
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
    _isPaused = YES;
    [_timer invalidate];
    _timer = nil;
    [self setNeedsDisplay];
    [_player pause];
}

- (void)pause
{
    _isPaused = YES;
    [_timer invalidate];
    _timer = nil;
    [_player pause];
}
- (void)pauseOrResume
{
    if (_timer)
    {
        _isPaused = YES;
        [self pause];
        [_player pause];
    }
    else
    {
        _isPaused = NO;
        [self resume];
        [_player play];
    }
}
- (void)resume
{
    _isPaused = NO;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:self.pauseAction userInfo:nil repeats:YES];
    [_player play];
    
}

@end
