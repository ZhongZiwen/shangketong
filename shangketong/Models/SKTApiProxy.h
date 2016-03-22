//
//  SKTApiProxy.h
//  shangketong
//
//  Created by sungoin-zbs on 16/3/7.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKTURLResponse.h"

typedef void (^ApiCallBack) (SKTURLResponse *response);

@interface SKTApiProxy : NSObject

+ (instancetype)sharedInstance;

- (NSInteger)callGetWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName success:(ApiCallBack)success fail:(ApiCallBack)fail;
- (NSInteger)callPostWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName success:(ApiCallBack)success fail:(ApiCallBack)fail;

- (void)cancelRequestWithRequestID:(NSNumber *)requestID;
- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList;
@end
