//
//  SKTPhotoBrowser.m
//  shangketong
//
//  Created by sungoin-zbs on 16/2/24.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTPhotoBrowser.h"
#import "UIView+Common.h"
#import "SKTPhoto.h"
#import "SKTPhotoZoomingImageView.h"

@interface SKTPhotoBrowser ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIView *view;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@end

@implementation SKTPhotoBrowser

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static SKTPhotoBrowser *photoBrowser = nil;
    dispatch_once(&onceToken, ^{
        photoBrowser = [[SKTPhotoBrowser alloc] init];
    });
    return photoBrowser;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        [self.view addSubview:self.scrollView];
        [self.view addSubview:self.pageControl];
    }
    return self;
}

- (void)showWithPhotoItems:(NSArray *)items selectedItem:(SKTPhoto *)selectedPhoto {
    if (!items.count) {
        return;
    }
    
    /**
     * show selected view
     */
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self.view];
    
    const CGFloat fullW = window.frame.size.width;
    const CGFloat fullH = window.frame.size.height;
    
    const NSInteger currentPage = selectedPhoto.srcImageView.tag;
    
    // get selectedView frame
    selectedPhoto.srcImageView.frame = [window convertRect:selectedPhoto.srcImageView.frame fromView:selectedPhoto.srcImageView.superview];
    [window addSubview:selectedPhoto.srcImageView];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.alpha = 1;
        self.pageControl.alpha = 1;
        
        window.rootViewController.view.transform = CGAffineTransformMakeScale(0.95, 0.95);
        
        selectedPhoto.srcImageView.transform = CGAffineTransformIdentity;
        
        CGSize size = selectedPhoto.srcImageView.image ? selectedPhoto.srcImageView.image.size : selectedPhoto.srcImageView.frame.size;
        CGFloat ratio = MIN(fullW / size.width, fullH / size.height);
        CGFloat w = ratio * size.width;
        CGFloat h = ratio * size.height;
        selectedPhoto.srcImageView.frame = CGRectMake((fullW - w) / 2.0, (fullH - h) / 2.0, w, h);
        
    } completion:^(BOOL finished) {
        [selectedPhoto.srcImageView removeFromSuperview];
        
        int i = 0;
        for (SKTPhoto *tempPhoto in items) {
            CGSize size = tempPhoto.srcImageView.image ? tempPhoto.srcImageView.image.size : tempPhoto.srcImageView.frame.size;
            CGFloat ratio = MIN(fullW / size.width, fullH / size.height);
            CGFloat w = ratio * size.width;
            CGFloat h = ratio * size.height;
            
            SKTPhotoZoomingImageView *imageView = [[SKTPhotoZoomingImageView alloc] initWithImageSize:CGSizeMake(w, h) item:tempPhoto];
            [imageView setX:i * fullW];
            [self.scrollView addSubview:imageView];
            
            i ++;
        }
        self.scrollView.contentSize = CGSizeMake(items.count * fullW, fullH);
        self.scrollView.contentOffset = CGPointMake(currentPage *fullW, 0);
    }];
}

#pragma mark - setters and getters
- (UIView *)view {
    if (!_view) {
        _view = [[UIView alloc] initWithFrame:kScreen_Bounds];
        _view.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
        pan.maximumNumberOfTouches = 1;
        [_view addGestureRecognizer:pan];
    }
    return _view;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:kScreen_Bounds];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.backgroundColor = [self.view.backgroundColor colorWithAlphaComponent:1];
        _scrollView.alpha = 0;
        _scrollView.delegate = self;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedScrollView:)];
        [_scrollView addGestureRecognizer:tapGesture];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        [_pageControl sizeToFit];
        [_pageControl setCenterX:kScreen_Width / 2.0];
        [_pageControl setY:CGRectGetHeight(self.view.bounds) - 20];
        _pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.7 alpha:0.2];
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithWhite:1.0 alpha:0.8];
        _pageControl.alpha = 0;
    }
    return _pageControl;
}

@end
