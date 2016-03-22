//
//  SKTRegister.h
//  shangketong
//
//  Created by sungoin-zbs on 16/3/22.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKTRegister : NSObject

@property (nonatomic, copy) NSString *accountString;
@property (nonatomic, copy) NSString *captchaString;

- (NSDictionary *)params;
@end
