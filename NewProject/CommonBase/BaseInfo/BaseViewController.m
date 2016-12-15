
//

#import "BaseViewController.h"
#import "LoginViewController.h"

@interface BaseViewController ()

@property (nonatomic,copy) NSString *onceDataControl;//控制数据只加载一次的control

@property (nonatomic,strong) UIView *showStatusView;

@property (nonatomic,strong) UIView *loadingView;

@property (nonatomic,strong) UIView *errorView;

@property (nonatomic,strong) UIView *noResultView;

@end

@implementation BaseViewController

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    if (!self.view.window && [self isViewLoaded]) {
        self.view = nil;
    }
    
    [[SDImageCache sharedImageCache] clearMemory];
}

//static Views without use nib
- (void)loadView {
    [super loadView];
    
    self.fd_prefersNavigationBarHidden=YES;
    
    [self.view addSubview:self.naviStand];
    self.naviStand.backgroundColor=naviColor;
    self.view.backgroundColor=pageColor;
    
    [self staticViewsWithoutNib];
    
    if (self.navigationController.viewControllers.count) {
        if (self.navigationController.viewControllers[0] != self) {
            
            [self addBack];
        }
    }
}

-(void)staticViewsWithoutNib{
    
}
//返回键
-(void)addBack{
    
    UIButton *back=[UIButton buttonWithType:UIButtonTypeCustom];
    [back setImage:[UIImage imageNamed:@"back_btn_nav"] forState:UIControlStateNormal];
    back.frame=CGRectMake(0, 0, 14, 22);
    
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [self.naviStand addSubview:back];
    
    [self.naviStand.leftButtons addObject:back];
}
-(void)back{
    
    if (self.navigationController.viewControllers.count) {
        if (self.navigationController.viewControllers[0] != self) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

-(void)setIsInteractivePopEnable:(BOOL)isInteractivePopEnable{
    
    self.fd_interactivePopDisabled = !isInteractivePopEnable;
}

-(NaviStandCopy *)naviStand{
    if (!_naviStand) {
        _naviStand=[[NaviStandCopy alloc]initWithTitle:@"title"];
        
    }
    return _naviStand;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _statusTopDistance = kDefaultStatusTopDistance;
    
    self.onceDataControl=@"1";
    // Do any additional setup after loading the view.
    [self loadData];
    
}

-(void)loadData{
    
}

-(NSString *)onceDataControl{
    if (!_onceDataControl) {
        
        [self onceDataInitialization];
    }
    return _onceDataControl;
}
//数据初始化，本身属性或者数据初始化,防止viewDidUnload之后重走view加载数据丢失---当然最好使用懒加载！
-(void)onceDataInitialization{
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self changeViewsValue];
}

-(void)changeViewsValue{
    
}

#pragma mark - ShowHint
- (void)showHint:(NSString *)msg {
    
    if (msg == nil || [msg stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        return;
    }
    
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!self.view.window || ![self isViewLoaded]) return;
            [self hudShowHintWithMsg:msg baseView:self.view];
        });
    } else {
        if (!self.view.window || ![self isViewLoaded]) return;
        [self hudShowHintWithMsg:msg baseView:self.view];
    }
}

- (void)showLayerHint:(NSString *)msg {
    
    if (msg == nil || [msg stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        return;
    }
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hudShowHintWithMsg:msg baseView:keyWindow];
        });
    } else {
        [self hudShowHintWithMsg:msg baseView:keyWindow];
    }
}

- (void)hudShowHintWithMsg:(NSString *)msg baseView:(UIView *)view {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.removeFromSuperViewOnHide = YES;
    hud.detailsLabel.text = msg;
    hud.detailsLabel.font = [UIFont systemFontOfSize:14.0f];
    hud.margin = 10.0f;
    [hud hideAnimated:YES afterDelay:1.0f];
}

#pragma mark - MJRefresh
- (void)setUpRefreshWithScrollView:(UIScrollView *)scrollView {
    
    [self setUpHeaderRefreshWithScrollView:scrollView];
    [self setUpFooterRefreshWithScrollView:scrollView];
  
}

- (void)setUpHeaderRefreshWithScrollView:(UIScrollView *)scrollView {
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                                     refreshingAction:@selector(headerRefresh:)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    scrollView.mj_header = header;
    
}
- (void)setUpFooterRefreshWithScrollView:(UIScrollView *)scrollView {
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self
                                                                             refreshingAction:@selector(footerRefresh:)];
    footer.automaticallyHidden = YES;
    footer.stateLabel.hidden = YES;
    scrollView.mj_footer = footer;
}

- (void)headerRefresh:(MJRefreshNormalHeader *)header {
    
}

- (void)footerRefresh:(MJRefreshAutoNormalFooter *)footer {
    
}

-(UIView *)showStatusView{
    if (!_showStatusView) {
        
        _showStatusView = [[UIView alloc]initWithFrame:CGRectMake(0, _statusTopDistance, kScreenWidth, kScreenHeight - _statusTopDistance)];
        _showStatusView.backgroundColor=[UIColor clearColor];
        
    }
    return _showStatusView;
}

//设置statusView距离顶部高度
-(void)setStatusTopDistance:(CGFloat)statusTopDistance{
    _statusTopDistance = statusTopDistance;
    
    _showStatusView.frame=CGRectMake(0, _statusTopDistance, kScreenWidth, kScreenHeight - _statusTopDistance);
    
}

-(void)setStatus:(BaseShowStatus)status{
    _status=status;
    
    for (UIView *view in self.showStatusView.subviews) {
        [view removeFromSuperview];
    }
    [self.view addSubview:self.showStatusView];
    
    switch (_status) {
        case 0://BaseShowStatusDefault
            
            [self.showStatusView removeFromSuperview];
            
            break;
        case 1://BaseShowStatusLoading
            
            [self.showStatusView addSubview:self.loadingView];
            
            break;
        case 2://BaseShowStatusError
            
            [self.showStatusView addSubview:self.errorView];
            
            break;
        case 3://BaseShowStatusNoResult
            
            [self.showStatusView addSubview:self.noResultView];
            
            break;
            
        default:
            break;
    }
}

#pragma mark - loadingView

-(UIView *)loadingView{
    if (!_loadingView) {
        if (kLoadingImages.count) {
            UIImageView *imgLoading=[[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - kLoadingSize.width)/2,(kScreenHeight - _statusTopDistance - kLoadingSize.height)/2 - _statusTopDistance/2, kLoadingSize.width, kLoadingSize.height)];
            
            UIImage *imgs_little=[UIImage animatedImageWithImages:kLoadingImages duration:.3];
            
            imgLoading.image=imgs_little;
            
            _loadingView = imgLoading;
            
        } else {
            [_showStatusView endLoading];
            [_showStatusView beginLoading];
        }
    }
    return _loadingView;
}

#pragma mark - errorView
-(UIView *)errorView{
    if (!_errorView) {
        
        
    }
    return _errorView;
}


#pragma mark - noResultView
-(UIView *)noResultView{
    if (!_noResultView) {
        
        
    }
    return _noResultView;
}

#pragma mark - addTapHideKeyBoard
-(void)addTapHideKeyBoard:(UIView *)view{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHideKeyBoard:)];
    [view addGestureRecognizer:singleTap];
}
-(void)tapHideKeyBoard:(UITapGestureRecognizer *)tap{
    
    [tap.view endEditing:YES];
}

#pragma mark - alert提示

-(AlertBlockCustom *)alertNoticeTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle;{
    
    AlertBlockCustom *alert = [[AlertBlockCustom alloc]initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle clickBlockAction:nil otherButtonTitles:nil];
    
    [alert show];
    
    return alert;
}
#pragma mark - 自定义数字键盘 -- 价格输入类目控制:UITextField+InputNumberControl

-(void)numberKeyBoardApplyTo:(UITextField *)textField{
    
    [KeyBoardCustom applyTo:textField Type:CustomKeyBoardTypeNumber];
    
}

#pragma mark - Login --- 登录统一此处

-(void)loginAction:(NSDictionary *)followDic{
    
    LoginViewController *login = [[LoginViewController alloc]init];
 
}


@end
