//
//  SKTPhotoZoomingImageView.m
//  shangketong
//
//  Created by sungoin-zbs on 16/2/24.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTPhotoZoomingImageView.h"
#import "SKTPhoto.h"
#import "UIView+Common.h"

@interface SKTPhotoZoomingImageView ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation SKTPhotoZoomingImageView

- (instancetype)initWithImageSize:(CGSize)size item:(SKTPhoto *)item {
    self = [super initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    if (self) {
        [self.imageView setSize:size];
        [self.imageView setCenterX:CGRectGetWidth(self.bounds) / 2];
        [self.imageView setCenterY:CGRectGetHeight(self.bounds) / 2];
        self.imageView.image = item.srcImageView.image;
        [self addSubview:self.imageView];
    }
    return self;
}

#pragma mark - setters and getters
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        
    }
    return _scrollView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
