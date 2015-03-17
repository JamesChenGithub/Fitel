//
//  MainViewController.m
//  Fitel
//
//  Created by James on 2/17/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "MainViewController.h"


@interface ProgressView : UIView
{
    UIProgressView *_progressView;
    UILabel        *_progress;
}

- (void)setProgress:(CGFloat)progress;

@end


@implementation ProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:CGRectMake(0, 0, 200, 30)])
    {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(kDefaultMargin, kDefaultMargin, 200 - 2*kDefaultMargin, kDefaultMargin)];
        _progressView.progressTintColor = kGreenColor;
        _progressView.trackTintColor = kWhiteColor;
        [self addSubview:_progressView];
        
        _progress = [[UILabel alloc] init];
        _progress.textColor = kWhiteColor;
        _progress.font = [UIFont systemFontOfSize:13];
        _progress.textAlignment = NSTextAlignmentCenter;
        _progress.frame = CGRectMake(kDefaultMargin, _progressView.frame.origin.y + _progress.frame.size.height + 2*kDefaultMargin, 200 - kDefaultMargin * 2, 18);
        //        _progress.backgroundColor = kRedColor;
        _progress.text = @"0/100";
        [self addSubview:_progress];
    }
    return self;
}

- (void)setProgress:(CGFloat)progress
{
    _progressView.progress = progress;
    _progress.text = [NSString stringWithFormat:@"%d/100", (int)(100 * progress)];
}

@end


@implementation TrainCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addOwnViews];
        [self configOwnViews];
        self.backgroundColor = [UIColor flatWhiteColor];
    }
    return self;
}

- (void)addOwnViews
{
    _imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_imageView];
    
    _title = [[UILabel alloc] init];
    _title.textAlignment = NSTextAlignmentCenter;
    _title.textColor = kBlackColor;
    _title.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_title];
}

- (void)configTrain:(TrainKeyValue *)item
{
    self.item = item;
    _title.text = item.key;
    _imageView.image = item.image;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self relayoutFrameOfSubViews];
}

- (void)relayoutFrameOfSubViews
{
    CGRect rect = self.contentView.bounds;
    [_imageView sizeWith:CGSizeMake(rect.size.width, rect.size.width)];
    
    [_title sizeWith:CGSizeMake(rect.size.width, rect.size.height - rect.size.width)];
    [_title layoutBelow:_imageView];
}



@end


@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (NSString *)cellIdentifier
{
    return @"MainViewController_TrainCollectionViewCell";
}

//- (void)addHeaderView
//{
//    self.headerView = [[HeadRefreshView alloc] init];
//}


- (void)addRefreshScrollView
{
    CGRect rect = self.view.bounds;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(kDefaultMargin, kDefaultMargin, kDefaultMargin, kDefaultMargin);
    layout.minimumInteritemSpacing = kDefaultMargin;
    layout.minimumLineSpacing = kDefaultMargin;
    CGFloat width = (rect.size.width - 2*layout.minimumInteritemSpacing - (layout.sectionInset.left + layout.sectionInset.right))/3;
    layout.itemSize = CGSizeMake(width , width + 30);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = kClearColor;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[TrainCollectionViewCell class] forCellWithReuseIdentifier:[self cellIdentifier]];
    _collectionView.frame = self.view.bounds;
    _collectionView.autoresizesSubviews = YES;
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.refreshScrollView = _collectionView;
}

- (void)reload
{
    [_collectionView reloadData];
    [self refreshCompleted];
}

//- (void)layoutOnIPhone
//{
//    _collectionView.frame = self.view.bounds;
//}

- (void)request:(BOOL)cache
{
    NSURL *url = [NSURL URLWithString:kAppTrainURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    if (cache)
    {
        request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    }
    
    [request setValue:@"text/xml;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    
    __weak typeof(self) ws = self;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *urlResponce, NSData *data, NSError *error)
     {
         
         [[HUDHelper sharedInstance] stopLoading];
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         
         
         if (error != nil)
         {
             [[HUDHelper sharedInstance] tipMessage:kNetwork_Error_Str];
         }
         else
         {
             NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             DebugLog(@"=========================>>>>>>>>\nresponseString is :\n %@" , responseString);
             // TODO : 正则表解析XML返回的结果
             // 改下面这句
             NSDictionary *dic = [responseString objectFromJSONString];
             NSArray *trains = [dic objectForKey:@"list"];
             NSMutableArray *array = [NSObject loadItem:[TrainItem class] fromArrayDictionary:trains];
             
             NSMutableArray *realArray = [NSMutableArray array];
             
             
             for (NSInteger i = 1; i <= 10; i++)
             {
                 NSMutableArray *value = [NSMutableArray array];
                 for (NSInteger j = 0; j<array.count; j++)
                 {
                     TrainItem *item = [array objectAtIndex:j];
                     if ([item.type integerValue] == i)
                     {
                         [value addObject:item];
                     }
                 }
                 
                 TrainKeyValue *tkv = [[TrainKeyValue alloc] initWithType:i value:value];
                 [realArray addObject:tkv];
             }
             
             ws.trainItems = realArray;
             [ws reload];
         }
     }];
}

- (void)onRefresh
{
    [self request:NO];
}

- (void)configOwnViews
{
    [self request:NO];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0 || section == 3)
    {
        return 2;
    }
    else
    {
        return 3;
    }
}


- (NSInteger)trainItemIndexOf:(NSIndexPath *)path
{
    NSInteger index = 0;
    
    for (NSInteger i = 1; i<= path.section; i++)
    {
        index += [self collectionView:_collectionView numberOfItemsInSection:i-1];
    }
    
    return index + path.row;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TrainCollectionViewCell *cell = (TrainCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[self cellIdentifier] forIndexPath:indexPath];
    
    
    NSInteger index = [self trainItemIndexOf:indexPath];
    
    TrainKeyValue *item = [self.trainItems objectAtIndex:index];
    [cell configTrain:item];
    return cell;
}

- (void)onDownloadChanged:(NSNotification *)notify
{
    
    TrainKeyValue *item = (TrainKeyValue *)notify.object;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (item == self.selectKV)
        {
            if ([item canPlay])
            {
                [self.progressHUD hide:YES];
//                [[HUDHelper sharedInstance] stopLoading];
                [[NSNotificationCenter defaultCenter] removeObserver:self];
                
                TrainViewController *vc = [[TrainViewController alloc] init];
                vc.trainKeyValue = item;
                [[AppDelegate sharedAppDelegate] pushViewController:vc];
            }
        }
    });
}

- (void)onDownloadProgressChanged:(NSNotification *)notify
{
    TrainKeyValue *item = (TrainKeyValue *)notify.object;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (item == self.selectKV)
        {
            NSDictionary *ui = notify.userInfo;
            ProgressView *pv = (ProgressView *) self.progressHUD.customView;
            [pv setProgress:[(NSNumber *)(ui[@"DownloadProgress"]) floatValue]];
            
        }
    });
    
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = [self trainItemIndexOf:indexPath];
    
    TrainKeyValue *item = [self.trainItems objectAtIndex:index];
    
    if ([item canPlay])
    {
        TrainViewController *vc = [[TrainViewController alloc] init];
        vc.trainKeyValue = item;
        [[AppDelegate sharedAppDelegate] pushViewController:vc];
    }
    else
    {
        self.selectKV = item;
//        [[HUDHelper sharedInstance] loading];
        [item startCache];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDownloadChanged:) name:kTrainItemDownloadCompleted object:nil];
        
        
        self.progressHUD = [[MBProgressHUD alloc] initWithWindow:[AppDelegate sharedAppDelegate].window];
        [[AppDelegate sharedAppDelegate].window addSubview:self.progressHUD];
        
        // The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
        // Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
        self.progressHUD.customView = [[ProgressView alloc] init];
        
        // Set custom view mode
        self.progressHUD.mode = MBProgressHUDModeCustomView;
        
        [self.progressHUD show:YES];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDownloadProgressChanged:) name:kTrainItemDownloadProgress object:nil];
    }
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}


@end
