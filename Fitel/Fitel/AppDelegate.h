//
//  AppDelegate.h
//  Fitel
//
//  Created by James on 2/17/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : BaseAppDelegate
{
    MKNetworkEngine *_cacheEngine;
}
@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, readonly) MKNetworkEngine *cacheEngine;


@end

