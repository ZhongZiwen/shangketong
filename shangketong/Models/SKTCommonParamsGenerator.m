//
//  SKTCommonParamsGenerator.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/7.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTCommonParamsGenerator.h"
#import "SKTAppContext.h"

@implementation SKTCommonParamsGenerator

+ (NSDictionary *)commonParams {
    SKTAppContext *context = [SKTAppContext sharedInstance];
    return @{@"appvs" : context.version,
             @"phonemodel" : context.systemVersion,
             @"sdkvs" : context.deviceModel,
             @"systemType" : @"iOS"};
}
@end
