//
//  CalculateViewController.h
//  Fitel
//
//  Created by James on 2/17/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "BaseViewController.h"

@interface GenderArea : UIView
{
@protected
    UILabel *_title;
    ImageTitleButton *_male;
    ImageTitleButton *_female;
}

- (BOOL)isMale;

@end

@interface TextFieldArea : UIView
{
@protected
    UILabel     *_title;
    UITextField *_textField;
}

@property (nonatomic, readonly) UITextField *textField;

- (instancetype)initWith:(NSString *)title;

- (BOOL)isVailade;

- (CGFloat)areaValue;

@end


@interface CalculateViewController : BaseViewController<UIActionSheetDelegate>
{
    UIScrollView *_scrollView;
    GenderArea *_gender;
    TextFieldArea *_ageArea;
    TextFieldArea *_heightArea;
    TextFieldArea *_weightArea;
    
    UILabel *_typeTip;
    ImageTitleButton *_typeButton;
    ImageTitleButton *_calculateButton;
    
    
    KeyValue *_selectedWorkType;
    
    NSMutableArray *_workType;
}

@end
