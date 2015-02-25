//
//  BaseCollectionViewController.m
//  iLunchCommon
//
//  Created by James on 3/12/14.
//  Copyright (c) 2014 iLunch. All rights reserved.
//

#import "BaseCollectionViewController.h"

@interface BaseCollectionViewController ()

@end

@implementation BaseCollectionViewController


- (UICollectionViewLayout *)collectionLayout
{
    if ([IOSDeviceConfig sharedConfig].isIPad)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(220, 280);
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.minimumInteritemSpacing = 20;
        layout.minimumLineSpacing = 20;
        return layout;
    }
    else
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(130, 180);
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 20;
        return layout;
    }
}

- (id)init
{
    UICollectionViewLayout *layout = [self collectionLayout];
    return [self initWithCollectionViewLayout:layout];
}

#define kCollectionViewIdentifier  @"CollectionViewCellIdentifier";



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kClearColor;
    [self configCollectionView];
}

- (NSString *)cellIdentifier
{
    return kCollectionViewIdentifier;
}

- (void)configCollectionView
{
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:[self cellIdentifier]];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[self cellIdentifier] forIndexPath:indexPath];
    
    
    
    cell.backgroundColor = [UIColor randomFlatColor];
    return cell;
}


#pragma mark - 
#pragma Same as CommonBaseViewController method
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([IOSDeviceConfig sharedConfig].isIPad)
    {
        [self layoutOnViewWillAppear];
    }
}


- (void)layoutSubviewsFrame
{
//    DebugLog(@"%@.bounds = %@ collectionView.frame.bounds = %@", self.class, NSStringFromCGRect(self.view.bounds), NSStringFromCGRect(self.collectionView.bounds));
    self.collectionView.frame = self.view.bounds;
    [super layoutSubviewsFrame];
}

//- (void)viewWillLayoutSubviews
//{
//    if (![self asChild])
//    {
//        [super viewWillLayoutSubviews];
//    }
//    else
//    {
//        if (CGSizeEqualToSize(self.childSize, CGSizeZero)) {
//            [super viewWillLayoutSubviews];
//        }
//        else
//        {
//            self.view.bounds = CGRectFromCGSize([self childSize]);
//        }
//    }
//}


@end
