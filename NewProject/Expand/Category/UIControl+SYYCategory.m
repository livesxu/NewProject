//
//  UIControl+syyExtsion.m
//  XiaoLiuRetail
//
//  Created by 束永永 on 16/4/12.
//  Copyright © 2016年 福中. All rights reserved.
//

#import "UIControl+SYYCategory.h"
#import <objc/runtime.h>

#define syy_staticString(__string)               static const char * __string = #__string;

@interface UIControl()

@property (nonatomic, assign) NSTimeInterval syy_timeEvent;

@end

@implementation UIControl (SYYCategory)

+ (void)load
{
    @synchronized (self)
    {
        Method sysMethod = class_getInstanceMethod([self class], @selector(sendAction:to:forEvent:));
        Method myMethod = class_getInstanceMethod([self class], @selector(syy_sendAction:to:forEvent:));
        method_exchangeImplementations(sysMethod, myMethod);
    }
}

syy_staticString(UIControl_timeInterval);
- (NSTimeInterval)syy_timeInterval
{
    return [objc_getAssociatedObject(self, UIControl_timeInterval) doubleValue];
}

- (void)setSyy_timeInterval:(NSTimeInterval)syy_timeInterval
{
    objc_setAssociatedObject(self, UIControl_timeInterval, @(syy_timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

syy_staticString(UIControl_timeEvent);
- (NSTimeInterval)syy_timeEvent
{
    return [objc_getAssociatedObject(self, UIControl_timeEvent) doubleValue];
}

- (void)setSyy_timeEvent:(NSTimeInterval)syy_timeEvent
{
    objc_setAssociatedObject(self, UIControl_timeEvent, @(syy_timeEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)syy_sendAction:(SEL)action to:(id)target forEvent:(nonnull UIEvent*)event
{    
    if ((NSDate.date.timeIntervalSince1970 - self.syy_timeEvent) < self.syy_timeInterval) return;
    
    if (self.syy_timeInterval > 0) {
        
        self.syy_timeEvent = NSDate.date.timeIntervalSince1970;
    }
    
    [self syy_sendAction:action to:target forEvent:event];
}


@end
