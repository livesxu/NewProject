//
//  NSArray+Safety.m
//  NewProject
//
//  Created by Livespro on 2016/12/8.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import "NSArray+Safety.h"

@implementation NSArray (Safety)

+(void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self swizzleInstanceMethodWithClass:self.class originalSelector:@selector(objectAtIndexedSubscript:) swizzledMethod:@selector(objectAtIndexSafe:)];
        
    });
    
}

+ (void)swizzleInstanceMethodWithClass:(Class)class
                      originalSelector:(SEL)originalSelector
                        swizzledMethod:(SEL)swizzledSelector{
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    // When swizzling a class method, use the following:
    // Class class = object_getClass((id)self);
    // ...
    // Method originalMethod = class_getClassMethod(class, originalSelector);
    // Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

-(id)objectAtIndexSafe:(NSInteger)index{
    
    if (index >= self.count) {
        NSLog(@"[%@ %@] index %lu beyond bounds [0 .. %lu]",
                 NSStringFromClass([self class]),
                 NSStringFromSelector(_cmd),
                 (unsigned long)index,
                 MAX((unsigned long)self.count - 1, 0));
        return nil;
    }
    id value = [self objectAtIndexSafe:index];
    if (value == [NSNull null]) {
        return nil;
    }
    
    return value;
}

@end
