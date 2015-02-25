//
//  NSObject_Global.h
//  TCLSales
//
//  Created by ken liu on 14-1-16.
//  Copyright (c) 2014年 iLunch. All rights reserved.
//

//主窗口的宽、高
#define kMainScreenWidth  MainScreenWidth()
#define kMainScreenHeight MainScreenHeight()

#define Localized(Str) NSLocalizedString(Str, Str)

static __inline__ CGFloat MainScreenWidth()
{
    return UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? [UIScreen mainScreen].bounds.size.width : [UIScreen mainScreen].bounds.size.height;
}

static __inline__ CGFloat MainScreenHeight()
{
        return UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width;
}



//角度与弧度转换
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(x) (180.0 * (x) / M_PI)

//判断设备是否是ipad
#define isiPad        ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)


//判断设备是否IPHONE5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)