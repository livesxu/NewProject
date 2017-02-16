//
//  AppDelegate+Assist.m
//  NewProject
//
//  Created by Livespro on 2016/12/21.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import "AppDelegate+Assist.h"

@implementation AppDelegate (Assist)

//设置引导页和广告页
- (void)GuideAndLaunchAction{
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    LXGuideAndLaunch *GL=[[LXGuideAndLaunch alloc]init];
    __weak LXGuideAndLaunch *weakGL=GL;
    [GL storeFirstName:@"isFirst" andMainViewController:[[MainTabBarViewController alloc] init] guide:^{
        
        [weakGL scrollGuideWithPicturesName:kGuideImages
                               progressName:kProgressImages];
        
    } launch:^{
        
        [weakGL viewLaunchAdvertisePatternWithImage:@"ad_page" time:5];
        
    }];
    self.window.rootViewController=GL;//root转变为LXGuideAndLaunch
    
}

@end
