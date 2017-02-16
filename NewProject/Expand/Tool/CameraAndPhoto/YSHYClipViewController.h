
//裁剪VC

#import <UIKit/UIKit.h>

typedef enum{
    CIRCULARCLIP   = 0,   //圆形裁剪
    SQUARECLIP            //方形裁剪
    
}ClipType;

typedef void(^ClipInfo)(UIImage *imageGet);

@interface YSHYClipViewController : BaseViewController<UIGestureRecognizerDelegate>
{
    UIImageView *_imageView;
    UIImage *_image;
    UIView * _overView;
    UIView * _imageViewScale;
    
    CGFloat lastScale;
}
@property (nonatomic, assign)CGFloat scaleRation;//图片缩放的最大倍数
@property (nonatomic, assign)CGFloat radius; //裁剪框的半径
@property (nonatomic, assign)CGRect circularFrame;//裁剪框的frame
@property (nonatomic, assign)CGRect OriginalFrame;
@property (nonatomic, assign)CGRect currentFrame;

@property (nonatomic, assign)ClipType clipType;  //裁剪的形状

@property (nonatomic, copy) ClipInfo clipInfo;

-(instancetype)initWithImage:(UIImage *)image ClipInfo:(ClipInfo)clipInfo;

@end
