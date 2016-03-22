//
//  SKTService.h
//  shangketong
//
//  Created by sungoin-zbs on 16/3/14.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKTNetworkingConfiguration.h"

// 所有SKTService的派生类都要符合这个protocol
@protocol SKTServiceProtocol <NSObject>

@property (copy, readonly, nonatomic) NSString *protocolApiBaseUrl;
@property (copy, readonly, nonatomic) NSString *protocolApiPort;
@property (copy, readonly, nonatomic) NSString *protocolApiProjectName;
@property (copy, readonly, nonatomic) NSString *protocolApiVersion;
@end

@interface SKTService : NSObject

/**
 * baseUrl
 */
@property (copy, readonly, nonatomic) NSString *apiBaseUrl;
/**
 * url端口号
 */
@property (copy, readonly, nonatomic) NSString *apiPort;
/**
 * 项目名。如：skt-user、user、im
 */
@property (copy, readonly, nonatomic) NSString *apiProjectName;
/**
 * version分：crm,oa,admin,user
 */
@property (copy, readonly, nonatomic) NSString *apiVersion;

@property (weak, nonatomic) id<SKTServiceProtocol> child;
@end
