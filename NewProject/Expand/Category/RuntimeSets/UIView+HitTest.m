//
//  UIView+HitTest.m
//  NewProject
//
//  Created by 福中 on 17/1/11.
//  Copyright © 2017年 FZ. All rights reserved.
//

#import "UIView+HitTest.h"
#import <objc/runtime.h>

@implementation UIView (HitTest)

- (UIEdgeInsets)hitTestEdgeInsets {
    NSValue *hitTestEdge = objc_getAssociatedObject(self, @selector(hitTestEdgeInsets));
    return hitTestEdge.UIEdgeInsetsValue;
}

- (void)setHitTestEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets {
    objc_setAssociatedObject(self, @selector(hitTestEdgeInsets), [NSValue valueWithUIEdgeInsets:hitTestEdgeInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isOverStepTouch{
    
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

-(void)setIsOverStepTouch:(BOOL)isOverStepTouch{
    
    objc_setAssociatedObject(self, NSSelectorFromString(@"isOverStepTouch"), @(isOverStepTouch), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event {
    
    return CGRectContainsPoint(HitTestingBounds(self.bounds, self.hitTestEdgeInsets), point);
}

CGRect HitTestingBounds(CGRect bounds,UIEdgeInsets edgeInsets) {
    
    CGRect hitTestBounds = bounds;
    
    hitTestBounds.origin.x -= edgeInsets.left;
    
    hitTestBounds.size.width = edgeInsets.left + bounds.size.width + edgeInsets.right;
    
    hitTestBounds.origin.y -= edgeInsets.top;
    
    hitTestBounds.size.height = edgeInsets.top + bounds.size.height + edgeInsets.bottom;
    
    return hitTestBounds;
}

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selA = @selector(hitTest:withEvent:);
        SEL selB = @selector(myHitTest:withEvent:);
        Method methodA =   class_getInstanceMethod(self,selA);
        Method methodB = class_getInstanceMethod(self, selB);
        //将 methodB的实现 添加到系统方法中 也就是说 将 methodA方法指针添加成 方法methodB的  返回值表示是否添加成功
        BOOL isAdd = class_addMethod(self, selA, method_getImplementation(methodB), method_getTypeEncoding(methodB));
        //添加成功了 说明 本类中不存在methodB 所以此时必须将方法b的实现指针换成方法A的，否则 b方法将没有实现。
        if (isAdd) {
            class_replaceMethod(self, selB, method_getImplementation(methodA), method_getTypeEncoding(methodA));
        }else{
            //添加失败了 说明本类中 有methodB的实现，此时只需要将 methodA和methodB的IMP互换一下即可。
            method_exchangeImplementations(methodA, methodB);
        }
    });
}


- (UIView *)myHitTest:(CGPoint)point withEvent:(UIEvent *)event {

    if (self.isOverStepTouch) {
        if (!self.isUserInteractionEnabled || self.isHidden || self.alpha == 0) {
            return nil;
        }
        
        for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
            CGPoint convertedPoint = [subview convertPoint:point fromView:self];
            UIView *hitTestView = [subview hitTest:convertedPoint withEvent:event];
            if (hitTestView) {
                return hitTestView;
            }
        }
        return [self myHitTest:point withEvent:event];
    
    } else {
        return [self myHitTest:point withEvent:event];
    }
}

@end
