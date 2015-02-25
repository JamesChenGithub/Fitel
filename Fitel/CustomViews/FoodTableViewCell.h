//
//  FoodTableViewCell.h
//  iLunch
//
//  Created by James on 15-1-10.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodTableViewCell : UITableViewCell
{
@protected
    UIImageView *_foodIcon;
    UILabel     *_foodName;
}

@end


@interface FoodCollectTableViewCell : FoodTableViewCell
{
@protected
    UIImageView *_tipIcon;
}

@end

@interface FoodCommentTableViewCell : FoodCollectTableViewCell
{
@protected
    UILabel *_comment;
}

+ (CGFloat)heightOf:(NSString *)comment;

- (void)configWith:(NSString *)comment;

@end


@interface FoodOrderTableViewCell : FoodTableViewCell
{
@protected
    UILabel *_foodPrice;
    UILabel *_foodNumber;
}
@end

@interface FoodShoppingCartTableViewCell : FoodTableViewCell
{
@protected
    AddDecView *_addDecView;
}
@end


@interface FoodDetailTableViewCell : FoodShoppingCartTableViewCell
{
@protected
    UIView *_contentPanel;
    
@protected
    
    UIButton *_addButton;
    
    UILabel *_soldNumber;
    UILabel *_foodPrice;
    
    ImageTitleButton *_comment;
    ImageTitleButton *_praise;
    UIButton         *_likeByCurrentUser;
}
@end
