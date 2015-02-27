//
//  CalculateResultViewController.m
//  Fitel
//
//  Created by James on 2/25/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "CalculateResultViewController.h"


@implementation CalculateResultCell

- (instancetype)initWith:(NSString *)result
{
    if (self = [super init])
    {
        _result.text = result;
        self.backgroundColor = [UIColor flatWhiteColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.layer.shadowColor = kLightGrayColor.CGColor;
        self.layer.shadowOffset = CGSizeMake(2, 2);
    }
    return self;
}

- (void) addOwnViews
{
    _result = [[UILabel alloc] init];
    _result.numberOfLines = 0;
    _result.lineBreakMode = NSLineBreakByWordWrapping;
    _result.font = [UIFont systemFontOfSize:14];
    _result.textAlignment = NSTextAlignmentCenter;
//    _result.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_result];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self relayoutFrameOfSubViews];
}

- (void)relayoutFrameOfSubViews
{
    _result.frame = self.bounds;
}

@end

@implementation CalculateResultViewController

- (void)addOwnViews
{
    _resultTitle = [[UILabel alloc] init];
    _resultTitle.numberOfLines = 0;
    _resultTitle.lineBreakMode = NSLineBreakByWordWrapping;
    _resultTitle.font = [UIFont systemFontOfSize:18];
    _resultTitle.textAlignment = NSTextAlignmentCenter;
    _resultTitle.text = kCalculateResult_ResultTitle_Str;
    [self.view addSubview:_resultTitle];
    
    
    _scrollview = [[UIScrollView alloc] init];
    [self.view addSubview:_scrollview];
    
    UIImage *nor = [UIImage imageWithColor:[UIColor flatWhiteColor]];
    UIImage *selc = [UIImage imageWithColor:[UIColor flatOrangeColor]];
    
    _closeButton = [[UIButton alloc] init];
    [_closeButton setTitle:kCalculateResult_CloseTitle_Str forState:UIControlStateNormal];
    [_closeButton setBackgroundImage:nor forState:UIControlStateNormal];
    [_closeButton setBackgroundImage:selc forState:UIControlStateSelected];
    [_closeButton setBackgroundImage:selc forState:UIControlStateHighlighted];
    [_closeButton addTarget:self action:@selector(onClose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_closeButton];
    
}


- (void)configOwnViews
{
    [self updateInfos];
}

- (void)updateInfos
{
    // Age
    CalculateResultCell *age = [[CalculateResultCell alloc] initWith:[NSString stringWithFormat:kCalculateResult_Age_Format_Str, (int)self.age]];
    [_scrollview addSubview:age];
    
    // Height
    CalculateResultCell *height = [[CalculateResultCell alloc] initWith:[NSString stringWithFormat:kCalculateResult_Height_Format_Str, (int)self.height]];
    [_scrollview addSubview:height];
    
    // weight
    CalculateResultCell *weight = [[CalculateResultCell alloc] initWith:[NSString stringWithFormat:kCalculateResult_Weight_Format_Str, (int)self.weight]];
    [_scrollview addSubview:weight];
    
    
//    ageTextView.setText(age);
//    weightTextView.setText(weight);
//    heightTextView.setText(height);
    //		sexTextView.setText(sex==1?"男":"女");
    //		goalTextView.setText(goalweight);
    
//    DecimalFormat decimalFormat=new DecimalFormat(".0");//构造方法的字符格式这里如果小数不足2位,会以0补足.
    
    // BMI = 體重 (kg) / 身高 (m2)
    // BMR
    //男性 : BMR = 66 + ( 13.7 x weight in kilos ) + ( 5 x height in cm ) - ( 6.8 x age in years )
    // 女性 : BMR = 655 + ( 9.6 x weight in kilos ) + ( 1.8 x height in cm ) - ( 4.7 x age in years )
    // 世界衛生組織計算標準體重之方法 :
    //男性： （身高cm－80）×70﹪＝標準體重
    //女性： （身高cm－70）×60﹪＝標準體重
    // Report UI
    //把目標體重, 性別, 基礎代謝率的欄位拿掉
    //增加”最高心跳(MHR)”, MHR=220-年齡
    // 增加 “zone 1 暖身及恢復區”, MHR *(50%-60%)
    // 增加 “zone 2 低強度有氧區”, MHR*(60%-70%)
    // 增加 “zone 3 高強度有氧區”, MHR*(70%-80%)
    // 增加 “zone 4 無氧區”, MHR*(80%-90%)
    // 增加 “zone 5 極限區”, MHR*(90%-100%)
    
    
    // weight
    CalculateResultCell *bmi = [[CalculateResultCell alloc] initWith:[NSString stringWithFormat:kCalculateResult_BMI_Format_Str, self.weight*10000/(self.height*self.height)]];
    [_scrollview addSubview:bmi];
    
//    bmiTextView.setText(decimalFormat.format((self.weight*10000)/(self.height*self.height))+"%");
    
    
    
    
    //rate * bmr
    double male = 66+13.7*self.weight+5*self.height-6.8*self.age;
    double female = 655+9.6*self.weight+1.8*self.height-4.7*self.age;
    
//    Log.e("========bmr======", "====male:"+male+"female"+female);
    
    CalculateResultCell *basicDaiXie = [[CalculateResultCell alloc] initWith:[NSString stringWithFormat:kCalculateResult_BasicDaiXie_Format_Str, self.isMale ? male : female]];
    [_scrollview addSubview:basicDaiXie];
    
    // 基础代谢率
    CalculateResultCell *needDay = [[CalculateResultCell alloc] initWith:[NSString stringWithFormat:kCalculateResult_NeedDay_Format_Str, self.isMale ? self.type * male : self.type * female]];
    [_scrollview addSubview:needDay];


    
//    basicDaiXieTextView.setText(self.isMale?decimalFormat.format(male)+"大卡/日":decimalFormat.format(female)+"大卡/日");
    
    //		costDayTextView.setText(getCost(sex,Integer.valueOf(age),Float.valueOf(weight).floatValue()));
    //		bestWeightTextView.setText(sex==0?decimalFormat.format(((self.height-80)*(0.7))):decimalFormat.format(((self.height-70)*(0.6))));
    int mhr = 220 - self.age;
    
//    hightbeat.setText(mhr+"");
    CalculateResultCell *mhrview = [[CalculateResultCell alloc] initWith:[NSString stringWithFormat:kCalculateResult_MHR_Format_Str, mhr]];
    [_scrollview addSubview:mhrview];
    
    
    CalculateResultCell *zone1 = [[CalculateResultCell alloc] initWith:[NSString stringWithFormat:kCalculateResult_Zone1_Format_Str, (int)(mhr*0.5), (int)(mhr*0.6)]];
    [_scrollview addSubview:zone1];
    
    CalculateResultCell *zone2 = [[CalculateResultCell alloc] initWith:[NSString stringWithFormat:kCalculateResult_Zone2_Format_Str, (int)(mhr*0.6), (int)(mhr*0.7)]];
    [_scrollview addSubview:zone2];
    
    CalculateResultCell *zone3 = [[CalculateResultCell alloc] initWith:[NSString stringWithFormat:kCalculateResult_Zone3_Format_Str, (int)(mhr*0.7), (int)(mhr*0.8)]];
    [_scrollview addSubview:zone3];
    
    CalculateResultCell *zone4 = [[CalculateResultCell alloc] initWith:[NSString stringWithFormat:kCalculateResult_Zone4_Format_Str, (int)(mhr*0.8), (int)(mhr*0.9)]];
    [_scrollview addSubview:zone4];
    
    CalculateResultCell *zone5 = [[CalculateResultCell alloc] initWith:[NSString stringWithFormat:kCalculateResult_Zone5_Format_Str, (int)(mhr*0.9), (int)(mhr*1)]];
    [_scrollview addSubview:zone5];
    
    
//    zone1.setText((int)(mhr*0.5)+"-"+(int)(mhr*0.6));
//    zone2.setText((int)(mhr*0.6)+"-"+(int)(mhr*0.7));
//    zone3.setText((int)(mhr*0.7)+"-"+(int)(mhr*0.8));
//    zone4.setText((int)(mhr*0.8)+"-"+(int)(mhr*0.9));
//    zone5.setText((int)(mhr*0.9)+"-"+(int)(mhr*1));
}

- (void)layoutOnIPhone
{
    CGRect rect = self.view.bounds;
    [_resultTitle sizeWith:CGSizeMake(rect.size.width, 48)];
    
    [_closeButton sizeWith:CGSizeMake(rect.size.width, 48)];
    [_closeButton alignParentBottom];
    
    [_scrollview sameWith:_resultTitle];
    [_scrollview layoutBelow:_resultTitle margin:kDefaultMargin];
    [_scrollview scaleToAboveOf:_closeButton margin:kDefaultMargin];
    
    
    rect = CGRectInset(_scrollview.bounds, kDefaultMargin, kDefaultMargin);
    CGFloat width = (rect.size.width - 2*kDefaultMargin)/3;
    CGSize size = CGSizeMake(width, width * 3 / 4);
    
    [_scrollview gridViews:_scrollview.subviews inColumn:3 size:size margin:CGSizeMake(kDefaultMargin, kDefaultMargin) inRect:rect];
    
    
    UIView *last = _scrollview.subviews.lastObject;
    if (last.frame.origin.y + last.frame.size.height + kDefaultMargin > _scrollview.bounds.size.height)
    {
        _scrollview.contentSize = CGSizeMake(0, last.frame.origin.y + last.frame.size.height + kDefaultMargin);
    }
}

- (void)onClose:(UIButton *)bnt
{
    [[AppDelegate sharedAppDelegate] popViewController];
}

@end
