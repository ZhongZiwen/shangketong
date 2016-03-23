//
//  SKTCheckAccountLoginService.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/23.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTCheckAccountLoginService.h"

@implementation SKTCheckAccountLoginService

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
