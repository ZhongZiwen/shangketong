//
//  SKTURLResponse.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/7.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTURLResponse.h"
#import "NSURLRequest+SKTNetworkingMethods.h"

@interface SKTURLResponse ()

@property (assign, readwrite, nonatomic) SKTURLResponseStatus status;
@property (copy, readwrite, nonatomic) NSString *contentString;
@property (copy, readwrite, nonatomic) id content;
@property (copy, readwrite, nonatomic) NSURLRequest *request;
@property (assign, readwrite, nonatomic) NSInteger requestId;
@property (copy, readwrite, nonatomic) NSData *responseData;
@property (assign, readwrite, nonatomic) BOOL isCache;
@end

@implementation SKTURLResponse

- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData status:(SKTURLResponseStatus)status {
    self = [super init];
    if (self) {
        self.contentString = responseString;
        self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        self.status = status;
        self.request = request;
        self.requestId = [requestId integerValue];
        self.responseData = responseData;
        self.requestParams = request.requestParams;
        self.isCache = NO;
    }
    return self;
}

- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData error:(NSError *)error {
    self = [super init];
    if (self) {
        self.contentString = nil;
        self.status = [self responseStatusWithError:error];
        self.requestId = [requestId integerValue];
        self.request = request;
        self.responseData = responseData;
        self.requestParams = request.requestParams;
        self.isCache = NO;
        
        if (responseData) {
            self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        }
        else {
            self.content = nil;
        }
    }
    return self;
}

- (instancetype)initWithData:(NSData *)data {
    self = [super init];
    if (self) {
        self.contentString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        self.status = [self responseStatusWithError:nil];
        self.requestId = 0;
        self.request = nil;
        self.responseData = [data copy];
        self.content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
        self.isCache = YES;
    }
    return self;
}

#pragma mark - private method
- (SKTURLResponseStatus)responseStatusWithError:(NSError *)error {
    if (error) {
        SKTURLResponseStatus result = SKTURLResponseStatusErrorNoNetwork;
        
        // 除了超时以外，所有错误都当成是无网络
        if (error.code == NSURLErrorTimedOut) {
            result = SKTURLResponseStatusErrorTimeout;
        }
        return result;
    }
    else {
        return SKTURLResponseStatusSuccess;
    }
}
@end
