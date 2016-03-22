//
//  SKTService.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/14.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTService.h"

@implementation SKTService

- (instancetype)init {
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(SKTServiceProtocol)]) {
            self.child = (id<SKTServiceProtocol>)self;
        }
    }
    return self;
}

#pragma mark - setters and getters
- (NSString *)apiBaseUrl {
    return self.child.protocolApiBaseUrl;
}

- (NSString *)apiPort {
    return self.child.protocolApiPort;
}

- (NSString *)apiProjectName {
    return self.child.protocolApiProjectName;
}

- (NSString *)apiVersion {
    return self.child.protocolApiVersion;
}
@end
