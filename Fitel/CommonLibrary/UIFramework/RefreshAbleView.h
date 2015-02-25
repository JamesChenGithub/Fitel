//
//  RefreshAbleView.h
//  iLunch
//
//  Created by James on 15-2-4.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RefreshAbleView <NSObject>

@property (nonatomic, assign) NSInteger refreshHeight;

- (void)willLoading;
- (void)releaseLoading;
- (void)loading;
- (void)loadingOver;

@end
