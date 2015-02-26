//
//  TrainItem.m
//  Fitel
//
//  Created by James on 2/22/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "TrainItem.h"

@implementation TrainCacheOperation

- (void)cancel
{
    [super cancel];
    
    NSString *docPath = [PathUtility getDocumentPath];
    
    [PathUtility createDirectoryAtDocument:@"Video"];
    
    NSString *videoPath = [NSString stringWithFormat:@"%@/Video/", docPath];
    NSString *fileName = [self.url md5];
    NSString *path = [NSString stringWithFormat:@"%@%@.mp4", videoPath, fileName];
    [PathUtility deleteFileAtPath:path];
}
@end

@implementation TrainKeyValue

- (instancetype)initWithType:(NSInteger)type value:(NSArray *)value
{
    if (self = [self init])
    {
        self.trainList = [NSMutableArray arrayWithArray:value];
        self.type = type;
    }
    return self;
}

//- (UIImage *)image
//{
//    return [UIImage imageNamed:[NSString stringWithFormat:@"type%d", (int)_type]];
//}

- (void)setType:(NSInteger)type
{
    _type = type;
    switch (_type)
    {
        case 1:
            self.key = kTrain_Type1_Str;
            break;
            
        case 2:
            self.key = kTrain_Type2_Str;
            break;
            
        case 3:
            self.key = kTrain_Type3_Str;
            break;
            
        case 4:
            self.key = kTrain_Type4_Str;
            break;
            
        case 5:
            self.key = kTrain_Type5_Str;
            break;
            
        case 6:
            self.key = kTrain_Type6_Str;
            break;
            
        case 7:
            self.key = kTrain_Type7_Str;
            break;
            
        case 8:
            self.key = kTrain_Type8_Str;
            break;
        case 9:
            self.key = kTrain_Type9_Str;
            break;
            
        case 10:
            self.key = kTrain_Type10_Str;
            break;
            
        default:
            
            break;
    }
    
    _image = [UIImage imageNamed:[NSString stringWithFormat:@"type%d", (int)_type]];
}

- (NSInteger)playInterval
{
    //    if (self.type >= 3 && self.type <= 5)
    //    {
    //        return 65;
    //    }
    return 10;
}

- (NSInteger)duration
{
    if (_type == 2)
    {
        return 65;
    }
    return 20;
}

- (NSString *)videoDir
{
    NSString *docPath = [PathUtility getDocumentPath];
    
    [PathUtility createDirectoryAtDocument:@"Video"];
    
    NSString *videoPath = [NSString stringWithFormat:@"%@/Video/", docPath];
    return videoPath;
}

- (BOOL)canPlay
{
    if (self.trainList.count >= 2)
    {
        TrainItem *item0 = self.trainList[0];
        TrainItem *item1 = self.trainList[1];
        if ([PathUtility isExistFile:[item0 cachePath]] && [PathUtility isExistFile:[item1 cachePath]])
        {
            return YES;
        }
    }
    else
    {
        if (self.trainList.count)
        {
            // == 1
            TrainItem *item = self.trainList[0];
            
            if ([PathUtility isExistFile:[item cachePath]])
            {
                return YES;
            }
        }
        
    }
    return NO;
}

- (BOOL)allDownloaded
{
    NSString *dir = [self videoDir];
    for (NSInteger i = 0; i < self.trainList.count; i++)
    {
        TrainItem *item = self.trainList[i];
        NSString *fileName = [item.videoPath md5];
        
        NSString *path = [NSString stringWithFormat:@"%@%@.mp4", dir, fileName];
        if (![PathUtility isExistFile:path])
        {
            return NO;
        }
    }
    
    return YES;
}

- (void)startCache
{
    MKNetworkEngine *engine = [AppDelegate sharedAppDelegate].cacheEngine;
    
    NSString *dir = [self videoDir];
    for (TrainItem *item in self.trainList)
    {
        NSString *fileName = [item.videoPath md5];
        
        NSString *path = [NSString stringWithFormat:@"%@%@.mp4", dir, fileName];
        if (![PathUtility isExistFile:path]) {
            MKNetworkOperation *op = [[TrainCacheOperation alloc] initWithURLString:item.videoPath params:nil httpMethod:@"Get"];
            __weak typeof(self) ws = self;
            [op onDownloadProgressChanged:^(double progress) {
                if (progress >= 1.0)
                {
                    // 下载完成
                    [[NSNotificationCenter defaultCenter] postNotificationName:kTrainItemDownloadCompleted object:ws];
                }
            }];
            [op addDownloadStream:[NSOutputStream outputStreamToFileAtPath:path append:YES]];
            [engine enqueueOperation:op];
        }
    }
}

- (void)cancelCache
{
    MKNetworkEngine *engine = [AppDelegate sharedAppDelegate].cacheEngine;
    [engine cancelAllOperations];
}

- (TrainItem *)playingItem
{
    if (_playingItem == nil && self.trainList.count)
    {
        _playingItem = self.trainList[0];
    }
    return _playingItem;
}

- (TrainItem *)nextPlayingItem
{
    if (_playingItem == nil && self.trainList.count)
    {
        return self.trainList[0];
    }
    else
    {
        NSInteger index = [self.trainList indexOfObject:_playingItem];
        if (index + 1 >= self.trainList.count)
        {
            return nil;
        }
        else
        {
            return self.trainList[index + 1];
        }
    }
}

- (TrainItem *)getNextPlayingItem
{
    TrainItem *item = [self nextPlayingItem];
    _playingItem = item;
    return self.playingItem;
}

@end

@implementation TrainItem

- (NSString *)cachePath
{
    NSString *docPath = [PathUtility getDocumentPath];
    
    [PathUtility createDirectoryAtDocument:@"Video"];
    
    NSString *videoPath = [NSString stringWithFormat:@"%@/Video/", docPath];
    NSString *fileName = [self.videoPath md5];
    NSString *path = [NSString stringWithFormat:@"%@%@.mp4", videoPath, fileName];
    return path;
}

@end
