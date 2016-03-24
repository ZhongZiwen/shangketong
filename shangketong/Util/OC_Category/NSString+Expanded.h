//
//  NSString+Expanded.h
//  shangketong
//
//  Created by sungoin-zbs on 16/3/23.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Expanded)

- (BOOL)isEmail;
- (BOOL)isPhoneNumber;
- (NSString *)trimWhitespace;
- (BOOL)isEmpty;
@end
