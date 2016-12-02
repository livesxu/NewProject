//
//  LXGuideAndLaunch.m
//  XiaoLiuFisheries
//
//  Created by Livespro on 16/9/9.
//  Copyright © 2016年 福中集团软件公司. All rights reserved.
//

#import "LXGuideAndLaunch.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface LXGuideAndLaunch ()

@property(nonatomic,strong) UILabel *timeLabel;

@property(nonatomic,strong) UIButton *btnGo;

@end

@implementation LXGuideAndLaunch

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)storeFirstName:(NSString *)notFirst andMainViewController:(UIViewController *)mainVC guide:(GuideBlock)guide launch:(LaunchBlock)launch;{
    
    self.mainViewController=mainVC;
    
    self.guideBlock=guide;
    self.launchBlock=launch;
    
    BOOL isFirst=[[NSUserDefaults standardUserDefaults]boolForKey:notFirst];
    
    if (isFirst==NO) {
        
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:notFirst];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [self createGuide];
        
        
    }else{
        
        self.launchView=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        
        [self.view addSubview:self.launchView];
        
        [self createLaunch];
        
    }
    
}

-(void)createGuide{//引导页
    
    self.guideView=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.view addSubview:self.guideView];
    
    self.guideBlock();
    
    
}
-(void)scrollGuideWithPicturesName:(NSArray *)pictures progressName:(NSArray *)progresses{
    self.pictures=pictures;
    
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    scrollView.pagingEnabled=YES;//是否分页效果
    
    scrollView.showsHorizontalScrollIndicator=NO;//是否显示水平滚动条
    
    //    scrollView.autoresizesSubviews=NO;
    
    scrollView.delegate=self;
    
    scrollView.contentSize=CGSizeMake(pictures.count*kWidth, kHeight);
    
    for (NSInteger i=0; i<pictures.count; i++) {
        
        NSString *picture=pictures[i];//引导图片的名字
        
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, kScreenHeight)];//引导图
        
        imageView.image=[UIImage imageNamed:picture];
        
        if (i != 4) {
            NSString *progress=progresses[i];//进度条图片的名字
            
            UIImageView *progressView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kScreenHeight - kScreenHeight *60/667 -32, kScreenWidth, 18)];//进度条
            progressView.image = [UIImage imageNamed:progress];
            
            progressView.contentMode = UIViewContentModeCenter;
            
            [imageView addSubview:progressView];
        }
        
        [scrollView addSubview:imageView];
        
    }
    
    [self.guideView addSubview:scrollView];
    
    if (progresses.count==0) {
        //创建UIPageControl
        UIPageControl *pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(kWidth/3, kHeight-50, kWidth/3, 44)];
        pageControl.numberOfPages=pictures.count;
        pageControl.tag=1002;
        
        [self.guideView insertSubview:pageControl aboveSubview:scrollView];
        
    }
}

-(void)createLaunch{//发起页
    
    self.launchView=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.view addSubview:self.launchView];
    
    
    self.launchBlock();
    
    
}
//请求到数据GO
-(void)viewLaunchAdvertisePatternWithImage:(NSString *)imageName time:(NSInteger)time;{
    
    UIImageView *view=[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [view sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"ad_page"]];
    
//    view.image=[UIImage imageNamed:imageName];
    
    [self.launchView addSubview:view];
    
    UIButton *timeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    timeBtn.frame=CGRectMake(kScreenWidth-50-20, 20, 50, 50);

    [timeBtn setImage:[UIImage imageNamed:@"btn_jump_100"] forState:UIControlStateNormal];
    
    [timeBtn setTitle:[NSString stringWithFormat:@"%ld",time] forState:UIControlStateNormal];
    
    [timeBtn setTitleColor:[UIColor colorWithHexString:@"ea3838"] forState:UIControlStateNormal];
    
    timeBtn.backgroundColor=[UIColor colorWithHexString:@"000000" alpha:.4];
    
    [timeBtn setRadius:25 borderWidth:1 borderColor:[UIColor colorWithHexString:@"000000" alpha:.4]];
    
    [timeBtn addTarget:self action:@selector(goDirect) forControlEvents:UIControlEventTouchUpInside];
    
    [self.launchView insertSubview:timeBtn aboveSubview:view];
    
    _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-50-20, 50, 50, 15)];
    
    [self.launchView insertSubview:_timeLabel aboveSubview:timeBtn];
    
    _timeLabel.text=[NSString stringWithFormat:@"%lds",time];
    _timeLabel.font=[UIFont systemFontOfSize:16];
    _timeLabel.textColor=[UIColor colorWithHexString:@"ea3838"];
    _timeLabel.textAlignment=NSTextAlignmentCenter;
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction:) userInfo:@(time) repeats:YES];
    
}

-(void)goDirect{
    
    [UIApplication sharedApplication].keyWindow.rootViewController = self.mainViewController;
}

-(void)timeAction:(NSTimer *)timer{
    
    static NSInteger time;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        time=[timer.userInfo integerValue];
        
    });
    
    time--;
    
    _timeLabel.text=[NSString stringWithFormat:@"%lds",time];
    
    if (time<=0) {
        
        [UIApplication sharedApplication].keyWindow.rootViewController = self.mainViewController;
        
//        [UIView animateWithDuration:0.5 animations:^{
//            
//            self.mainViewController.view.transform = CGAffineTransformMakeScale(1.2, 1.2);
//            
//        } completion:^(BOOL finished) {
//            
//            self.mainViewController.view.transform = CGAffineTransformIdentity;
//            
//        }];
        
        [timer invalidate];
        
        return;
        
    }
    
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.x > (kScreenWidth * (self.pictures.count-1))) {
        
//        //先给定一个缩小的效果
//        self.mainViewController.view.transform = CGAffineTransformMakeScale(0.6, 0.6);
//        
//        [UIView animateWithDuration:.3 animations:^{
//            //恢复原始的大小
//            self.mainViewController.view.transform = CGAffineTransformIdentity;
//        }];
        
        [UIApplication sharedApplication].keyWindow.rootViewController = self.mainViewController;
    }
    if (scrollView.contentOffset.x > (kScreenWidth * (self.pictures.count-2))) {
        
        [self.view addSubview:self.btnGo];
    } else {
        
        [_btnGo removeFromSuperview];
    }
    
    if ([self.guideView viewWithTag:1002]) {
        
        UIPageControl *pageControl=(UIPageControl *)[self.guideView viewWithTag:1002];
        
        pageControl.currentPage=scrollView.contentOffset.x/kWidth;
        
        
    }
    
}

-(UIButton *)btnGo{
    
    if (!_btnGo) {
        _btnGo=[UIButton buttonWithFrame:CGRectMake(20, kScreenHeight - 45- kScreenHeight * 60/667, kScreenWidth-40, 45) BackgroundColor:[UIColor clearColor] Title:@"立即体验" TitleColor:[UIColor colorWithHexString:@"ffffff"] TitleFont:18 Target:self Selector:@selector(goDirect)];
        [_btnGo setRadius:6 borderWidth:1 borderColor:[UIColor colorWithHexString:@"ffffff"]];
        
    }
    return _btnGo;
}

@end
