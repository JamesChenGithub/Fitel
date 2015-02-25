//
//  AppInfoView.h
//  iLunch
//
//  Created by James on 14-7-22.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppInfoView : UIView
{
    UIImageView *_appIcon;
    UILabel *_appName;
    UILabel *_appSlogan;
}
- (instancetype)initWith:(UIImage *)appIcon name:(NSString *)name slogan:(NSString *)slogan;

@end
