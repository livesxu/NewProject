//
//  NSObject+Description.m
//  NewProject
//
//  Created by Livespro on 2016/12/12.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import "NSObject+Description.h"

#pragma mark - NSArray

@interface NSArray (Unicode)

@end

@implementation NSArray (Unicode)

-(NSString *)descriptionUnicode{
    
    NSMutableString *str = [NSMutableString stringWithFormat:@"[\n\t"];
    
    for (id obj in self) {
        [str appendFormat:@"%@,", obj];
    }
    
    [str appendString:@"\n]"];
    
    [str replaceCharactersInRange:NSMakeRange(str.length-3, 1) withString:@""];
    
    return str;
}

@end

#pragma mark - NSMutableArray

@interface NSMutableArray (Unicode)

@end

@implementation NSMutableArray (Unicode)

-(NSString *)descriptionUnicode{
    
    NSMutableString *str = [NSMutableString stringWithFormat:@"[\n\t"];
    
    for (id obj in self) {
        [str appendFormat:@"%@,", obj];
    }
    
    [str appendString:@"\n]"];
    
    [str replaceCharactersInRange:NSMakeRange(str.length-3, 1) withString:@""];
    
    return str;
}

@end

#pragma mark - NSDictionary

@interface NSDictionary (Unicode)

@end

@implementation NSDictionary (Unicode)

-(NSString *)descriptionUnicode{
    
    NSMutableString *str = [NSMutableString stringWithFormat:@"{\n\t"];
    
    for (id obj in self) {
        [str appendFormat:@"%@ = %@, \n", obj,[self objectForKey:obj]];
    }
    
    [str appendString:@"\n}"];
    
    [str replaceCharactersInRange:NSMakeRange(str.length-5, 3) withString:@""];
    
    return str;
}

@end

#pragma mark - NSMutableDictionary

@interface NSMutableDictionary (Unicode)

@end

@implementation NSMutableDictionary (Unicode)

-(NSString *)descriptionUnicode{
    
    NSMutableString *str = [NSMutableString stringWithFormat:@"{\n\t"];
    
    for (id obj in self) {
        [str appendFormat:@"%@ = %@, \n", obj,[self objectForKey:obj]];
    }
    
    [str appendString:@"\n}"];
    
    [str replaceCharactersInRange:NSMakeRange(str.length-5, 3) withString:@""];
    
    return str;
}

@end




@implementation NSObject (Description)

#if DEBUG

+(void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self swizzleInstanceMethodWithClass:NSClassFromString(@"__NSArrayI") originalSelector:@selector(descriptionWithLocale:) swizzledMethod:@selector(descriptionUnicode)];
        [self swizzleInstanceMethodWithClass:NSClassFromString(@"__NSArrayM") originalSelector:@selector(descriptionWithLocale:) swizzledMethod:@selector(descriptionUnicode)];
        [self swizzleInstanceMethodWithClass:[NSDictionary class] originalSelector:@selector(descriptionWithLocale:) swizzledMethod:@selector(descriptionUnicode)];
        [self swizzleInstanceMethodWithClass:NSClassFromString(@"__NSDictionaryM") originalSelector:@selector(descriptionWithLocale:) swizzledMethod:@selector(descriptionUnicode)];
        
    });
    
}

#endif

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

@end
