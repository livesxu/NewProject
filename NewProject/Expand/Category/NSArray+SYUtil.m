//
//  NSArray+SYUtil.m
//  XiaoLiuRetail
//
//  Created by imac on 16/1/2.
//  Copyright © 2016年 福中. All rights reserved.
//

#import "NSArray+SYUtil.h"

@implementation NSArray (SYUtil)

- (id)objectAtIndexCheck:(NSUInteger)index
{
    if (index >= self.count) {
        return nil;
    }
    
    id value = [self objectAtIndex:index];
    if (value == [NSNull null]) {
        return nil;
    }
    
    return value;
}

@end
