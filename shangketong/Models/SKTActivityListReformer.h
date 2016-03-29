//
//  SKTActivityListReformer.h
//  shangketong
//
//  Created by sungoin-zbs on 16/3/29.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKTApiBaseManager.h"

@interface SKTActivityListReformer : NSObject<SKTApiManagerCallBackDataReformer>

@property (nonatomic, weak) id<SKTApiManagerCallBackDataReformer> reformer;
@end
