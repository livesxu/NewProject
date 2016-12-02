//
//  LXGuideAndLaunch.h
//  XiaoLiuFisheries
//
//  Created by Livespro on 16/9/9.
//  Copyright © 2016年 福中集团软件公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kGuideImages @[@"Guidefirst",@"Guides",@"Guidet",@"Guidefour",@"Guidefive"]
#define kProgressImages @[@"guidepage_circle_01",@"guidepage_circle_02",@"guidepage_circle_03",@"guidepage_circle_04"]

typedef void(^GuideBlock)();

typedef void(^LaunchBlock)();

@interface LXGuideAndLaunch : UIViewController<UIScrollViewDelegate>

@property(nonatomic,strong)UIView *guideView;//引导页

@property(nonatomic,strong)UIView *launchView;//发起页

@property(nonatomic,strong)NSArray *pictures;//引导页的图片数组

@property(nonatomic,copy)GuideBlock guideBlock;

@property(nonatomic,copy)LaunchBlock launchBlock;

@property(nonatomic,strong)UIViewController *mainViewController;//程序主控制器


-(void)storeFirstName:(NSString *)notFirst andMainViewController:(UIViewController *)mainVC guide:(GuideBlock)guide launch:(LaunchBlock)launch;//notFirst是作为存贮的key,mainVC进入程序之后的主控制器

-(void)scrollGuideWithPicturesName:(NSArray *)pictures progressName:(NSArray *)progresses;//滑动视图样式

-(void)viewLaunchAdvertisePatternWithImage:(NSString *)imageName time:(NSInteger)time;//广告样式的发起页配置

-(void)goDirect;

@end
