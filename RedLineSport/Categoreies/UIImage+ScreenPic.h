//
//  UIImage+ScreenPic.h
//  SreenShort
//
//  Created by Marjoice on 7/11/17.
//  Copyright © 2017年 Marjoice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ScreenPic)

+ (UIImage *)imageWithScreenshot;

+ (UIImage *)composeWithHeader:(UIImage *)header
                        footer:(UIImage *)footer;

+ (UIImage *) imageCompressFitSizeScale:(UIImage *)sourceImage
                             targetSize:(CGSize)size;

+ (UIImage *) imageCompressForWidthScale:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

+ (UIImage*)imageCompressWithSimple:(UIImage*)image scale:(float)scale;

@end
