//
//  SKTLoginService.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/18.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTLoginService.h"

@implementation SKTLoginService

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
