
// -- >有待扩展 --- 推荐  BHInfiniteScrollView B端首页使用，挺好

#import <UIKit/UIKit.h>

typedef NSURL *(^ScrollImageURL)(NSInteger index);
typedef void(^LXLoopDidSelectItemBlock)(NSInteger index);

@interface LXScrollLoopViewController : UIViewController

+ (instancetype)LXScrollLoopWithFrame:(CGRect)frame
                           imageCount:(NSUInteger)imageCount
                             imageURL:(ScrollImageURL)imageURL
                         timeInterval:(NSTimeInterval)timeInterval
                            didSelect:(LXLoopDidSelectItemBlock)didSelect;

- (void)LXScrollLoopWitImageCount:(NSUInteger)imageCount
                         imageURL:(ScrollImageURL)imageURL
                     timeInterval:(NSTimeInterval)timeInterval
                        didSelect:(LXLoopDidSelectItemBlock)didSelect;

- (void)stopTimer;

- (void)addPageControlWithLocation:(CGRect)location
                       normalColor:(UIColor *)normalColor
                      currentColor:(UIColor *)currentColor;

- (void)addTipLabelWithLoaction:(CGRect)loaction tips:(NSArray <NSString *> *)tips;

@end

@interface ScrollCollectionCell : UICollectionViewCell

@property (nonatomic, strong)  NSURL *imageURL;

@end



typedef void(^LXPageControlAction)(NSInteger index);

@interface LXPageControl : UICollectionView

@property (nonatomic, assign)  NSInteger currentPage;

+ (instancetype)LXPageControlWithFrame:(CGRect)frame
                         numberOfPages:(NSInteger)numberOfPages
                           currentPage:(NSInteger)currentPage
                              pageSize:(CGSize)pageSize
                        nomalPageColor:(UIColor *)nomalPageColor
                      currentPageColor:(UIColor *)currentPageColor
                     pageControlAction:(LXPageControlAction)pageControlAction;

@end


@interface LXPageControlCollectionCell : UICollectionViewCell

@property (nonatomic, strong)  UIImageView *imageView;

@property (nonatomic, strong)  NSURL *imageURL;

@end
