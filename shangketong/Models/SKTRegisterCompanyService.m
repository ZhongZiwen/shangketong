//
//  SKTRegisterCompanyService.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/24.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTRegisterCompanyService.h"

@implementation SKTRegisterCompanyService

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
