//
//  FoodTableViewCell.m
//  iLunch
//
//  Created by James on 15-1-10.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import "FoodTableViewCell.h"



@implementation FoodTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addOwnViews];
        
        [self configOwnViews];
    }
    return self;
}

- (void)addOwnViews
{
    _foodIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:_foodIcon];
    
    _foodName = [[UILabel alloc] init];
    _foodName.textColor = kMainTextColor;
    _foodName.textAlignment = NSTextAlignmentLeft;
    _foodName.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_foodName];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self relayoutFrameOfSubViews];
}

- (void)relayoutFrameOfSubViews
{
    CGRect bounds = self.contentView.bounds;
    [_foodIcon sizeWith:CGSizeMake(bounds.size.height - 2*kDefaultMargin, bounds.size.height - 2*kDefaultMargin)];
    [_foodIcon alignParentLeftWithMargin:kDefaultMargin];
    [_foodIcon layoutParentVerticalCenter];
    
    [_foodName sameWith:_foodIcon];
    [_foodIcon layoutToRightOf:_foodIcon margin:kDefaultMargin];
    [_foodIcon scaleToParentRightWithMargin:kDefaultMargin];
    
}

@end

@implementation FoodCollectTableViewCell

- (void)addOwnViews
{
    [super addOwnViews];
    
    _tipIcon = [[UIImageView alloc] init];
    _tipIcon.image = kAddressManage_Cell_Tip_Icon;
    [self.contentView addSubview:_tipIcon];
    
}

- (void)configOwnViews
{
    _foodIcon.backgroundColor = kRandomFlatColor;
    _foodName.text = @"沙县小吃";
}

- (void)relayoutFrameOfSubViews
{
    CGRect bounds = self.contentView.bounds;
    [_foodIcon sizeWith:CGSizeMake(bounds.size.height - 2*kDefaultMargin, bounds.size.height - 2*kDefaultMargin)];
    [_foodIcon alignParentLeftWithMargin:kDefaultMargin];
    [_foodIcon layoutParentVerticalCenter];
    
    [_tipIcon sizeWith:_tipIcon.image.size];
    [_tipIcon layoutParentVerticalCenter];
    [_tipIcon alignParentRightWithMargin:kDefaultMargin];
    
    [_foodName sameWith:_foodIcon];
    [_foodName layoutToRightOf:_foodIcon margin:kDefaultMargin];
    [_foodName scaleToLeftOf:_tipIcon margin:kDefaultMargin];
    
}

@end

@implementation FoodCommentTableViewCell

+ (UIFont *)commentFont
{
    return [UIFont systemFontOfSize:13];
}

- (void)addOwnViews
{
    [super addOwnViews];
    
    _comment = [[UILabel alloc] init];
    _comment.textColor = kDetailTextColor;
    _comment.textAlignment = NSTextAlignmentLeft;
    _comment.lineBreakMode = NSLineBreakByWordWrapping;
    _comment.font = [FoodCommentTableViewCell commentFont];
    _comment.numberOfLines = 0;
    [self.contentView addSubview:_comment];
    
}

#define kCommentFoodIconSize CGSizeMake(35, 35)

+ (CGFloat)heightOf:(NSString *)comment
{
    NSInteger shareInfoWidth = kMainScreenWidth - 4*kDefaultMargin - kCommentFoodIconSize.width - kTipIconSize.width;
    
    NSLineBreakMode breakMode = NSLineBreakByWordWrapping;
    UIFont *font = [FoodCommentTableViewCell commentFont];
    
    CGSize contentSize = CGSizeZero;
    
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = breakMode;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    NSDictionary* attributes = @{NSFontAttributeName:font,
                                 NSParagraphStyleAttributeName:paragraphStyle};
    contentSize = [comment boundingRectWithSize:CGSizeMake(shareInfoWidth, HUGE_VAL) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil].size;
    
    
    contentSize = CGSizeMake((int)contentSize.width + 1, (int)contentSize.height + 1);
    
    if (contentSize.height < 20 ) {
        contentSize.height = 20;
    }
    
    NSInteger height = kDefaultMargin + 20 + contentSize.height + kDefaultMargin;
    return height + 1;
}

- (void)configWith:(NSString *)comment
{
    _foodIcon.backgroundColor = kRandomFlatColor;
    _foodName.text = @"跳跳蛙水煮鱼";
    _comment.text = comment;
}

- (void)relayoutFrameOfSubViews
{
    [_foodIcon sizeWith:kCommentFoodIconSize];
    
    [_foodIcon alignParentLeftWithMargin:kDefaultMargin];
    [_foodIcon alignParentTopWithMargin:kDefaultMargin];
    
    [_tipIcon sizeWith:_tipIcon.image.size];
    [_tipIcon layoutParentVerticalCenter];
    [_tipIcon alignParentRightWithMargin:kDefaultMargin];
    
    [_foodName sizeWith:CGSizeMake(_foodIcon.frame.size.width, 20)];
    [_foodName alignTop:_foodIcon];
    [_foodName layoutToRightOf:_foodIcon margin:kDefaultMargin];
    [_foodName scaleToLeftOf:_tipIcon margin:kDefaultMargin];
    
    [_comment sameWith:_foodName];
    [_comment layoutBelow:_foodName];
    [_comment scaleToParentBottomWithMargin:kDefaultMargin];
}

@end


@implementation FoodOrderTableViewCell

- (void)addOwnViews
{
    [super addOwnViews];
    
    _foodPrice = [[UILabel alloc] init];
    _foodPrice.textColor = kDetailTextColor;
    _foodPrice.textAlignment = NSTextAlignmentRight;
    _foodPrice.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_foodPrice];
    
    _foodNumber = [[UILabel alloc] init];
    _foodNumber.textColor = kDetailTextColor;
    _foodNumber.textAlignment = NSTextAlignmentLeft;
    _foodNumber.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_foodNumber];
    
}

- (void)configOwnViews
{
    _foodIcon.backgroundColor = kRandomFlatColor;
    _foodName.text = @"越南牛肉汤粉";
    _foodPrice.text = @"￥10";
    
    _foodNumber.text = @"2份";
}

#define kFoodIconSize CGSizeMake(30, 30)

- (void)relayoutFrameOfSubViews
{
    CGRect bounds = self.contentView.bounds;
    CGSize iconSize = CGSizeMake(bounds.size.height - 2*kDefaultMargin, bounds.size.height - 2*kDefaultMargin);
    [_foodIcon sizeWith:iconSize];
    [_foodIcon alignParentLeftWithMargin:kDefaultMargin];
    [_foodIcon layoutParentVerticalCenter];
    
    CGSize size = [_foodPrice textSizeIn:bounds.size];
    [_foodPrice sizeWith:CGSizeMake(size.width, iconSize.height/2)];
    [_foodPrice alignTop:_foodIcon];
    [_foodPrice alignParentRightWithMargin:kDefaultMargin];

    
    [_foodName sameWith:_foodPrice];
    [_foodName layoutToLeftOf:_foodPrice margin:kDefaultMargin];
    [_foodName scaleToRightOf:_foodIcon margin:-kDefaultMargin];
    
    [_foodNumber sameWith:_foodName];
    [_foodNumber layoutBelow:_foodName];
    [_foodNumber scaleToParentRightWithMargin:kDefaultMargin];
    
}

@end

@implementation FoodShoppingCartTableViewCell

- (void)addOwnViews
{
    [super addOwnViews];
    
    _addDecView = [[AddDecView alloc] init];
    [self.contentView addSubview:_addDecView];
    
}

- (void)configOwnViews
{
    _foodIcon.backgroundColor = kRandomFlatColor;
    _foodName.text = @"越南牛肉汤粉";
    
    _addDecView.numberValue = 1;
}

- (void)relayoutFrameOfSubViews
{
    CGRect bounds = self.contentView.bounds;
    [_foodIcon sizeWith:CGSizeMake(bounds.size.height - 2*10, bounds.size.height - 2*10)];
    [_foodIcon alignParentLeftWithMargin:kDefaultMargin];
    [_foodIcon layoutParentVerticalCenter];
    
    [_addDecView layoutParentVerticalCenter];
    [_addDecView alignParentRightWithMargin:kDefaultMargin];
    [_addDecView relayoutFrameOfSubViews];
    
    [_foodName sameWith:_foodIcon];
    [_foodName layoutToRightOf:_foodIcon margin:kDefaultMargin];
    [_foodName scaleToLeftOf:_addDecView margin:kDefaultMargin];
    
}

@end

@implementation FoodDetailTableViewCell

- (void)addOwnViews
{
    _contentPanel = [[UIView alloc] init];
    _contentPanel.backgroundColor = RGB(240, 240, 240);
    [self.contentView addSubview:_contentPanel];
    
    _foodIcon = [[UIImageView alloc] init];
    [_contentPanel addSubview:_foodIcon];
    
    _foodName = [[UILabel alloc] init];
    _foodName.textColor = kMainTextColor;
    _foodName.font = [UIFont systemFontOfSize:14];
    _foodName.textAlignment = NSTextAlignmentLeft;
    [_contentPanel addSubview:_foodName];
    
    
    _addButton = [[UIButton alloc] init];
    [_addButton setImage:[UIImage imageNamed:@"btn_add"] forState:UIControlStateNormal];
    [_addButton addTarget:self action:@selector(onAddOrder) forControlEvents:UIControlEventTouchUpInside];
    [_contentPanel addSubview:_addButton];
    
    _addDecView = [[AddDecView alloc] init];
    [_contentPanel addSubview:_addDecView];
    _addDecView.hidden = YES;
    
    _soldNumber = [[UILabel alloc] init];
    _soldNumber.textColor = kDetailTextColor;
    _soldNumber.textAlignment = NSTextAlignmentLeft;
    _soldNumber.font = [UIFont systemFontOfSize:12];
    [_contentPanel addSubview:_soldNumber];
    
    _foodPrice = [[UILabel alloc] init];
    _foodPrice.textColor = kDetailTextColor;
    _foodPrice.textAlignment = NSTextAlignmentLeft;
    _foodPrice.font = [UIFont systemFontOfSize:12];
    [_contentPanel addSubview:_foodPrice];
    
    UIImage *commentIcon = [UIImage imageNamed:@"icon_comment"];
    _comment = [[ImageTitleButton alloc] initWithStyle:EImageLeftTitleRightLeft];
    _comment.margin = UIEdgeInsetsZero;
    _comment.padding = CGSizeMake(0, 0);
    [_comment setImage:commentIcon forState:UIControlStateNormal];
    _comment.imageSize = commentIcon.size;
    _comment.titleLabel.textAlignment = NSTextAlignmentLeft;
    _comment.titleLabel.font = [UIFont systemFontOfSize:10];
    [_comment setTitleColor:kDetailTextColor forState:UIControlStateNormal];
    [_comment addTarget:self action:@selector(onComment:) forControlEvents:UIControlEventTouchUpInside];
    [_contentPanel addSubview:_comment];
    
    UIImage *praiseIcon = [UIImage imageNamed:@"icon_good00"];
    _praise = [[ImageTitleButton alloc] initWithStyle:EImageLeftTitleRightLeft];
    _praise.margin = UIEdgeInsetsZero;
    _praise.padding = CGSizeMake(0, 0);
    [_praise setImage:praiseIcon forState:UIControlStateNormal];
    _praise.titleLabel.textAlignment = NSTextAlignmentLeft;
    _praise.imageSize = praiseIcon.size;
    [_praise setTitleColor:kDetailTextColor forState:UIControlStateNormal];
    _praise.titleLabel.font = [UIFont systemFontOfSize:10];
    [_praise addTarget:self action:@selector(onPraised:) forControlEvents:UIControlEventTouchUpInside];
    [_contentPanel addSubview:_praise];
    
    
    _likeByCurrentUser = [[UIButton alloc] init];
    [_likeByCurrentUser setImage:[UIImage imageNamed:@"icon_heart01_s"] forState:UIControlStateNormal];
    [_likeByCurrentUser setImage:[UIImage imageNamed:@"menu_icon_heart"] forState:UIControlStateSelected];
    [_likeByCurrentUser addTarget:self action:@selector(onLikeByCurrentUser:) forControlEvents:UIControlEventTouchUpInside];
    [_contentPanel addSubview:_likeByCurrentUser];
    
}

- (void)configOwnViews
{
    _foodIcon.backgroundColor = kRandomFlatColor;
    _foodName.text = @"沙县小吃";
    _soldNumber.text = @"已售30份";
//    _foodPrice.text = @"15¥/份";
    
    NSString *price = @"￥15";
    NSString *unit = @"/份";
    
    NSString *info = [NSString stringWithFormat:@"%@%@", price, unit];
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:info];
    
    [attriString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, price.length)];
    [attriString addAttribute:NSForegroundColorAttributeName value:kPriceTextColor range:NSMakeRange(0, price.length)];
    [attriString addAttribute:NSForegroundColorAttributeName value:kMainTextColor range:NSMakeRange(price.length, unit.length)];
    [attriString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(price.length, unit.length)];
    
    _foodPrice.attributedText = attriString;
    
    
    [_comment setTitle:@"12" forState:UIControlStateNormal];
    [_praise setTitle:@"123" forState:UIControlStateNormal];
}

- (void)onComment:(UIButton *)button
{
    DebugLog(@"");
}


- (void)onPraised:(UIButton *)button
{
    DebugLog(@"");
}


- (void)onLikeByCurrentUser:(UIButton *)button
{
    button.selected = !button.selected;
}

- (void)onAddOrder
{
    _addButton.hidden = YES;
    _addDecView.hidden = NO;
}

- (void)relayoutFrameOfSubViews
{
    CGRect bounds = self.contentView.bounds;
    bounds = CGRectInset(bounds, kDefaultMargin, 0);
    bounds.origin.y += kDefaultMargin;
    bounds.size.height -= kDefaultMargin;
    _contentPanel.frame = bounds;
    
//    
//    [_foodIcon sizeWith:CGSizeMake(bounds.size.height - 2*8, bounds.size.height - 2*8)];
//    [_foodIcon alignParentLeftWithMargin:8];
//    [_foodIcon layoutParentVerticalCenter];
    
    bounds = _contentPanel.bounds;
    bounds = CGRectInset(bounds, kDefaultMargin, kDefaultMargin);
    
    CGRect fiRect = bounds;
    fiRect.size.width = fiRect.size.height;
    _foodIcon.frame = fiRect;
    
    bounds.origin.x += fiRect.size.width + kDefaultMargin;
    bounds.size.width -= fiRect.size.width + kDefaultMargin;
    
    
    [_foodName sizeWith:CGSizeMake(bounds.size.width * 3/5, bounds.size.height/3)];
    [_foodName layoutToRightOf:_foodIcon margin:kDefaultMargin];
    [_foodName alignTop:_foodIcon];
    
    [_soldNumber sameWith:_foodName];
    [_soldNumber layoutBelow:_foodName];
    
    [_foodPrice sizeWith:CGSizeMake(bounds.size.width * 2/5, bounds.size.height/3)];
    [_foodPrice alignLeft:_soldNumber];
    [_foodPrice layoutBelow:_soldNumber];
    
    
    CGRect addRect = bounds;
    addRect.origin.x += bounds.size.width * 3/5;
    addRect.size.width -= bounds.size.width * 3/5;
    addRect.size.height = bounds.size.height/2;
    
    UIImage *addIcon = [_addButton imageForState:UIControlStateNormal];
    CGRect arect = CGRectFromCGSize(addIcon.size);
    arect.origin.x = addRect.origin.x + addRect.size.width - arect.size.width;
    arect.origin.y = addRect.origin.y + (addRect.size.height - arect.size.height)/2;
    _addButton.frame = arect;
    
    [_addDecView alignTop:_addButton];
    [_addDecView alignRight:_addButton];
    [_addDecView relayoutFrameOfSubViews];
    
    
    CGRect cplRect = bounds;
    cplRect.origin.x += bounds.size.width * 2/5;
    cplRect.size.width -= bounds.size.width * 2/5;
    cplRect.size.height = bounds.size.height /3;
    cplRect.origin.y += bounds.size.height * 2/3;
    
    
    UIImage *like = [_likeByCurrentUser imageForState:UIControlStateNormal];
    CGRect likerect = cplRect;
    likerect.size.width = like.size.width;
    likerect.origin.x += cplRect.size.width - likerect.size.width;
    _likeByCurrentUser.frame = likerect;
    
    cplRect.size.width -= like.size.width;
    
    [_praise sizeWith:CGSizeMake(cplRect.size.width/2, cplRect.size.height)];
    [_praise alignTop:_likeByCurrentUser];
    [_praise layoutToLeftOf:_likeByCurrentUser];
    
    
    [_comment sameWith:_praise];
    [_comment layoutToLeftOf:_praise];
    
    
    
}

@end
