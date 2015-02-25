//
//  CalenDarFloatView.m
//  iLunch
//
//  Created by James on 15-1-20.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import "CalenDarFloatView.h"

@implementation CalenDarFloatView

- (void)addOwnViews
{
    _calendarView = [[VRGCalendarView alloc] init];
    _calendarView.delegate = self;
    _calendarView.hidden = YES;
    [self addSubview:_calendarView];
    
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapDismiss:)];
//    tap.delegate = self;
//    tap.numberOfTapsRequired = 1;
//    tap.numberOfTouchesRequired = 1;
//    [self addGestureRecognizer:tap];
    
    self.backgroundColor = kAppModalDimbackgroundColor;
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//CGRect    [gestureRecognizer locationInView:self];
//}

- (void)onTapDismiss:(UITapGestureRecognizer *)tap
{
    if (UIGestureRecognizerStateEnded == tap.state)
    {
        [self dismiss];
    }
}

- (void)show
{
    _calendarView.hidden = NO;
    [self fadeIn:0.3 delegate:nil];
}

- (void)dismiss
{
    _calendarView.hidden = YES;
    [self fadeOut:0.3 delegate:nil];
}

-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated
{
    
}
-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date
{
    [self dismiss];
}

@end
