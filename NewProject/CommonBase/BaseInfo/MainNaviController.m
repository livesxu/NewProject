
//

#import "MainNaviController.h"
#import "MainTabBarViewController.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

@interface MainNaviController () <UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@property (nonatomic,assign)BOOL currentAnimating;

@end

@implementation MainNaviController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate=self;
    
}
#pragma clang diagnostic pop

#pragma mark - Can't add self as subview 处理

- (void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    if (self.viewControllers.count != 0) {
//        viewController.hidesBottomBarWhenPushed = YES;
//    }
    if(_currentAnimating) {
        return;
    } else if(animated) {
        _currentAnimating = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *) popViewControllerAnimated:(BOOL)animated {
    if(_currentAnimating) {
        return nil;
    } else if(animated) {
        _currentAnimating = YES;
    }
    
    return [super popViewControllerAnimated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    _currentAnimating = NO;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    //控制底部tab标签的hidden
    if (navigationController.viewControllers.count) {
        MainTabBarViewController *tabVC = (MainTabBarViewController *)navigationController.tabBarController;
        
        if (navigationController.viewControllers[0] != viewController) {
            
            tabVC.mainBarView.hidden=YES;
        }else{
            tabVC.mainBarView.hidden=NO;
        }
    }
    
    [[self transitionCoordinator] notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context){
        
        if([context isCancelled]) {
            UIViewController *fromViewController = [context viewControllerForKey:UITransitionContextFromViewControllerKey];
            [self navigationController:navigationController willShowViewController:fromViewController animated:animated];
            
            if([self respondsToSelector:@selector(navigationController:didShowViewController:animated:)]) {
                NSTimeInterval animationCompletion = [context transitionDuration] * [context percentComplete];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (uint64_t)animationCompletion * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [self navigationController:navigationController didShowViewController:fromViewController animated:animated];
                });
            }
        }
    }];
}


@end
