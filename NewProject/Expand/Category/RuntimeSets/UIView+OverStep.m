//
//  UIView+OverStep.m
//  NewProject
//
//  Created by Livespro on 2016/12/9.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import "UIView+OverStep.h"

@implementation UIView (OverStep)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(addSubview:);
        SEL swizzledSelector = @selector(addSubviewPrompt:);
        
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
    });
}

-(void)addSubviewPrompt:(UIView *)view{
    
    CGRect rectSuper = self.frame;
    
    CGRect rectSub = view.frame;
    
    if ((rectSub.origin.x) > rectSuper.size.width || (rectSub.origin.y) > rectSuper.size.height || (rectSub.origin.x + rectSub.size.width) < 0 || (rectSub.origin.y + rectSub.size.height) < 0) {
        
//        NSLog(@"%@\n未显示在父视图上,超出",view);
    }
    
    [self addSubviewPrompt:view];
}

@end
