//
//  LXScrollLoopViewController.m
//  XiaoLiuRetail
//
//  Created by Livespro on 2017/2/17.
//  Copyright © 2017年 福中. All rights reserved.
//

#import "LXScrollLoopViewController.h"
#import "UIImageView+CornerRadius.h"
@class ScrollCollectionCell;
@class LXPageControl;
@class LXPageControlCollectionCell;

static NSString *ScrollCollectionCellID = @"ScrollCollectionCell";
static NSString *LXPageControlCollectionCellID = @"LXPageControlCollectionCell";

//补全tips,比如:一共10个item但是只有3个tips,则后面补全7个@""
void TipSupplement(NSMutableArray *tips ,NSInteger count){
    
    if (tips.count < count) {
        
        [tips addObject:@""];
        
        TipSupplement(tips, count);
    }
}

@interface LXScrollLoopViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    dispatch_source_t timer;
}

@property (nonatomic, assign)  NSTimeInterval timeInterval;

@property (nonatomic, assign)  NSUInteger imageCount;

@property (nonatomic, strong)  NSMutableArray *imageURLs;

@property (nonatomic,   copy)  LXLoopDidSelectItemBlock selectItemBlock;

@property (nonatomic, strong)  UICollectionView *collectionShow;

@property (nonatomic, strong)  LXPageControl *pageControl;

@property (nonatomic, assign)  CGRect pageControlLocation;

@property (nonatomic, strong)  UIColor *pageControlNomalColor;

@property (nonatomic, strong)  UIColor *pageControlCurrentColor;

@property (nonatomic, strong)  NSMutableArray *labelTips;

@property (nonatomic, assign)  CGRect labelLocation;

@end

@implementation LXScrollLoopViewController

+ (instancetype)LXScrollLoopWithFrame:(CGRect)frame
                           imageCount:(NSUInteger)imageCount
                             imageURL:(ScrollImageURL)imageURL
                         timeInterval:(NSTimeInterval)timeInterval
                            didSelect:(LXLoopDidSelectItemBlock)didSelect;{
    
    LXScrollLoopViewController *loopScroll = [[LXScrollLoopViewController alloc]init];
    
    loopScroll.view.frame = frame;
    
    [loopScroll LXScrollLoopWitImageCount:imageCount imageURL:imageURL timeInterval:timeInterval didSelect:didSelect];
    
    return loopScroll;
}

- (void)LXScrollLoopWitImageCount:(NSUInteger)imageCount
                         imageURL:(ScrollImageURL)imageURL
                     timeInterval:(NSTimeInterval)timeInterval
                        didSelect:(LXLoopDidSelectItemBlock)didSelect;{
    
    if (!imageCount) return;
    
    self.imageCount = imageCount;
    
    for (NSInteger i = 0; i < imageCount; i++) {
        
        [self.imageURLs addObject:imageURL(i)];
    }
    
    self.timeInterval = timeInterval;
    
    self.selectItemBlock = didSelect;
    
    [self addParallaxImage];
    
    [self.view addSubview:self.collectionShow];
    
    [self addTimer];
    
}

- (NSMutableArray *)imageURLs{
    if (!_imageURLs) {
        
        _imageURLs = [NSMutableArray array];
    }
    return _imageURLs;
}

- (void)addParallaxImage{
    
    NSObject *obj = _imageURLs.firstObject;
    
    //添加两张伪图
    [_imageURLs insertObject:_imageURLs.lastObject atIndex:0];
    
    [_imageURLs addObject:obj];
    
}

- (UICollectionView *)collectionShow{
    if (!_collectionShow) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = self.view.bounds.size;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionShow = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                                 collectionViewLayout:flowLayout];
        _collectionShow.backgroundColor = [UIColor clearColor];
        _collectionShow.pagingEnabled = YES;
        _collectionShow.showsHorizontalScrollIndicator = NO;
        _collectionShow.showsVerticalScrollIndicator = NO;
        [_collectionShow  registerClass:[ScrollCollectionCell class]
                 forCellWithReuseIdentifier:ScrollCollectionCellID];
        _collectionShow.dataSource = self;
        _collectionShow.delegate = self;
        
    }
    return _collectionShow;
}

- (void)addTimer{
    
    __weak typeof(self) weakSelf = self;
    //定时器
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, _timeInterval * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        
        [weakSelf autoScroll];
    });
    dispatch_resume(timer);
}

- (void)autoScroll {
    NSInteger curIndex = (self.collectionShow.contentOffset.x) / self.view.bounds.size.width;
    NSInteger toIndex = curIndex + 1;
        
    [self.collectionShow scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:toIndex inSection:0]
                                    atScrollPosition:UICollectionViewScrollPositionNone
                                        animated:YES];
    
}

- (void)stopTimer
{
    if (timer) {
        dispatch_source_cancel(timer);
        timer = nil;
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;{
    
    return self.imageURLs.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;{
    
    ScrollCollectionCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:ScrollCollectionCellID forIndexPath:indexPath];
    
    collectionCell.imageURL = self.imageURLs[indexPath.item];
    
    if (_labelTips) {//是否有label标签
        
        NSString *tip = _labelTips[indexPath.item];
        
        if (tip && tip.length) {
            
            UILabel *label_temp = [collectionCell.contentView viewWithTag:1001];
            
            if (label_temp) {
                
                label_temp.text = tip;
            } else {
                
                label_temp = [[UILabel alloc]initWithFrame:_labelLocation];
                label_temp.tag = 1001;
                label_temp.text = tip;
                label_temp.textColor = [UIColor redColor];
                [collectionCell.contentView addSubview:label_temp];
            }
            
        } else {
            
            UILabel *label_temp = [collectionCell.contentView viewWithTag:1001];
            
            if (label_temp) {
                
                [label_temp removeFromSuperview];
            }
        }
    }
    
    return collectionCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   
    if (self.selectItemBlock) {
        
        if (indexPath.item == 0 || (indexPath.item == _imageURLs.count - 1)) {
            
            if (indexPath.item) {//伪装真实的第一个
                
                self.selectItemBlock( 0 );
                
            } else {//伪装真实的最后一个
                
                self.selectItemBlock(_imageCount - 1);
            }
            
        } else {
            
          self.selectItemBlock(indexPath.item - 1);
        }
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.x == 0) {
        
        scrollView.contentOffset=CGPointMake(self.view.bounds.size.width*(self.imageURLs.count-2), 0);
        
    }
    if (scrollView.contentOffset.x == self.view.bounds.size.width*(self.imageURLs.count-1)) {
        
        scrollView.contentOffset=CGPointMake(self.view.bounds.size.width, 0);
    }
    
    if (_pageControl) {
        
        NSInteger x=scrollView.contentOffset.x/self.view.frame.size.width;
        
        if (x == 0 || (x == _imageURLs.count - 1)) {
            
            if (x) {//伪装真实的第一个
                
                x = 0 ;
                
            } else {//伪装真实的最后一个
                
                x = _imageCount - 1 ;
            }
            
        } else {
            
            x -= 1;
        }
        
        _pageControl.currentPage=x;
        
    }
}

- (void)addPageControlWithLocation:(CGRect)location
                       normalColor:(UIColor *)normalColor
                      currentColor:(UIColor *)currentColor;{
    
    _pageControlLocation = location;
    
    _pageControlNomalColor = normalColor;
    
    _pageControlCurrentColor = currentColor;
    
}

- (LXPageControl *)pageControl{
    
    if (!_pageControl) {
        
        __weak typeof(self) weakSelf = self;
        _pageControl = [LXPageControl LXPageControlWithFrame:_pageControlLocation numberOfPages:_imageCount currentPage:0 pageSize:CGSizeMake(_pageControlLocation.size.height, _pageControlLocation.size.height) nomalPageColor:_pageControlNomalColor currentPageColor:_pageControlCurrentColor pageControlAction:^(NSInteger index) {
            
            [weakSelf.collectionShow scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index +1 inSection:0]
                                        atScrollPosition:UICollectionViewScrollPositionNone
                                                animated:YES];
        }];
        
    }
    
    return _pageControl;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (_pageControlLocation.size.width) {
        
        [self.view addSubview:self.pageControl];
    }
}


- (void)addTipLabelWithLoaction:(CGRect)loaction tips:(NSArray <NSString *> *)tips;{
    
    _labelTips = [NSMutableArray arrayWithArray:tips];
    
    TipSupplement(_labelTips, _imageCount);
    //伪图同理添加label
    [_labelTips insertObject:tips.lastObject atIndex:0];
    
    [_labelTips addObject:tips.firstObject];
    
    _labelLocation = loaction;
    
}


@end



@interface ScrollCollectionCell ()

@property (nonatomic, strong)  UIImageView *imageView;

@end

@implementation ScrollCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        
        [self.contentView addSubview:self.imageView];
        
    }
    
    return self;
}

-(void)setImageURL:(NSURL *)imageURL{
    _imageURL = imageURL;
    
    [self.imageView sd_setImageWithURL:_imageURL];
}


@end


#define kLineSpaceScale 1.3 // 空隙/pageSize

@interface LXPageControl ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic, assign)  NSInteger numberOfPages;

@property (nonatomic, strong)  UIColor *pageIndicatorTintColor;

@property (nonatomic, strong)  UIColor *currentPageIndicatorTintColor;

@property (nonatomic, assign)  CGSize pageControlSize;

@property (nonatomic,   copy)  LXPageControlAction pageControlAction;

@end


@implementation LXPageControl

+ (instancetype)LXPageControlWithFrame:(CGRect)frame
                         numberOfPages:(NSInteger)numberOfPages
                           currentPage:(NSInteger)currentPage
                              pageSize:(CGSize)pageSize
                        nomalPageColor:(UIColor *)nomalPageColor
                      currentPageColor:(UIColor *)currentPageColor
                     pageControlAction:(LXPageControlAction)pageControlAction;{
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = pageSize;
    flowLayout.minimumLineSpacing = kLineSpaceScale * pageSize.width;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //计算是pageControl居中
    CGFloat widthSpaceMore = frame.size.width - numberOfPages * pageSize.width - (numberOfPages-1) * pageSize.width * kLineSpaceScale;
    
    LXPageControl *pageControl = [[LXPageControl alloc]initWithFrame:CGRectMake(frame.origin.x + widthSpaceMore/2, frame.origin.y, frame.size.width - widthSpaceMore, frame.size.height) collectionViewLayout:flowLayout];

    pageControl.backgroundColor = [UIColor clearColor];
    pageControl.pagingEnabled = YES;
    pageControl.showsHorizontalScrollIndicator = NO;
    pageControl.showsVerticalScrollIndicator = NO;
    [pageControl  registerClass:[LXPageControlCollectionCell class] forCellWithReuseIdentifier:LXPageControlCollectionCellID];
    pageControl.dataSource = pageControl;
    pageControl.delegate = pageControl;
    
    pageControl.numberOfPages = numberOfPages;
    pageControl.currentPage = currentPage;
    pageControl.pageIndicatorTintColor = nomalPageColor;
    pageControl.currentPageIndicatorTintColor = currentPageColor;
    pageControl.pageControlAction = pageControlAction;
    
    return pageControl;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;{
    
    return self.numberOfPages;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;{
    
    LXPageControlCollectionCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:LXPageControlCollectionCellID forIndexPath:indexPath];
    
//    cell.imageURL = [NSURL URLWithString:@"http://file.xiao6.com/img/20170105/company/434542170105162417967.png"];//若改pageControl为图片则传递urlArray，赋值即可
    
    cell.imageView.backgroundColor = _pageIndicatorTintColor;
    
    if (indexPath.item == _currentPage) {
        
        cell.imageView.backgroundColor = _currentPageIndicatorTintColor;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.pageControlAction) {
        
        self.pageControlAction(indexPath.item);
    }
}

- (void)setCurrentPage:(NSInteger)currentPage{
    _currentPage = currentPage;
    
    [self reloadData];
}

@end

@interface LXPageControlCollectionCell ()



@end


@implementation LXPageControlCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.contentView.backgroundColor = [UIColor clearColor];
        
        self.imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        
        self.imageView.layer.cornerRadius = frame.size.width/2;
        self.imageView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:self.imageView];
        
    }
    
    return self;
}

-(void)setImageURL:(NSURL *)imageURL{
    _imageURL = imageURL;
    
    [self.imageView sd_setImageWithURL:_imageURL];
}


@end
