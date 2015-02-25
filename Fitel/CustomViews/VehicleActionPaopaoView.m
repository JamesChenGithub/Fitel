//
//  VehicleActionPaopaoView.m
//  iLunch
//
//  Created by James on 14-8-23.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//
#if kSupportMap

#import "VehicleActionPaopaoView.h"

@implementation VehicleActionPaopaoView


//- (UILabel *)createLabel
//{
//    UILabel *lbl = [[[UILabel alloc] init] autorelease];
//    lbl.font = [UIFont boldSystemFontOfSize:18.0];
//    lbl.backgroundColor = [UIColor clearColor];
//    lbl.textColor = [UIColor whiteColor];
//    lbl.textAlignment = NSTextAlignmentCenter;
//    lbl.numberOfLines = 0;
//    lbl.lineBreakMode = NSLineBreakByWordWrapping;
//    return lbl;
//}

//- (void)prepareForReuse
//{
//    [super prepareForReuse];
//}

- (instancetype)initWithAnnotation:(VehicleGPSListItem *)veh;
{
//    UIView *
//    
//    
//    self.vehicle =veh;
//    if (self)
//    {
//        self.backgroundColor = [UIColor clearColor];
//        
//        const CGFloat kCenterOffset = 35;
//        const CGFloat kWidth = 260;
//        const CGFloat kHeight = 100;
//        
//        self.canShowCallout = NO;
//        self.centerOffset = CGPointMake(0, -kCenterOffset);
//        self.frame = CGRectMake(0, 0, kWidth, kHeight);
//        
//        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - Arror_height)];
//        contentView.backgroundColor   = [UIColor clearColor];
//        [self addSubview:contentView];
//        
//        
//        CGRect contentRect = contentView.bounds;
//        contentRect = CGRectInset(contentRect, 10, 0);
//        
//        CGRect nameRect = contentRect;
//        nameRect.size = CGSizeMake(160, 100 - kCenterOffset);
//        _retailerName = [self createLabel];
//        _retailerName.frame = nameRect;
//        [contentView addSubview:_retailerName];
//        
//        //        nameRect.origin.y += nameRect.size.height;
//        //        _retailerConnact = [self createLabel];
//        //        _retailerConnact.frame = nameRect;
//        //        [contentView addSubview:_retailerConnact];
//        //
//        //        nameRect.origin.y += nameRect.size.height;
//        //        _retailerMobile = [self createLabel];
//        //        _retailerMobile.frame = nameRect;
//        //        [contentView addSubview:_retailerMobile];
//        //
//        //        nameRect.origin.y += nameRect.size.height;
//        //        _retailerAddress = [self createLabel];
//        //        _retailerAddress.frame = nameRect;
//        //        [contentView addSubview:_retailerAddress];
//        
//        
//        CGRect rightRect = contentRect;
//        rightRect.origin.x += nameRect.size.width + 10;
//        rightRect.size.width = contentRect.size.width - nameRect.size.width - 10;
//        
//        CGRect goRect = rightRect;
//        goRect.origin.y += 10;
//        goRect.size.height = 30;
//        
//        UIButton *goToBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        goToBtn.frame = goRect;
//        goToBtn.backgroundColor = [UIColor lightGrayColor];
//        goToBtn.layer.cornerRadius = 5;
//        [goToBtn setTitle:@"导航" forState:UIControlStateNormal];
//        [goToBtn addTarget:self action:@selector(navigateToHere) forControlEvents:UIControlEventTouchUpInside];
//        [contentView addSubview:goToBtn];
//        
//        
//        goRect.origin.y += goRect.size.height + 5;
//        UIButton *detailBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        detailBtn.backgroundColor = [UIColor lightGrayColor];
//        detailBtn.layer.cornerRadius = 5;
//        detailBtn.frame = goRect;
//        [detailBtn setTitle:@"更多" forState:UIControlStateNormal];
//        [detailBtn addTarget:self action:@selector(lookDetailInfo) forControlEvents:UIControlEventTouchUpInside];
//        [contentView addSubview:detailBtn];
//        
//        [contentView release];
//    }
    return self;
}

//- (void)navigateToHere
//{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"NavigateToHere" object:self.annotation];
//}
//
//- (void)lookDetailInfo
//{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"LookDetailInfo" object:self.annotation];
//}
//
//- (void)resetRetailItem:(RetailerItem *)item
//{
//    _retailerName.text = item.merName;
//    //    _retailerConnact.text = item.merContact;
//    //    _retailerMobile.text = item.merMobile;
//    //    _retailerAddress.text = item.merAddress;
//}

//-(void)drawInContext:(CGContextRef)context
//{
//    CGContextSetLineWidth(context, 2.0);
//    UIColor *color = [[UIColor blackColor] colorWithAlphaComponent:0.5];
//    CGContextSetFillColorWithColor(context, color.CGColor);
//    
//    [self getDrawPath:context];
//    CGContextFillPath(context);
//}

//- (void)getDrawPath:(CGContextRef)context
//{
//    CGRect rrect = self.bounds;
//	CGFloat radius = 6.0;
//    
//	CGFloat minx = CGRectGetMinX(rrect),
//    midx = CGRectGetMidX(rrect),
//    maxx = CGRectGetMaxX(rrect);
//	CGFloat miny = CGRectGetMinY(rrect),
//    maxy = CGRectGetMaxY(rrect)-Arror_height;
//    CGContextMoveToPoint(context, midx+Arror_height, maxy);
//    CGContextAddLineToPoint(context,midx, maxy+Arror_height);
//    CGContextAddLineToPoint(context,midx-Arror_height, maxy);
//    
//    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
//    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
//    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
//    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
//    CGContextClosePath(context);
//}

//- (void)drawRect:(CGRect)rect
//{
//	[self drawInContext:UIGraphicsGetCurrentContext()];
//    
//    self.layer.shadowColor = [[UIColor blackColor] CGColor];
//    self.layer.shadowOpacity = 1.0;
//    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
//}

@end
#endif
