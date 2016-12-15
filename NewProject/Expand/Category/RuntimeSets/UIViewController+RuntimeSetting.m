//
//  UIViewController+RuntimeSetting.m
//  NewProject
//
//  Created by Livespro on 2016/12/13.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import "UIViewController+RuntimeSetting.h"
#import <objc/runtime.h>

void (*OriginalViewDidAppear)(id, SEL, BOOL);

void newViewDidAppear(UIViewController *self, SEL _cmd, BOOL animated)
{
    // call original implementation
    OriginalViewDidAppear(self, _cmd, animated);
    
    // Logging
//    NSLog(@"runtimeGO-----ViewDidAppear");
}

@implementation UIViewController (RuntimeSetting)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method originalMethod = class_getInstanceMethod(self, @selector(viewDidAppear:));
        
        OriginalViewDidAppear = (void *)method_getImplementation(originalMethod);
        
        if(!class_addMethod(self, @selector(viewDidAppear:), (IMP) newViewDidAppear, method_getTypeEncoding(originalMethod))) {
            method_setImplementation(originalMethod, (IMP) newViewDidAppear);
        }
        
        [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(){
        
//            NSLog(@"ASP -- ViewWillAppear");
        
        } error:nil];
        
    });
    
}

@end
