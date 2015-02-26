//
//  TrainItem.h
//  Fitel
//
//  Created by James on 2/22/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrainCacheOperation : MKNetworkOperation

@end


@class TrainItem;
@interface TrainKeyValue : NSObject

@property (nonatomic, copy) NSString *key;
@property (nonatomic, retain) NSMutableArray *trainList;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, readonly) NSInteger playInterval;
@property (nonatomic, readonly) NSInteger duration;
@property (nonatomic, strong) TrainItem *playingItem;

- (instancetype)initWithType:(NSInteger)type value:(NSArray *)value;

- (BOOL)canPlay;

- (void)startCache;

- (void)cancelCache;

- (TrainItem *)nextPlayingItem;
- (TrainItem *)getNextPlayingItem;


@end

@interface TrainItem : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *videoPath;
@property (nonatomic, copy) NSString *imagePath;

- (NSString *)cachePath;

@end
