//
//  NSURLRequest+SKTNetworkingMethods.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/7.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "NSURLRequest+SKTNetworkingMethods.h"
#import <objc/runtime.h>

@implementation NSURLRequest (SKTNetworkingMethods)

static char requestParamsKey;

- (void)setRequestParams:(NSDictionary *)requestParams {
    [self willChangeValueForKey:@"requestParamsKey"];
    objc_setAssociatedObject(self, &requestParamsKey, requestParams, OBJC_ASSOCIATION_COPY);
    [self didChangeValueForKey:@"requestParamsKey"];
}

- (NSDictionary *)requestParams {
    return objc_getAssociatedObject(self, &requestParamsKey);
}
@end
