//
//  UILabel+UILabel_Common.m
//  TCLSales
//
//  Created by ken liu on 14-1-18.
//  Copyright (c) 2014年 iLunch. All rights reserved.
//

#import "UILabel+Common.h"

@implementation UILabel (Common)

+ (instancetype)label
{
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentLeft;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    return label;
}

+ (instancetype)labelWithTitle:(NSString *)title
{
    UILabel *label = [UILabel label];
    
    label.text = title;
    return label;
}

- (CGSize)contentSize
{
    return [self textSizeIn:self.frame.size];
}

- (CGSize)textSizeIn:(CGSize)size
{
    NSLineBreakMode breakMode = self.lineBreakMode;
    UIFont *font = self.font;
    
    CGSize contentSize = CGSizeZero;
//    if ([IOSDeviceConfig sharedConfig].isIOS7)
//    {
        NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = breakMode;
        paragraphStyle.alignment = self.textAlignment;
        
        NSDictionary* attributes = @{NSFontAttributeName:font,
                                     NSParagraphStyleAttributeName:paragraphStyle};
        contentSize = [self.text boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil].size;
//    }
//    else
//    {
//        contentSize = [self.text sizeWithFont:font constrainedToSize:size lineBreakMode:breakMode];
//    }
    
    
    contentSize = CGSizeMake((int)contentSize.width + 1, (int)contentSize.height + 1);
    return contentSize;
}


@end
