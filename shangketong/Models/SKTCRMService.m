//
//  SKTCRMService.m
//  shangketong
//
//  Created by 钟必胜 on 16/3/27.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTCRMService.h"

@implementation SKTCRMService

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
    return @"crm";
}
@end
