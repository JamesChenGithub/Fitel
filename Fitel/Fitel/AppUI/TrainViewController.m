//
//  TrainViewController.m
//  Fitel
//
//  Created by James on 2/25/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "TrainViewController.h"

@implementation TrainKeyValueButton

- (instancetype)initWith:(NSString *)title
{
    if (self = [super init])
    {
        [self setTitle:title forState:UIControlStateNormal];
        self.layer.borderColor = kGreenColor.CGColor;
        self.layer.borderWidth = 3;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.backgroundColor = selected ? kGreenColor : kClearColor;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self relayoutFrameOfSubViews];
}

- (void)relayoutFrameOfSubViews
{
    self.layer.cornerRadius = self.bounds.size.width/2;
}

@end

@implementation TrainKeyListView

- (instancetype)init
{
    if (self = [super init])
    {
        _scrollView = [[UIScrollView alloc] init];
        [self addSubview:_scrollView];
        
        self.trainList = [NSMutableArray array];
        
        for (NSInteger i = 1; i <= 10; i++)
        {
            TrainKeyValueButton *btn = [[TrainKeyValueButton alloc] initWith:[NSString stringWithFormat:@"%d", (int)i]];
            
            [_scrollView addSubview:btn];
            [self.trainList addObject:btn];
        }
        
    }
    return self;
}

- (void)select
{
    for (TrainKeyValueButton *btn in self.trainList)
    {
        if (!btn.selected)
        {
            btn.selected = YES;
            break;
        }
    }
}

- (BOOL)isTrainOver
{
    BOOL istrainOver = YES;
    for (TrainKeyValueButton *btn in self.trainList)
    {
        istrainOver = istrainOver && btn.selected;
        if (!istrainOver)
        {
            return istrainOver;
        }
    }
    
    return istrainOver;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self relayoutFrameOfSubViews];
}

#define kHorMargin 5

- (void)relayoutFrameOfSubViews
{
    CGRect rect = self.bounds;
    _scrollView.frame = rect;
    rect = _scrollView.bounds;
    NSInteger count = self.trainList.count;
    if (count * 30 + (count + 1) * kHorMargin > rect.size.width)
    {
        _scrollView.contentSize = CGSizeMake(count * 30 + (count + 1) * kHorMargin, 0);
        [_scrollView gridViews:self.trainList inColumn:count size:CGSizeMake(30, 30) margin:CGSizeMake(kHorMargin, kDefaultMargin) inRect:CGRectInset(rect, kHorMargin, kDefaultMargin)];
    }
    else
    {
        _scrollView.contentSize = CGSizeMake(0, 0);
        [_scrollView gridViews:self.trainList inColumn:count size:CGSizeMake(30, 30) margin:CGSizeMake(kHorMargin, kDefaultMargin) inRect:CGRectInset(rect, (rect.size.width - (count * 30 + (count - 1) * kHorMargin))/2, kDefaultMargin)];
    }
    
    
}

@end


@implementation TrainViewController

- (void)dealloc
{
    [_timerView stop];
    [_player stop];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    if (_timerView.isPaused)
    {
        [_timerView resume];
    }

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_timerView pause];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapPlayOrPause:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
}

- (void)onTapPlayOrPause:(UITapGestureRecognizer *)tap
{
    if (tap.state == UIGestureRecognizerStateEnded)
    {
        if (_player.playbackState == MPMoviePlaybackStatePlaying)
        {
            [_player pause];
            [_timerView pause];
        }
        else if (_player.playbackState == MPMoviePlaybackStatePaused)
        {
            [_player play];
            [_timerView resume];
        }
        else
        {
            [_timerView pauseOrResume];
        }
    }
}

- (void)onWaitEnd:(TrainKeyValue *)kv
{
    _videoIamgeView.hidden = YES;
    TrainItem *item = [kv nextPlayingItem];
    if (item)
    {
        [_videoIamgeView sd_setImageWithURL:[NSURL URLWithString:item.imagePath] placeholderImage:_videoIamgeView.image];
    }
    
    
    NSString *path = [kv.playingItem cachePath];
    NSURL *ur = [NSURL fileURLWithPath:path];
    [_player setContentURL:ur];
    [_player play];
    
}

- (void)onRunEnd:(TrainKeyValue *)kv
{
    _videoIamgeView.hidden = NO;
    [_player stop];
}

- (void)onSleepEnd:(TrainKeyValue *)kv
{
    TrainItem *item = [kv nextPlayingItem];
    if (!item)
    {
        [_listView select];
        
        if ([_listView isTrainOver])
        {
            [[AppDelegate sharedAppDelegate] popViewController];
            return;
        }
    }
    [kv getNextPlayingItem];
    [self onWaitEnd:kv];
    
    
    
}

- (void)addOwnViews
{
    
    
    _player = [[MPMoviePlayerController alloc] initWithContentURL:nil];
    [_player setMovieSourceType:MPMovieSourceTypeFile];
    _player.scalingMode = MPMovieScalingModeNone;
    _player.controlStyle = MPMovieControlStyleNone;
    _player.backgroundView.backgroundColor = kBlackColor;
    _player.repeatMode = MPMovieRepeatModeNone;
    [self.view addSubview: _player.view];
    _playerView = _player.view;
    [_player play];
    
    _videoIamgeView = [[UIImageView alloc] init];
    _videoIamgeView.image = self.trainKeyValue.image;
    [self.view addSubview:_videoIamgeView];
    
    _backButton = [[UIButton alloc] init];
    [_backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_backButton setBackgroundColor:[[UIColor flatWhiteColor] colorWithAlphaComponent:0.5]];
    _backButton.layer.cornerRadius = 15;
    [_backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];
    
    _timerView = [[CircularTimer alloc] init];
    _timerView.trainKV = self.trainKeyValue;
    __weak typeof(self) ws = self;
    _timerView.waitEndEvent = ^(TrainKeyValue *kv) {
        [ws onWaitEnd:kv];
    };
    
    _timerView.runEndEvent = ^(TrainKeyValue *kv) {
        [ws onRunEnd:kv];
    };
    
    _timerView.sleepEndEvent = ^(TrainKeyValue *kv) {
        [ws onSleepEnd:kv];
    };
    [self.view addSubview:_timerView];
    
    _listView = [[TrainKeyListView alloc] init];
    [_listView select];
    [self.view addSubview:_listView];
}


- (void)goBack:(UIButton *)btn
{
    [[AppDelegate sharedAppDelegate] popViewController];
}

- (BOOL)shouldAutorotate
{
    [self layoutSubviewsFrame];
    return YES;
}

- (void)layoutOnIPhone
{
    CGRect rect = self.view.bounds;
    if ([IOSDeviceConfig sharedConfig].isPortrait)
    {
        [_playerView sizeWith:CGSizeMake(rect.size.width, 240)];
        [_playerView alignParentTopWithMargin:20];
        [_videoIamgeView sameWith:_playerView];
        
        [_backButton sizeWith:CGSizeMake(30, 30)];
        [_backButton alignParentLeftWithMargin:kDefaultMargin];
        [_backButton alignParentTopWithMargin:20 + kDefaultMargin];
        
        
        [_listView sizeWith:CGSizeMake(rect.size.width, 46)];
        [_listView alignParentBottom];
        
        [_timerView sizeWith:CGSizeMake(160, 160)];
        
        _timerView.center = CGPointMake(rect.size.width/2, (_listView.frame.origin.y - (_playerView.frame.origin.y + _playerView.frame.size.height))/2 + (_playerView.frame.origin.y + _playerView.frame.size.height));
        
    }
    else
    {
        [_playerView sizeWith:CGSizeMake(rect.size.width, rect.size.height - 46 - kDefaultMargin)];
        [_videoIamgeView sameWith:_playerView];
        
        [_backButton sizeWith:CGSizeMake(30, 30)];
        [_backButton alignParentLeftWithMargin:kDefaultMargin];
        [_backButton alignParentTopWithMargin:kDefaultMargin];
        
        
        [_timerView sizeWith:CGSizeMake(100, 100)];
        [_timerView alignParentRightWithMargin:kDefaultMargin];
        [_timerView alignBottom:_playerView margin:kDefaultMargin];
        
        [_listView sizeWith:CGSizeMake(rect.size.width, 46)];
        [_listView alignParentBottom];
    }
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}
@end
