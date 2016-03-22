//
//  SKTURLResponse.h
//  shangketong
//
//  Created by sungoin-zbs on 16/3/7.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKTNetworkingConfiguration.h"

@interface SKTURLResponse : NSObject

@property (assign, readonly, nonatomic) SKTURLResponseStatus status;
@property (copy, readonly, nonatomic) NSString *contentString;
@property (copy, readonly, nonatomic) id content;
@property (assign, readonly, nonatomic) NSInteger requestId;
@property (copy, readonly, nonatomic) NSURLRequest *request;
@property (copy, readonly, nonatomic) NSData *responseData;
@property (copy, nonatomic) NSDictionary *requestParams;
@property (assign, readonly, nonatomic) BOOL isCache;

- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData status:(SKTURLResponseStatus)status;
- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData error:(NSError *)error;

// 使用initWithData的response，它的isCache是YES，上面两个函数生成的response的isCache是NO
- (instancetype)initWithData:(NSData *)data;
@end
