//
//  UIWindow+Test_run.m
//  NewProject
//
//  Created by Livespro on 2016/12/26.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import "UIWindow+Test_run.h"
#import <FLEX/FLEX.h>

@interface UIWindow ()

@property (nonatomic,strong) UILongPressGestureRecognizer *test_PG;

@end

@implementation UIWindow (Test_run)

static char Test_PGKey;

- (void)setTest_PG:(UILongPressGestureRecognizer *)test_PG{
    [self willChangeValueForKey:@"Test_PGKey"];
    objc_setAssociatedObject(self, &Test_PGKey,
                             test_PG,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"Test_PGKey"];
}

- (UILongPressGestureRecognizer *)test_PG{
    return objc_getAssociatedObject(self, &Test_PGKey);
}

+(void)load{
    
    [self aspect_hookSelector:NSSelectorFromString(@"makeKeyAndVisible") withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info){
        
        UIWindow *windowGet = info.instance;
        
        windowGet.test_PG = [[UILongPressGestureRecognizer alloc] init];
        
        [[windowGet.test_PG rac_gestureSignal]subscribeNext:^(id x) {
            
            [[FLEXManager sharedManager] showExplorer];
        }];
        
        windowGet.test_PG.minimumPressDuration = 3; //设置最小长按时间
        [windowGet addGestureRecognizer:windowGet.test_PG];
        
        [FLEXManager sharedManager].networkDebuggingEnabled = YES;
        
    }error:nil];
}

@end
