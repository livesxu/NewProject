//
//  TestViewController.m
//  NewProject
//
//  Created by Livespro on 2016/11/28.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import "TestViewController.h"
#import "SubTestBtn.h"
#import "NextTestTableViewController.h"
#import "NetworkCentre.h"

static NSString *const dataUrl = @"http://www.qinto.com/wap/index.php?ctl=article_cate&act=api_app_getarticle_cate&num=1&p=7";

@interface TestViewController ()<SubTestDelegate,LGPhotoPickerBrowserViewControllerDataSource,LGPhotoPickerBrowserViewControllerDelegate>

@property (nonatomic,strong) UIView *viewTest;

@property (nonatomic,strong) NSMutableArray *LGPhotoPickerBrowserPhotoArray;


@end

@implementation TestViewController

-(void)dealloc{
    
    NSLog(@"test销毁");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    SubTestBtn *back=[SubTestBtn buttonWithType:UIButtonTypeCustom];
    back.delegate = self;
    [[back rac_signalForSelector:@selector(touchesBegan:withEvent:)]subscribeNext:^(id x) {
        
        NSLog(@"RAC_Sub走了");
        NSLog(@"%@",x);
    }];
    
    back.backgroundColor=[UIColor redColor];
    back.frame=CGRectMake(100, 100, 50, 44);
    back.titleLabel.text=@"Go";
    
    back.timeInterval = 3;
    
//    [back addTarget:self action:@selector(goAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:back];
    id xx = [NSArray array][1];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(500, 1000, 100, 111)];
    
    [self.view addSubview:view];
//
//    [self.view layoutSubviews];
//    
//    UIImage *xxImg = [UIImage imageNamed:@"111"];
//    self.statusTopDistance = 300;
//    
//    
//    [self prepareForPhotoBroswerWithImage];

    UITextView *testTV = [[UITextView alloc]initWithFrame:CGRectMake(10, 400, kScreenWidth -20, kScreenHeight - 400)];
    
    testTV.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:testTV];
    
    
    
    UIButton *btnGreen = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btnGreen.backgroundColor = [UIColor greenColor];
    btnGreen.frame = CGRectMake(200, 100, 50, 50);
    
    
    __weak UITextView *weakTV = testTV;
    [[btnGreen rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
        NSLog(@"rac_green");
        
        [NetworkCentre Request:@"http://www.qinto.com/wap/index.php?ctl=article_cate&act=api_app_getarticle_cate&num=1&p=7" Type:NetworkRequestTypeGetCache parameters:nil success:^(id responseObject) {
            
            
            weakTV.text = [NetworkCentre jsonToString:responseObject];
            
        } failure:^(NSError *error) {
            
        }];
//        [self pushPB];
    }];
    
    
    UIButton *btnOr = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btnOr.backgroundColor = [UIColor orangeColor];
    btnOr.frame = CGRectMake(30, 30, 50, 50);
    [[btnOr rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        
        NSLog(@"rac_btnOr");
//        [self pushPB];
    }];
    
//    btnGreen.isOverStepTouch = YES;

    [btnGreen addSubview:btnOr];
    
    
    btnGreen.hitTestEdgeInsets = UIEdgeInsetsMake(0, 0, 100, 100);
    
    [self.view addSubview:btnGreen];

    
}

-(void)run{
    
    NSLog(@"run");
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSLog(@"11");
}
-(void)goAction{
    
//    id xx = [NSArray array][1];
    
    [self.viewTest removeFromSuperview];
    self.status=BaseShowStatusDefault;
    
    [self photoAlertShowAction:^(UIImage *image) {
        
        NSLog(@"|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||NEXT %@",image);
    } IsClip:YES];
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

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    [self.view addSubview:self.viewTest];
//    self.status=BaseShowStatusLoading;
//    
//    
//    [self showHint:@"HiHi"];
//    
    NextTestTableViewController *next = [[NextTestTableViewController alloc]init];
    
    [next aspect_hookSelector:@selector(viewDidAppear:) withOptions:0 usingBlock:^(){
        NSLog(@"ASP ___OK");} error:nil];
    
    [self.navigationController pushViewController:next animated:YES];
    
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
-(void)testPrintfSome;{
    
    NSLog(@"Sub代理走了");
}

-(void)pushPB{
    LGPhotoPickerBrowserViewController *bVC = [[LGPhotoPickerBrowserViewController alloc]init];
    bVC.delegate = self;
    bVC.dataSource = self;
    bVC.showType = LGShowImageTypeImageBroswer;
    [self presentViewController:bVC animated:YES completion:nil];
    
    
    
}
/**
 *  给照片浏览器传image的时候先包装成LGPhotoPickerBrowserPhoto对象
 */
- (void)prepareForPhotoBroswerWithImage {
    self.LGPhotoPickerBrowserPhotoArray = [[NSMutableArray alloc] init];
    for (int i = 1; i < 5; i++) {
        LGPhotoPickerBrowserPhoto *photo = [[LGPhotoPickerBrowserPhoto alloc] init];
        photo.photoImage = [UIImage imageNamed:[NSString stringWithFormat:@"guidepage_circle_0%d.jpg",i]];
        [self.LGPhotoPickerBrowserPhotoArray addObject:photo];
    }
}

/**
 *  每个组多少个图片
 */
- (NSInteger) photoBrowser:(LGPhotoPickerBrowserViewController *)photoBrowser numberOfItemsInSection:(NSUInteger)section;{
    
    return self.LGPhotoPickerBrowserPhotoArray.count;
}
/**
 *  每个对应的IndexPath展示什么内容
 */
- (id<LGPhotoPickerBrowserPhoto>)photoBrowser:(LGPhotoPickerBrowserViewController *)pickerBrowser photoAtIndexPath:(NSIndexPath *)indexPath;{
    
    return self.LGPhotoPickerBrowserPhotoArray[indexPath.item];
    
}


@end
