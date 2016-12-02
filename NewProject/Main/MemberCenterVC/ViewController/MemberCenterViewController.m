//
//  MemberCenterViewController.m
//  NewProject
//
//  Created by Livespro on 2016/11/26.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import "MemberCenterViewController.h"

#import "TestViewController.h"

@interface MemberCenterViewController ()

@end

@implementation MemberCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *back=[UIButton buttonWithType:UIButtonTypeCustom];
    back.backgroundColor=[UIColor redColor];
    back.frame=CGRectMake(100, 100, 50, 44);
    back.titleLabel.text=@"Go";
    
    [back addTarget:self action:@selector(goAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:back];
}
-(void)goAction{
    
    TestViewController *test=[[TestViewController alloc]init];
    
    [self.navigationController pushViewController:test animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
