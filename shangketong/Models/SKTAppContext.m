//
//  SKTAppContext.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/7.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTAppContext.h"
#import <AFNetworkReachabilityManager.h>

@interface SKTAppContext ()

@property (strong, nonatomic) UIDevice *device;
@property (copy, readwrite, nonatomic) NSString *version;
@property (copy, readwrite, nonatomic) NSString *systemVersion;
@property (copy, readwrite, nonatomic) NSString *deviceModel;
@end

@implementation SKTAppContext

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static SKTAppContext *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SKTAppContext alloc] init];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    });
    return sharedInstance;
}

- (UIDevice *)device {
    if (!_device) {
        _device = [UIDevice currentDevice];
    }
    return _device;
}

- (NSString *)version {
    if (!_version) {
        _version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    }
    return _version;
}

- (NSString *)systemVersion {
    if (!_systemVersion) {
        _systemVersion = self.device.systemVersion;
    }
    return _systemVersion;
}

- (NSString *)deviceModel {
    if (!_deviceModel) {
        _deviceModel = self.device.model;
    }
    return _deviceModel;
}

- (BOOL)isReachable {
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
        return YES;
    }
    else {
        return [[AFNetworkReachabilityManager sharedManager] isReachable];
    }
}
@end
