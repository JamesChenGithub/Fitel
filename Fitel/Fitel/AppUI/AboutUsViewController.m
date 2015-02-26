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
    _aboutUs.text = kAboutUs_Content_Str;
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
