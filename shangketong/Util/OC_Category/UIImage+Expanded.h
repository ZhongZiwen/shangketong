//
//  UIImage+Expanded.h
//  shangketong
//
//  Created by sungoin-zbs on 16/3/15.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface UIImage (Expanded)

+ (UIImage *)imageWithColor:(UIColor *)aColor;
+ (UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame;
- (UIImage *)scaledToSize:(CGSize)targetSize;
- (UIImage *)scaledToSize:(CGSize)targetSize highQuality:(BOOL)highQuality;
- (UIImage *)scaledToMaxSize:(CGSize )size;
+ (UIImage *)fullResolutionImageFromALAsset:(ALAsset *)asset;
+ (UIImage *)fullScreenImageALAsset:(ALAsset *)asset;
@end
