//
//  NSString+Expanded.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/23.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "NSString+Expanded.h"

@implementation NSString (Expanded)

- (NSString *)trimWhitespace {
    NSMutableString *str = [self mutableCopy];
    CFStringTrimWhitespace((__bridge CFMutableStringRef)str);
    return str;
}

- (BOOL)isEmpty {
    return [[self trimWhitespace] isEqualToString:@""];
}
@end
