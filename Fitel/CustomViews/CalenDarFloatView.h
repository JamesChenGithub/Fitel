//
//  CalenDarFloatView.h
//  iLunch
//
//  Created by James on 15-1-20.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "VRGCalendarView.h"

@interface CalenDarFloatView : UIView<VRGCalendarViewDelegate>
{
    VRGCalendarView *_calendarView;
}

- (void)show;
- (void)dismiss;

@end
