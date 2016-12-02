
//

#import "MainTabBarViewController.h"
#import "MainTabItem.h"
#import "BaseViewController.h"
#import "MainNaviController.h"

#define kBarVCs @[@"HomeViewController",@"ClassViewController",@"GroundViewController",@"MemberCenterViewController"]
#define kBarImgs @[@[@"tabbar_home",@"tabbar_home_selected"],@[@"tabbar_message_center",@"tabbar_message_center_selected"],@[@"tabbar_discover",@"tabbar_discover_selected"],@[@"tabbar_music",@"tabbar_music_selected"]]

#define kBarDefaultColor Color333//barTitle默认颜色

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.hidden=YES;
    [self.view addSubview:self.mainBarView];
    
    [self mainBarItemCreate];
    
    [self childrenCreat];
}

-(void)mainBarItemCreate{
    
    for (NSInteger i=0; i < kBarVCs.count; i++) {
      
        NSString *vcClass=kBarVCs[i];
        
        NSString *vcName = [vcClass stringByReplacingOccurrencesOfString:@"ViewController" withString:@""];
        
        __weak typeof(self) weakSelf = self;
        MainTabItem *barItem=[[MainTabItem alloc]initWithFrame:CGRectMake(i*kScreenWidth/kBarVCs.count, 0, kScreenWidth/kBarVCs.count, 49) Title:vcName  NomalColor:kBarDefaultColor SelectedColor:[UIColor orangeColor] NomalImg:kBarImgs[i][0] SelectedImg:kBarImgs[i][1] Tag:100000+i MainItemAction:^{
            
            weakSelf.selectedIndex=i;
            
            for (UIView *view in weakSelf.mainBarView.subviews) {
                MainTabItem *subBarItem = (MainTabItem *)view;
                subBarItem.isBeSelected=NO;
                if (subBarItem.tag_sign == i +100000) {
                    
                    subBarItem.isBeSelected = YES;
                }
            }
        }];
        if (barItem.tag_sign == 100000) {
            
            barItem.isBeSelected = YES;
        }
        
        [_mainBarView addSubview:barItem];
    }
}

-(UIView *)mainBarView{
    if (!_mainBarView) {
        
        _mainBarView=[[UIView alloc]initWithFrame:CGRectMake(0,kScreenHeight-49, kScreenWidth, 49)];
        _mainBarView.backgroundColor=tabColor;
        
    }
    return _mainBarView;
}

-(void)childrenCreat{
    
    for (NSInteger i=0; i < kBarVCs.count; i++) {
        
        Class BaseClass = NSClassFromString(kBarVCs[i]);
        
        BaseViewController *baseVC = [BaseClass new];
        
        baseVC.naviStand.title = kBarVCs[i];
        
        MainNaviController *naviVC=[[MainNaviController alloc]initWithRootViewController:baseVC];
        
        [self addChildViewController:naviVC];
    }
}

@end
