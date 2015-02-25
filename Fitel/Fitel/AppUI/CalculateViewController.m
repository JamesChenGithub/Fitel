//
//  CalculateViewController.m
//  Fitel
//
//  Created by James on 2/17/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "CalculateViewController.h"


@implementation GenderArea

- (void)addOwnViews
{
    UIImage *uncheck = kAddressManage_Gender_Uncheck_Icon;
    UIImage *check = kAddressManage_Gender_Checked_Icon;
    
    _title = [[UILabel alloc] init];
    _title.backgroundColor = kClearColor;
    _title.text = kCalculate_Gender_Str;
    [self addSubview:_title];
    
    _male = [[ImageTitleButton alloc] initWithStyle:EImageLeftTitleRightLeft];
    [_male setImage:uncheck forState:UIControlStateNormal];
    [_male setImage:check forState:UIControlStateSelected];
    _male.imageSize = uncheck.size;
    _male.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_male setTitleColor:kBlackColor forState:UIControlStateNormal];
    [_male setTitle:kCalculate_Gender_Male_Str forState:UIControlStateNormal];
    [_male addTarget:self action:@selector(onCheck:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_male];
    
    _female = [[ImageTitleButton alloc] initWithStyle:EImageLeftTitleRightLeft];
    [_female setImage:uncheck forState:UIControlStateNormal];
    [_female setImage:check forState:UIControlStateSelected];
    _female.imageSize = uncheck.size;
    _female.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_female setTitleColor:kBlackColor forState:UIControlStateNormal];
    [_female setTitle:kCalculate_Gender_Female_Str forState:UIControlStateNormal];
    [_female addTarget:self action:@selector(onCheck:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_female];
    
    [self onCheck:_male];
}

- (BOOL)isMale
{
    return _male.selected;
}

- (void)onCheck:(UIButton *)button
{
    if (button == _male)
    {
        _female.selected = NO;
        if (!_male.selected)
        {
            _male.selected = YES;
        }
    }
    else
    {
        _male.selected = NO;
        if (!_female.selected)
        {
            _female.selected = YES;
        }
    }
}



- (void)relayoutFrameOfSubViews
{
    CGRect bounds = self.bounds;
    bounds = CGRectInset(bounds, kDefaultMargin, kDefaultMargin);
    
    [_title sizeWith:CGSizeMake(bounds.size.width, 20)];
    [_title layoutParentHorizontalCenter];
    [_title alignParentTopWithMargin:kDefaultMargin];
    
    [_male sizeWith:CGSizeMake(bounds.size.width/2, bounds.size.height - 20)];
    [_male layoutBelow:_title];
    [_male alignParentLeftWithMargin:kDefaultMargin];
    
    [_female sameWith:_male];
    [_female alignParentRightWithMargin:kDefaultMargin];
}


@end


@implementation TextFieldArea

- (instancetype)initWith:(NSString *)title
{
    if (self = [super init])
    {
        _title.text = title;
    }
    return self;
}

- (void)addOwnViews
{
    _title = [[UILabel alloc] init];
    _title.backgroundColor = kClearColor;
    [self addSubview:_title];
    
    _textField = [[UITextField alloc] init];
    _textField.borderStyle = UITextBorderStyleBezel;
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_textField];
}

- (BOOL)isVailade
{
    return [_textField.text floatValue] > 0;
}

- (CGFloat)areaValue
{
    return [_textField.text floatValue];
}


- (void)relayoutFrameOfSubViews
{
    CGRect bounds = self.bounds;
    bounds = CGRectInset(bounds, kDefaultMargin, 0);
    
    [_title sizeWith:CGSizeMake(bounds.size.width, 20)];
    [_title layoutParentHorizontalCenter];
    
    
    [_textField sizeWith:CGSizeMake(bounds.size.width, bounds.size.height - 20 - 2*kDefaultMargin)];
    [_textField layoutBelow:_title margin:kDefaultMargin];
    [_textField layoutParentHorizontalCenter];
}


@end


@implementation CalculateViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapBlank:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [_scrollView addGestureRecognizer:tap];
}

- (void)onTapBlank:(UITapGestureRecognizer *)tap
{
    if (tap.state == UIGestureRecognizerStateEnded)
    {
        [_ageArea.textField resignFirstResponder];
        [_heightArea.textField resignFirstResponder];
        [_weightArea.textField resignFirstResponder];
    }
}
- (void)addOwnViews
{
    _scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:_scrollView];
    
    _gender = [[GenderArea alloc] init];
    [_scrollView addSubview:_gender];
    
    _ageArea = [[TextFieldArea alloc] initWith:kCalculate_Age_Str];
    [_scrollView addSubview:_ageArea];
    
    _heightArea = [[TextFieldArea alloc] initWith:kCalculate_Height_Str];
    [_scrollView addSubview:_heightArea];
    
    _weightArea = [[TextFieldArea alloc] initWith:kCalculate_Weight_Str];
    [_scrollView addSubview:_weightArea];
    
    
    _typeTip = [[UILabel alloc] init];
    _typeTip.textAlignment = NSTextAlignmentLeft;
    _typeTip.text = kCalculate_WorkType_Str;
    [_scrollView addSubview:_typeTip];
    
    _typeButton = [[ImageTitleButton alloc] init];
    
    
    UIImage *nor = [UIImage imageWithColor:[UIColor flatWhiteColor]];
    UIImage *selc = [UIImage imageWithColor:[UIColor flatOrangeColor]];
    
    [_typeButton setBackgroundImage:nor forState:UIControlStateNormal];
    [_typeButton setBackgroundImage:selc forState:UIControlStateSelected];
    [_typeButton setBackgroundImage:selc forState:UIControlStateHighlighted];
    [_typeButton addTarget:self action:@selector(onChangeType) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_typeButton];
    
    _calculateButton = [[ImageTitleButton alloc] init];
    [_calculateButton setBackgroundImage:nor forState:UIControlStateNormal];
    [_calculateButton setBackgroundImage:selc forState:UIControlStateSelected];
    [_calculateButton setBackgroundImage:selc forState:UIControlStateHighlighted];
    [_scrollView addSubview:_calculateButton];
    
    [_calculateButton addTarget:self action:@selector(onCalculate:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onChangeType
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:kCalculate_WorkType_Str delegate:self cancelButtonTitle:kCancel_Str destructiveButtonTitle:nil otherButtonTitles:kCalculate_WorkType_0_Str, kCalculate_WorkType_1_Str, kCalculate_WorkType_2_Str, kCalculate_WorkType_3_Str, kCalculate_WorkType_4_Str, kCalculate_WorkType_5_Str, nil];
    [sheet showInView:self.view];
}

- (void)configOwnViews
{
    _workType = [NSMutableArray array];
    [_workType addObject:[[KeyValue alloc] initWithKey:kCalculate_WorkType_0_Str value:[NSNumber numberWithFloat:1]]];
    [_workType addObject:[[KeyValue alloc] initWithKey:kCalculate_WorkType_1_Str value:[NSNumber numberWithFloat:1.2]]];
    [_workType addObject:[[KeyValue alloc] initWithKey:kCalculate_WorkType_2_Str value:[NSNumber numberWithFloat:1.375]]];
    [_workType addObject:[[KeyValue alloc] initWithKey:kCalculate_WorkType_3_Str value:[NSNumber numberWithFloat:1.55]]];
    [_workType addObject:[[KeyValue alloc] initWithKey:kCalculate_WorkType_4_Str value:[NSNumber numberWithFloat:1.725]]];
    [_workType addObject:[[KeyValue alloc] initWithKey:kCalculate_WorkType_5_Str value:[NSNumber numberWithFloat:1.9]]];
    
    _selectedWorkType = _workType[0];
    
    [_typeButton setTitle:_selectedWorkType.key forState:UIControlStateNormal];
    [_calculateButton setTitle:kCalculate_Calculate_Str forState:UIControlStateNormal];
    
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex >= 0 && buttonIndex < _workType.count)
    {
        _selectedWorkType = _workType[buttonIndex];
        [_typeButton setTitle:_selectedWorkType.key forState:UIControlStateNormal];
    }
}

- (void)layoutOnIPhone
{
    _scrollView.frame = self.view.bounds;
    
    CGRect rect = _scrollView.bounds;
    [_gender sizeWith:CGSizeMake(rect.size.width, 70)];
    [_gender relayoutFrameOfSubViews];
    
    [_ageArea sameWith:_gender];
    [_ageArea layoutBelow:_gender];
    [_ageArea relayoutFrameOfSubViews];
    
    [_heightArea sameWith:_ageArea];
    [_heightArea layoutBelow:_ageArea];
    [_heightArea relayoutFrameOfSubViews];
    
    [_weightArea sameWith:_heightArea];
    [_weightArea layoutBelow:_heightArea];
    [_weightArea relayoutFrameOfSubViews];
    
    
    [_typeTip sizeWith:CGSizeMake(rect.size.width - 2*kDefaultMargin, 20)];
    [_typeTip layoutParentHorizontalCenter];
    [_typeTip layoutBelow:_weightArea margin:kDefaultMargin];
    
    [_typeButton sizeWith:CGSizeMake(rect.size.width - 2*kDefaultMargin, 44)];
    [_typeButton layoutBelow:_typeTip margin:kDefaultMargin];
    [_typeButton layoutParentHorizontalCenter];
    
    [_calculateButton sameWith:_typeButton];
    [_calculateButton layoutBelow:_typeButton margin:kDefaultMargin];
    
    _scrollView.contentSize = CGSizeMake(0, rect.size.height + 130);
    
}

- (void)onCalculate:(UIButton *)btn
{
    BOOL isMale = [_gender isMale];
    
    CGFloat age = 0;
    CGFloat height = 0;
    CGFloat weight = 0;
    
    if (![_ageArea isVailade])
    {
        [[HUDHelper sharedInstance] tipMessage:kCalculate_NotFill_Str];
        return;
    }
    
    age = [_ageArea areaValue];
    
    if (![_heightArea isVailade])
    {
        [[HUDHelper sharedInstance] tipMessage:kCalculate_NotFill_Str];
        return;
    }
    
    height = [_heightArea areaValue];
    
    if (![_weightArea isVailade])
    {
        [[HUDHelper sharedInstance] tipMessage:kCalculate_NotFill_Str];
        return;
    }
    
    weight = [_weightArea areaValue];
    
    CGFloat type = [((NSNumber *)_selectedWorkType.value) floatValue];
    
    
    CalculateResultViewController *cv = [[CalculateResultViewController alloc] init];
    cv.isMale = isMale;
    cv.age = age;
    cv.height = height;
    cv.weight = weight;
    cv.type = type;
    cv.title = self.title;
    [[AppDelegate sharedAppDelegate] pushViewController:cv];
    
}


@end
