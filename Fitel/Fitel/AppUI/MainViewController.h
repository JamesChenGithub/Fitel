//
//  MainViewController.h
//  Fitel
//
//  Created by James on 2/17/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "ScrollRefreshViewController.h"

@interface TrainCollectionViewCell : UICollectionViewCell
{
@protected
    UIImageView *_imageView;
    UILabel *_title;
}

@property (nonatomic, weak) TrainKeyValue *item;

- (void)configTrain:(TrainKeyValue *)item;

@end

@interface MainViewController : ScrollRefreshViewController<UICollectionViewDataSource, UICollectionViewDelegate>
{
    UICollectionView *_collectionView;
}

@property (nonatomic, strong) NSMutableArray *trainItems;

@property (nonatomic, strong) TrainKeyValue *selectKV;

@property (nonatomic, strong) MBProgressHUD *progressHUD;

@end
