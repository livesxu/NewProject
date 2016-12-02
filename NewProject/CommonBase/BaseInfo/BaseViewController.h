
//

#import <UIKit/UIKit.h>
#import "NaviStandCopy.h"
#import "MJRefresh.h"
#import "AlertBlockCustom.h"

#define kDefaultStatusTopDistance 64.f//默认navi高度
#define kLoadingImages @[]
#define kLoadingSize CGSizeMake(50, 50)

#define kErrorImage @""
#define kNoResultImage @""

typedef NS_ENUM(NSInteger, BaseShowStatus) {
    BaseShowStatusDefault = 0,
    BaseShowStatusLoading,
    BaseShowStatusError,
    BaseShowStatusNoResult
};

@interface BaseViewController : UIViewController

@property (nonatomic,assign) BOOL isInteractivePopEnable;//是否可以手势返回

@property (nonatomic,strong) NaviStandCopy *naviStand;//导航栏

@property (nonatomic,assign) CGFloat statusTopDistance;//默认一个navi高度，设置status距离顶部高度

@property (nonatomic,assign) BaseShowStatus status;//设置loading,error,noResult展示和移除

-(void)staticViewsWithoutNib;

-(void)onceDataInitialization;//初始化数据

-(void)loadData;//ViewDidLoad 加载数据

-(void)changeViewsValue;//willAppear 修改数据

#pragma mark - ShowHint
- (void)showHint:(NSString *)msg;//Base Self View

- (void)showLayerHint:(NSString *)msg;//Base keyWindow

#pragma mark - MJRefresh
- (void)setUpRefreshWithScrollView:(UIScrollView *)scrollView;

- (void)setUpHeaderRefreshWithScrollView:(UIScrollView *)scrollView;

- (void)setUpFooterRefreshWithScrollView:(UIScrollView *)scrollView;

- (void)headerRefresh:(MJRefreshNormalHeader *)header;

- (void)footerRefresh:(MJRefreshAutoNormalFooter *)footer;

#pragma mark - addTapHideKeyBoard
-(void)addTapHideKeyBoard:(UIView *)view;

#pragma mark - alert提示
-(AlertBlockCustom *)alertNoticeTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle;

#pragma mark - 自定义数字键盘 -- 价格输入类目控制:UITextField+InputNumberControl
-(void)numberKeyBoardApplyTo:(UITextField *)textField;



@end
