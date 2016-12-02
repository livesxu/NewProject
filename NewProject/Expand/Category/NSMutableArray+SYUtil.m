//
//  NSMutableArray+SYUtil.m
//  XiaoLiuRetail
//
//  Created by imac on 16/1/2.
//  Copyright © 2016年 福中. All rights reserved.
//

#import "NSMutableArray+SYUtil.h"
#import <objc/runtime.h>

@implementation NSMutableArray (SYUtil)

+ (void)load
{
    Method sysMethod = class_getInstanceMethod([self class], @selector(addObject:));
    Method myMethod = class_getInstanceMethod([self class], @selector(syy_addObject:));
    method_exchangeImplementations(sysMethod, myMethod);
}

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

- (void)syy_addObject:(id)anObject
{
    @synchronized (self) {
       
        if (self) {
            
            [self addObject:anObject];
        }
    }
}

@end
