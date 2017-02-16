//
//  UIImage+Deal.h
//  XTWL_XFJY
//
//  Created by xuntiangwangluo on 14-12-9.
//  Copyright (c) 2014年 xuntiangwangluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Deal)

/*设置图片宽高*/
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
/*压缩图片*/
+ (UIImage *)getCutImageWithImage:(UIImage *)image sendKB:(float)sendKB;
/*保存图片*/
+ (void)saveImageToDocWithImage:(UIImage *)image imageName:(NSString *)imageName;
/*取出图片*/
+ (UIImage *)getImageFromDocWithImageName:(NSString *)imageName;
/*取出图片 通过链接*/
+ (UIImage *)getImageFromDocWithImageUrl:(NSString *)imageUrl;
/*判断本地是否存在*/
+ (BOOL)docHaveImageWithImageUrl:(NSString *)imageUrl;
/*截取图片名字*/
+ (NSString *)getImageNameWithImageUrl:(NSString *)imageUrl;
/*拼接图片名字*/
+ (NSString *)getImageNameWithImageUrl:(NSString *)imageUrl lastStr:(NSString *)lastStr;
/*裁剪图片*/
+ (UIImage *)cutImage:(UIImage *)image newSize:(CGSize)newSize;
/*获取没有渲染的图片*/
+ (instancetype)imageWithOriRenderingImage:(NSString *)imageName;
//切图拉伸
+ (UIImage *)imageResizableWithName:(NSString *)imageName;
/*截取屏幕*/
+ (UIImage *)imageWithView:(UIView *)view;
/*根据颜色创建图片*/
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color;
/*根据字符串生成二维码图片*/
+ (UIImage *)QRCodeWithString:(NSString *)string size:(CGSize)size;
/*生成图片*/
+ (UIImage*)getImageWithColor:(UIColor*)color andHeight:(CGFloat)height;
/*获取网络图片尺寸*/
+ (CGSize)downloadImageSizeWithURL:(id)imageURL;

@end
