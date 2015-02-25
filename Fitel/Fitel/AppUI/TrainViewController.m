//
//  TrainViewController.m
//  Fitel
//
//  Created by James on 2/25/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "TrainViewController.h"

@implementation TrainKeyValueButton

- (instancetype)initWith:(TrainKeyValue *)value
{
    if (self = [super init])
    {
        self.trainKeyValue = value;
        [self setTitle:[NSString stringWithFormat:@"%d", (int)self.trainKeyValue.type] forState:UIControlStateNormal];
        self.layer.borderColor = kGreenColor.CGColor;
        self.layer.borderWidth = 3;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.layer.borderColor = selected ? kRedColor.CGColor : kGreenColor.CGColor;
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

- (instancetype)initWith:(NSMutableArray *)list
{
    if (self = [super init])
    {
        _scrollView = [[UIScrollView alloc] init];
        [self addSubview:_scrollView];
        
        self.trainList = [NSMutableArray array];
        for (TrainKeyValue *kv in list)
        {
            TrainKeyValueButton *btn = [[TrainKeyValueButton alloc] initWith:kv];
            [_scrollView addSubview:btn];
            [self.trainList addObject:btn];
        }
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self relayoutFrameOfSubViews];
}

- (void)relayoutFrameOfSubViews
{
    CGRect rect = self.bounds;
    _scrollView.frame = rect;
    rect = _scrollView.bounds;
    NSInteger count = self.trainList.count;
    if (count * 30 + (count + 1) * kDefaultMargin > rect.size.width)
    {
        _scrollView.contentSize = CGSizeMake(count * 30 + (count + 1) * kDefaultMargin, 0);
        [_scrollView gridViews:self.trainList inColumn:count size:CGSizeMake(30, 30) margin:CGSizeMake(kDefaultMargin, kDefaultMargin) inRect:CGRectInset(rect, kDefaultMargin, kDefaultMargin)];
    }
    else
    {
        _scrollView.contentSize = CGSizeMake(0, 0);
        [_scrollView gridViews:self.trainList inColumn:count size:CGSizeMake(30, 30) margin:CGSizeMake(kDefaultMargin, kDefaultMargin) inRect:CGRectInset(rect, (rect.size.width - (count * 30 + (count - 1) * kDefaultMargin))/2, kDefaultMargin)];
    }
    
    
}

@end


@implementation TrainViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)addOwnViews
{
//    _playerView = [[UIView alloc] init];
//    _playerView.backgroundColor = kBlackColor;
//    [self.view addSubview:_playerView];
    
    _player = [[MPMoviePlayerController alloc] initWithContentURL:nil];
//    [_player setContentURL:nil];
    [_player setMovieSourceType:MPMovieSourceTypeFile];
//    [[_player view] setFrame:self.view.bounds];
//    [_player view].backgroundColor = [UIColor greenColor];
    
    _player.scalingMode = MPMovieScalingModeNone;
//    _player.controlStyle = MPMovieControlModeDefault;
    _player.backgroundView.backgroundColor = kBlackColor;
    _player.repeatMode = MPMovieRepeatModeNone;
    
    [self.view addSubview: _player.view];
    _playerView = _player.view;
    [_player play];
    
    
    _backButton = [[UIButton alloc] init];
    [_backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [_backButton setBackgroundColor:[[UIColor flatWhiteColor] colorWithAlphaComponent:0.5]];
    _backButton.layer.cornerRadius = 15;
    [_backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];
    
    _timerView = [[CircularTimer alloc] init];
    _timerView.trainKV = self.trainKeyValue;
    [self.view addSubview:_timerView];
    [_timerView start];
    
    _listView = [[TrainKeyListView alloc] initWith:self.trainList];
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
        
        [_backButton sizeWith:CGSizeMake(30, 30)];
        [_backButton alignParentLeftWithMargin:kDefaultMargin];
        [_backButton alignParentTopWithMargin:20 + kDefaultMargin];
        
        
        [_listView sizeWith:CGSizeMake(rect.size.width, 46)];
        [_listView alignParentBottom];
        
        [_timerView sizeWith:CGSizeMake(100, 100)];
        
        _timerView.center = CGPointMake(rect.size.width/2, (_listView.frame.origin.y - (_playerView.frame.origin.y + _playerView.frame.size.height))/2 + (_playerView.frame.origin.y + _playerView.frame.size.height));
        
    }
    else
    {
        [_playerView sizeWith:CGSizeMake(rect.size.width, rect.size.height - 46 - kDefaultMargin)];
        //        [_playerView layoutParentCenter];
        //        _playerView.center = CGPointMake(rect.size.width/2, 38 + (rect.size.height - 46 - 38)/2);
        
        [_backButton sizeWith:CGSizeMake(30, 30)];
        [_backButton alignParentLeftWithMargin:kDefaultMargin];
        [_backButton alignParentTopWithMargin:kDefaultMargin];
        
        
        [_timerView sizeWith:CGSizeMake(60, 60)];
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
