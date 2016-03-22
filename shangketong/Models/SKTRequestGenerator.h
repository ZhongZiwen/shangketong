//
//  SKTRequestGenerator.h
//  shangketong
//
//  Created by sungoin-zbs on 16/3/7.
//  Copyright © 2016年 sungoin. All rights reserved.
//

/**
 * 组装request
 */
#import <Foundation/Foundation.h>

@interface SKTRequestGenerator : NSObject

+ (instancetype)sharedInstance;

- (NSURLRequest *)generatorGetRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName;
- (NSURLRequest *)generatorPostRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName;
@end
