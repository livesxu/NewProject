
//||使用方法
//    //显示相册
//    [WXPhotoBrowser showImageInView:self.viewController.view selectImageIndex:tap.view.tag delegate:self];
//
//#pragma mark - PhotoBrowserDelegate
//-(NSUInteger)numberOfPhotosInPhotoBrowser:(WXPhotoBrowser *)photoBrowser {
//    
//    return self.commentLayout.imageArr.count ? : 0;
//}
//
//-(WXPhoto *)photoBrowser:(WXPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
//    
//    WXPhoto *photo = [[WXPhoto alloc] init];
//    //原始的imageView
//    photo.srcImageView = self.imgViewArr[index];
//    
//    photo.url = [NSURL URLWithString:_commentLayout.imageArr[index]];
//    return photo;
//}


#import <UIKit/UIKit.h>
#import "WXPhoto.h"
#import "WXPhotoScrollView.h"
#import "WXPhotoCell.h"

@protocol PhotoBrowerDelegate <NSObject>

//需要显示的图片个数
- (NSUInteger)numberOfPhotosInPhotoBrowser:(WXPhotoBrowser *)photoBrowser;

//返回需要显示的图片对应的Photo实例,通过Photo类指定大图的URL,以及原始的图片视图
- (WXPhoto *)photoBrowser:(WXPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index;

@end

@interface WXPhotoBrowser : UIView <UIScrollViewDelegate,PhotoViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

// 所有的图片对象
@property (nonatomic, strong) NSArray *photos;
// 当前展示的图片索引
@property (nonatomic, assign) NSUInteger currentPhotoIndex;

@property (nonatomic,assign)id<PhotoBrowerDelegate> delegate;
//显示
+ (void)showImageInView:(UIView *)view selectImageIndex:(NSInteger)index delegate:(id<PhotoBrowerDelegate>)delegate;
@end
