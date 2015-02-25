//
//  UIImage+Common.m
//  CommonLibrary
//
//  Created by 陈耀武 on 13-11-6.
//  Copyright (c) 2013年 ywchen. All rights reserved.
//

#import "UIImage+Common.h"



UIImage *UIImageNamed(NSString *name)
{
    if (isIPad())
    {
        NSString *imgname = PNGNameFroPad(name);
        UIImage *img = [UIImage imageNamed:imgname];
        
        if (img) {
            return img;
        }
        UIImage *phimg = [UIImage imageNamed:PNGName(name)];
        return phimg;
    }
    else
    {
        return [UIImage imageNamed:PNGName(name)];
    }
}

UIImage *UIJPGImageNamed(NSString *name)
{
    if (isIPad())
    {
        UIImage *img = [UIImage imageNamed:JPGNameFroPad(name)];
        return img ? img : [UIImage imageNamed:JPGName(name)];
    }
    else
    {
        return [UIImage imageNamed:JPGName(name)];
    }
}


@implementation UIImage (Common)


- (UIImage *)rescaleImageToSize:(CGSize)size
{
	CGRect rect = CGRectMake(0.0, 0.0, size.width, size.height);
	UIGraphicsBeginImageContext(rect.size);
	[self drawInRect:rect];  // scales image to rect
	UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return resImage;
}

- (UIImage *)cropImageToRect:(CGRect)cropRect
{
	// Begin the drawing (again)
	UIGraphicsBeginImageContext(cropRect.size);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	// Tanslate and scale upside-down to compensate for Quartz's inverted coordinate system
	CGContextTranslateCTM(ctx, 0.0, cropRect.size.height);
	CGContextScaleCTM(ctx, 1.0, -1.0);
	
	// Draw view into context
	CGRect drawRect = CGRectMake(-cropRect.origin.x, cropRect.origin.y - (self.size.height - cropRect.size.height) , self.size.width, self.size.height);
	CGContextDrawImage(ctx, drawRect, self.CGImage);
	
	// Create the new UIImage from the context
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	
	// End the drawing
	UIGraphicsEndImageContext();
	
	return newImage;
}

- (CGSize)calculateNewSizeForCroppingBox:(CGSize)croppingBox
{
	// Make the shortest side be equivalent to the cropping box.
	CGFloat newHeight, newWidth;
	if (self.size.width < self.size.height) {
		newWidth = croppingBox.width;
		newHeight = (self.size.height / self.size.width) * croppingBox.width;
	} else {
		newHeight = croppingBox.height;
		newWidth = (self.size.width / self.size.height) *croppingBox.height;
	}
	
	return CGSizeMake(newWidth, newHeight);
}

- (UIImage *)cropCenterAndScaleImageToSize:(CGSize)cropSize
{
	UIImage *scaledImage = [self rescaleImageToSize:[self calculateNewSizeForCroppingBox:cropSize]];
	return [scaledImage cropImageToRect:CGRectMake((scaledImage.size.width-cropSize.width)/2, (scaledImage.size.height-cropSize.height)/2, cropSize.width, cropSize.height)];
}

- (UIImage *)cropToSquareImage
{
	CGSize theimageSize = self.size;
    if (theimageSize.width != theimageSize.height)
    {
        CGFloat theimageHeight = theimageSize.width > theimageSize.height ? theimageSize.height : theimageSize.width;
        return [self cropCenterAndScaleImageToSize:CGSizeMake(theimageHeight, theimageHeight)];
    }
    else
    {
        return self;
    }
}

- (void)saveToCacheWithKey:(NSString *)key
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *tmpPath = [PathUtility imageCachePath];
        NSString *imagePath = [NSString stringWithFormat:@"%@/%@", tmpPath, [key md5]];
        
        NSData *data = nil;
        if (UIImagePNGRepresentation(self) == nil)
        {
            data = UIImageJPEGRepresentation(self, 1);
        }
        else
        {
            data = UIImagePNGRepresentation(self);
        }
        [data writeToFile:imagePath atomically:YES];
    });
}

+ (UIImage *)loadFromCacheWithKey:(NSString *)key
{
    NSString *tmpPath = [PathUtility imageCachePath];
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@", tmpPath, [key md5]];
    return [UIImage imageWithContentsOfFile:imagePath];
}

//#define kImageIPadPost @"-iPad"
//
//+ (UIImage *)imageNamedForIPAD:(NSString *)name
//{
//    // 后缀名中即有-iPad后缀
//    if ([name rangeOfString:kImageIPadPost options:NSCaseInsensitiveSearch].location != NSNotFound)
//    {
//        DebugLog(@"所取图片name对应的地址：%@", name);
//        return[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:nil]];
//    }
//    
//   
//	NSRange range = [name rangeOfString:@"." options:NSBackwardsSearch];
//	if (range.location == NSNotFound)
//    {
//        NSString *newName = [name stringByAppendingString:kImageIPadPost];
//        NSString *path = [[NSBundle mainBundle] pathForResource:newName ofType:nil];
//        DebugLog(@"所取图片name对应的地址：%@", newName);
//		return [UIImage imageWithContentsOfFile:path];
//	}
//    
//	NSString *filepath = [NSString stringWithFormat:@"%@%@%@",[name substringToIndex:range.location],
//						 kImageIPadPost, [name substringFromIndex:range.location]];
//    
//    
//    UIImage *padImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:filepath ofType:nil]];
//    
//    if (padImage) {
//        DebugLog(@"所取图片name对应的地址：%@", filepath);
//        return padImage;
//    }
//    else
//    {
//        DebugLog(@"所取图片name对应的地址：%@", name);
//        return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:nil]];
//    }
//}


+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [UIImage imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    if (color == nil) {
        return nil;
    }
    
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)randomColorImageWith:(CGSize)size
{
    UIColor *randomColor = [UIColor randomFlatColor];
    return [UIImage imageWithColor:randomColor size:size];
}


@end
