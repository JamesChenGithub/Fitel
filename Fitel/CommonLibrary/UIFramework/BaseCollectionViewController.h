//
//  BaseCollectionViewController.h
//  iLunchCommon
//
//  Created by James on 3/12/14.
//  Copyright (c) 2014 iLunch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionViewController : UICollectionViewController

- (UICollectionViewLayout *)collectionLayout;

- (NSString *)cellIdentifier;

- (void)configCollectionView;

//- (void)layoutOnViewWillAppear;
//
//- (void)layoutSubviewsFrame;
//
//- (void)layoutOnIPhone;
//
//- (void)layoutOnIPadInPortrait;
//
//- (void)layoutOnIPadInLandScape;

//- (void)layoutSubviewsFrame;

@end
