//
//  SKTServiceFactory.h
//  shangketong
//
//  Created by sungoin-zbs on 16/3/14.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKTService.h"

@interface SKTServiceFactory : NSObject

+ (instancetype)sharedInstance;
- (SKTService<SKTServiceProtocol> *)serviceWithIdentifier:(NSString *)identifier;
@end
