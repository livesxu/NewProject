//
//  TestViewController.m
//  NewProject
//
//  Created by Livespro on 2016/11/28.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import "TestViewController.h"
#import "SkipRollLoadingAnimation.h"

@interface TestViewController ()

@property (nonatomic,strong) UIView *viewTest;



@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *back=[UIButton buttonWithType:UIButtonTypeCustom];
    back.backgroundColor=[UIColor redColor];
    back.frame=CGRectMake(100, 100, 50, 44);
    back.titleLabel.text=@"Go";
    
    [back addTarget:self action:@selector(goAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:back];
    
    self.statusTopDistance = 300;
    
    self.isInteractivePopEnable=NO;
    
}
-(void)goAction{
    
    [self.viewTest removeFromSuperview];
    self.status=BaseShowStatusDefault;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *)viewTest{
    if (!_viewTest) {
        _viewTest=[[UIView alloc]initWithFrame:CGRectMake(200, 200, 50, 50)];
        _viewTest.backgroundColor=[UIColor greenColor];
        
    }
    return _viewTest;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view addSubview:self.viewTest];
    self.status=BaseShowStatusLoading;
    
//    [self.view beginLoading];
//    [[SkipRollLoadingAnimation alloc]configureAnimationInLayer:self.view.layer withSize:CGSizeMake(50, 50) tintColor:[UIColor yellowColor]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
