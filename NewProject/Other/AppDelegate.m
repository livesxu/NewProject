//
//  AppDelegate.m
//  NewProject
//
//  Created by Livespro on 16/10/10.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import "AppDelegate.h"
#import "LXUncaughtExceptionHandler.h"
#import "PerformanceMonitor.h"
#import "AppDelegate+Assist.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //加载界面
    [self GuideAndLaunchAction];
    //崩溃检测,涉及到操作跟踪
    LXInstallUncaughtExceptionHandler();
    //卡顿监测
    [[PerformanceMonitor sharedInstance] start];
    //不可多重点击
    [[UIButton appearance] setExclusiveTouch:YES];
    //运行中检测状态
    //Test_run
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
