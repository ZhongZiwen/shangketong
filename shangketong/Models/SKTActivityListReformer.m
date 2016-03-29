//
//  SKTActivityListReformer.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/29.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTActivityListReformer.h"

@implementation SKTActivityListReformer

- (instancetype)init {
    self = [super init];
    if (self) {
        self.reformer = self;
    }
    return self;
}

#pragma mark - SKTApiManagerCallBackDataReformer
- (id)manager:(SKTApiBaseManager *)manager reformData:(NSDictionary *)data {
    NSArray *marketDirectorys = data[@"marketDirectorys"];
    return marketDirectorys;
}
@end
