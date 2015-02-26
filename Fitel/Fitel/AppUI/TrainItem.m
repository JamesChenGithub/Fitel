//
//  TrainItem.m
//  Fitel
//
//  Created by James on 2/22/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "TrainItem.h"

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
            self.key = @"暖身";
            break;
            
        case 2:
            self.key = @"深蹲教學";
            break;
            
        case 3:
            self.key = @"Tabata初级";
            break;
            
        case 4:
            self.key = @"Tabata进阶";
            break;
            
        case 5:
            self.key = @"Tabata腹肌";
            break;
            
        case 6:
            self.key = @"手肘碰膝";
            break;
            
        case 7:
            self.key = @"仰卧起坐";
            break;
            
        case 8:
            self.key = @"伏地挺身";
            break;
        case 9:
            self.key = @"徒手深蹲";
            break;
            
        case 10:
            self.key = @"棒式";
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
            MKNetworkOperation *op = [[MKNetworkOperation alloc] initWithURLString:item.videoPath params:nil httpMethod:@"Get"];
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
