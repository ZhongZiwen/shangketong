//
//  SKTLoginReformer.h
//  shangketong
//
//  Created by sungoin-zbs on 16/3/21.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKTApiBaseManager.h"

@interface SKTLoginReformer : NSObject<SKTApiManagerCallBackDataReformer>

@property (nonatomic, weak) id<SKTApiManagerCallBackDataReformer> reformer;
@end
