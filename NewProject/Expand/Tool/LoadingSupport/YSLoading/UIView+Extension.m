
#import "UIView+Extension.h"
#import "objc/runtime.h"
#import "ZYAppHeaderForiPad.h"

@implementation UIView (Extension)
static char LoadingViewKey;


- (void)setLoadingView:(YSLoadingView *)loadingView{
    [self willChangeValueForKey:@"LoadingViewKey"];
    objc_setAssociatedObject(self, &LoadingViewKey,
                             loadingView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"LoadingViewKey"];
}

- (YSLoadingView*)loadingView{
    return objc_getAssociatedObject(self, &LoadingViewKey);
}

- (void)beginLoading{
    if (!self.loadingView) {
        self.loadingView = [[YSLoadingView alloc] initWithFrame:self.bounds];
//        [self.loadingView.titleLabel setText:@"加载中..."];
    }
    [self addSubview:self.loadingView];
    [self.loadingView startAnimating];
}

- (void)endLoading{
    if (self.loadingView) {
        [self.loadingView stopAnimating];
    }
}



@end


@implementation YSLoadingView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        if (kLoadingImages.count) {
            UIImageView *imgLoading=[[UIImageView alloc]initWithFrame:CGRectZero];
            imgLoading.bounds = CGRectMake(0, 0, kLoadingSize.width, kLoadingSize.height);
            imgLoading.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
            imgLoading.translatesAutoresizingMaskIntoConstraints = NO;
            
            UIImage *imgs_little=[UIImage animatedImageWithImages:kLoadingImages duration:.3];
            
            imgLoading.image=imgs_little;
            
            [self addSubview:imgLoading];
            
        } else {
            
            _loopView = [[YSLoopView alloc] initWithFrame:CGRectZero];
            _loopView.bounds = CGRectMake(0, 0,kLoadingSize.width, kLoadingSize.height);
            _loopView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
            _loopView.translatesAutoresizingMaskIntoConstraints = NO;
            [self addSubview:_loopView];
        }
//loading同步更改此处保证view动态调用beginLoading
//        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
//        _titleLabel.bounds = CGRectMake(0, 0, 200, 30);
//        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
//        [_titleLabel setFont:[UIFont systemFontOfSize:17]];
//        [_titleLabel setTextColor:RGBCOLORV(0x5c5c5c)];
//        
//        [_titleLabel setBackgroundColor:[UIColor clearColor]];
//        _titleLabel.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)+30);
//        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)startAnimating{
    self.hidden = NO;
    if (_isLoading) {
        return;
    }
    [self.loopView startLoopAnimating];
    _isLoading = YES;
}

- (void)stopAnimating{
    self.hidden = YES;
    _isLoading = NO;
    [self.loopView stopLoopAnimating];
}
@end
