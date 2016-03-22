//
//  SKTPhotoZoomingImageView.h
//  shangketong
//
//  Created by sungoin-zbs on 16/2/24.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKTPhoto;

@interface SKTPhotoZoomingImageView : UIView

- (instancetype)initWithImageSize:(CGSize)size item:(SKTPhoto *)item;
@end
