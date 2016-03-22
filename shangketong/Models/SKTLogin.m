//
//  SKTLogin.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/17.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTLogin.h"

@implementation SKTLogin

- (instancetype)init {
    self = [super init];
    if (self) {
        _userName = @"zhongbisheng@sungoin.com";
        _password = @"131400";
    }
    return self;
}

- (NSDictionary *)params {
    return @{@"accountName" : _userName,
             @"password" : _password};
}
@end
