//
//  SKTRequestGenerator.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/7.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTRequestGenerator.h"
#import <AFNetworking.h>
#import "NSURLRequest+SKTNetworkingMethods.h"
#import "SKTNetworkingConfiguration.h"
#import "SKTService.h"
#import "SKTServiceFactory.h"
#import "SKTCommonParamsGenerator.h"

@interface SKTRequestGenerator ()

@property (strong, nonatomic) AFHTTPRequestSerializer *httpRequestSerializer;
@end

@implementation SKTRequestGenerator

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static SKTRequestGenerator *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SKTRequestGenerator alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public method
- (NSURLRequest *)generatorGetRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName {
    SKTService *service = [[SKTServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[SKTCommonParamsGenerator commonParams]];
    [params addEntriesFromDictionary:requestParams];
    
    NSString *urlString;
    if (service.apiVersion) {
        urlString = [NSString stringWithFormat:@"%@%@/%@/%@/%@", service.apiBaseUrl, service.apiPort, service.apiProjectName, service.apiVersion, methodName];
    }
    else {
        urlString = [NSString stringWithFormat:@"%@%@/%@/%@", service.apiBaseUrl, service.apiPort, service.apiProjectName, methodName];
    }
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:nil error:NULL];
    request.timeoutInterval = kSKTNetworkingTimeoutSeconds;
    request.requestParams = requestParams;
    return request;
}

- (NSURLRequest *)generatorPostRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName {
    SKTService *service = [[SKTServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[SKTCommonParamsGenerator commonParams]];
    if (requestParams) {
        [params addEntriesFromDictionary:requestParams];
    }
    
    NSString *urlString;
    if (service.apiVersion) {
        urlString = [NSString stringWithFormat:@"%@%@/%@/%@/%@", service.apiBaseUrl, service.apiPort, service.apiProjectName, service.apiVersion, methodName];
    }
    else {
        urlString = [NSString stringWithFormat:@"%@%@/%@/%@", service.apiBaseUrl, service.apiPort, service.apiProjectName, methodName];
    }

    NSURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:params error:NULL];
    request.requestParams = requestParams;
    return request;
}

#pragma mark - setters and getters
- (AFHTTPRequestSerializer *)httpRequestSerializer {
    if (!_httpRequestSerializer) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = kSKTNetworkingTimeoutSeconds;
//        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return _httpRequestSerializer;
}
@end
