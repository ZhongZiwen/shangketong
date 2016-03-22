//
//  SKTPhotoBrowser.h
//  shangketong
//
//  Created by sungoin-zbs on 16/2/24.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SKTPhoto;

@interface SKTPhotoBrowser : NSObject

+ (instancetype)sharedInstance;
- (void)showWithPhotoItems:(NSArray *)items selectedItem:(SKTPhoto *)selectedPhoto;
@end
