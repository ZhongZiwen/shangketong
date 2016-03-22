//
//  SKTLoginReformer.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/21.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTLoginReformer.h"

@implementation SKTLoginReformer

- (instancetype)init {
    self = [super init];
    if (self) {
        self.reformer = self;
    }
    return self;
}

- (id)manager:(SKTApiBaseManager *)manager reformData:(NSDictionary *)data {
    NSLog(@"登录数据重新组装");
    return data;
}
@end
