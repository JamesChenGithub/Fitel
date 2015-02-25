//
//  VehicleActionPaopaoView.h
//  iLunch
//
//  Created by James on 14-8-23.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//
#if kSupportMap
#import "BMKActionPaopaoView.h"


// 点击地图上的内容，弹出来的泡泡
@interface VehicleActionPaopaoView : BMKActionPaopaoView
{
@protected
    UIButton *_deviceName;
    
    UIView      *_floatView;
    UILabel     *_statusSpeed;
    UILabel     *_address;
    UIImageView *_arrow;
}

- (instancetype)initWithAnnotation:(VehicleGPSListItem *)veh;

@end
#endif
