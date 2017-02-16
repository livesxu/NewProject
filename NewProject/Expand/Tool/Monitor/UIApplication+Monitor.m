//
//  UIApplication+Monitor.m
//  NewProject
//
//  Created by Livespro on 2016/12/20.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import "UIApplication+Monitor.h"
#import <objc/runtime.h>

@implementation UIApplication (Monitor)

+(void)load{
    
    [UIApplication aspect_hookSelector:@selector(sendAction:to:from:forEvent:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info){
        
        NSObject *objLocation = info.arguments[1];
        NSObject *objSender = info.arguments[2];
        
        [[AppActionMonitor shareAppMonitor] footPrint:[NSString stringWithFormat:@"-<ActionMonitor>- (Actor)%@ (Action)%@ (Loaction)%@ -<ActionMonitor>-\n",NSStringFromClass(objSender.class),info.arguments[0],NSStringFromClass(objLocation.class)]];
        
        [[AppActionMonitor shareAppMonitor] activityPrint:[NSString stringWithFormat:@"(Actor)%@ (Action)%@ (Loaction)%@ \n",NSStringFromClass(objSender.class),info.arguments[0],NSStringFromClass(objLocation.class)]];
        
        
    } error:nil];
    
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info){
        
        [[AppActionMonitor shareAppMonitor] footPrint:[NSString stringWithFormat:@"(WillAppearMonitor) %@: ->\n",NSStringFromClass([info.instance class])]];
        
    } error:nil];
    
    
    [UIViewController aspect_hookSelector:@selector(viewWillDisappear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info){
        
        [[AppActionMonitor shareAppMonitor] footPrint:[NSString stringWithFormat:@"(WillDisappearMonitor) %@ <-;\n",NSStringFromClass([info.instance class])]];
        
    } error:nil];
    
    
    [UIViewController aspect_hookSelector:NSSelectorFromString(@"dealloc") withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> info){
        
        [[AppActionMonitor shareAppMonitor] footPrint:[NSString stringWithFormat:@"(DeallocMonitor) %@ <-;\n",NSStringFromClass([info.instance class])]];
        
    } error:nil];

}

@end
