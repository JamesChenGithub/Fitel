//
//  CircularTimer.m
//
//  Copyright (c) 2013 Crowd Studio. All rights reserved.
//

#import "CircularTimer.h"

@implementation CircularTimer

- (void)addOwnViews
{
    _timerText = [[UILabel alloc] init];
    _timerText.textAlignment = NSTextAlignmentCenter;
    _timerText.font = [UIFont systemFontOfSize:16];
    _timerText.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_timerText];
    self.backgroundColor = kClearColor;
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
        
        
        if (_elapseTime == self.trainKV.playInterval)
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
            float tempDegrees = _elapseTime * 360.0 / self.trainKV.playInterval;
            degrees = (tempDegrees < 90) ? 270 + tempDegrees : tempDegrees - 90;
            
            
            UIBezierPath *circle2 = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:DEGREES_TO_RADIANS(startAngle) endAngle:DEGREES_TO_RADIANS(degrees) clockwise:YES];
            [kRedColor setStroke];
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
        [self stop];
        _elapseTime = 0;
        _timerText.text = [NSString stringWithFormat:@"%d", self.trainKV.playInterval - _elapseTime];
    }
    
}

- (void)start
{
    if (self.trainKV)
    {
        [_timer invalidate];
        
        [self updateTime];
        _elapseTime = 0;
        _timerText.text = [NSString stringWithFormat:@"%d", self.trainKV.playInterval - _elapseTime];
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    }
    
}

- (void)updateTime
{
    _elapseTime++;
    
    _timerText.text = [NSString stringWithFormat:@"%d", self.trainKV.playInterval - _elapseTime];
    [self setNeedsDisplay];
    if (_elapseTime >= self.trainKV.playInterval)
    {
        [self stop];
    }
}

- (void)stop
{
    [_timer invalidate];
    _timer = nil;
    [self setNeedsDisplay];
}

@end
