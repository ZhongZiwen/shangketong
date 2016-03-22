//
//  SKTLogin.h
//  shangketong
//
//  Created by sungoin-zbs on 16/3/17.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKTLogin : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;

- (NSDictionary *)params;
@end
