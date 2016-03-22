//
//  SKTCaptchaService.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/22.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTCaptchaService.h"

@implementation SKTCaptchaService

#pragma mark - SKTServiceProtocol
- (NSString *)protocolApiBaseUrl {
    return kApiBaseUrl;
}

- (NSString *)protocolApiPort {
    return kApiPort;
}

- (NSString *)protocolApiProjectName {
    return kApiProjectName;
}

- (NSString *)protocolApiVersion {
    return nil;
}
@end
