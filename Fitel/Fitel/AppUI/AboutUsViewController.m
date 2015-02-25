//
//  AboutUsViewController.m
//  Fitel
//
//  Created by James on 2/25/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "AboutUsViewController.h"

@implementation AboutUsViewController


- (void)addOwnViews
{
    _aboutUs = [[UITextView alloc] init];
    _aboutUs.text = @"      哈囉各位休粉大家好，歡迎來到這個健康瘦身的園地，一休開這個社團是提供大家可以互相交流分享減重經驗，也可以一起鼓勵督促進步，你可以設你的目標或者跟我們分享你的心得，這裡不建議私下開設line群組，失去大家一起的目標，所以看到此種類型文章一律刪文。\n      也嚴禁販售任何產品，甚至只要有看到購買連結或私下金錢交易等訊息也都會刪文，一休不鼓勵也不建議各位有任何金錢交易的行為，以避免有可能引發的金錢詐騙等相關行為。\n      最後請新進來的休粉都可以自我介紹，你可以簡單分享自己的減重心得，或者告訴我們你的減重目標，或者你減重中的欵問，讓大家在回答問題之前或互相交流時能夠更認識彼此喔～\n      80%的問題應該在我寫的部落格都可以找到答案 http://leeyihugh.pixnet.net/blog 這裡也有粉絲團新手減肥懶人包 http://goo.gl/POIhgL \n      另外問問題之前也請讓大家知道你的身高，體重，飲食跟運動習慣，才更能夠知道可以給你什麼建議喔～ ";
    _aboutUs.font = [UIFont systemFontOfSize:16];
    _aboutUs.editable = NO;
    _aboutUs.dataDetectorTypes = UIDataDetectorTypeLink;
    [self.view addSubview:_aboutUs];

}

- (void)layoutOnIPhone
{
    CGRect rect = self.view.bounds;
    _aboutUs.frame = CGRectInset(rect, kDefaultMargin, kDefaultMargin);
}
@end
