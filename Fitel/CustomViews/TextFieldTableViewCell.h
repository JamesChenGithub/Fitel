//
//  TextFieldTableViewCell.h
//  iLunch
//
//  Created by James on 15-1-7.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNewAddressGenderTableViewCell : UITableViewCell
{
    ImageTitleButton *_male;
    UIImageView      *_line;
    ImageTitleButton *_female;
}

@end

@interface TextFieldTableViewCell : UITableViewCell
{
    UITextField *_edit;
}

- (instancetype)initWith:(NSString *)tip reuseIdentifier:(NSString *)reuseIdentifier;
- (instancetype)initWith:(NSString *)tip placeHolder:(NSString *)holder reuseIdentifier:(NSString *)reuseIdentifier;
- (instancetype)initWith:(NSString *)tip placeHolder:(NSString *)holder locateIcon:(UIImage *)icon reuseIdentifier:(NSString *)reuseIdentifier;
- (instancetype)initWith:(NSString *)tip placeHolder:(NSString *)holder locateIcon:(UIImage *)icon action:(CommonBlock)act reuseIdentifier:(NSString *)reuseIdentifier;

@end

