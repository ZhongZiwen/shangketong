//
//  SKTPhoto.h
//  shangketong
//
//  Created by sungoin-zbs on 16/2/24.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKTPhoto : NSObject

@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *minUrl;
@property (strong, nonatomic) UIImageView *srcImageView;  // 来源view
@end
