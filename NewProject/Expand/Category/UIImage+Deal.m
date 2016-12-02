//
//  UIImage+Deal.m
//  XTWL_XFJY
//
//  Created by xuntiangwangluo on 14-12-9.
//  Copyright (c) 2014年 xuntiangwangluo. All rights reserved.
//

#import "UIImage+Deal.h"

#define AvailableString(string) string == nil || ![string isKindOfClass:[NSString class]] ? @"":string
#define StringFromIdToId(idType,idTypet) [NSString stringWithFormat:@"%@%@",idType,idTypet]

@implementation UIImage (Deal)

//设置图片宽高
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    //    SYYLog(@"%@%f%f",image,newSize.height,newSize.width);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


//限制图片尺寸
+ (UIImage *)getCutImageWithImage:(UIImage *)image sendKB:(float)sendKB
{
    NSData *sendImageData = UIImageJPEGRepresentation(image, 1.0);
    NSUInteger sizeOrigin = [sendImageData length];
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    
    if (sizeOriginKB > sendKB) {
        float a = sendKB;
        float b = (float)sizeOriginKB;
        float q = sqrtf(a / b);   //压缩比
        
        CGSize sizeImage = [image size];
        CGFloat widthSmall = sizeImage.width * q;
        CGFloat heighSmall = sizeImage.height * q;
        CGSize sizeImageSmall = CGSizeMake(widthSmall, heighSmall);
        
        //        image = [self imageWithImage:image scaledToSize:sizeImageSmall];
        //        image = [self imageByScalingAndCroppingForSize:sizeImageSmall setImage:image];
        
        UIGraphicsBeginImageContext(sizeImageSmall);
        CGRect smallImageRect = CGRectMake(0, 0, sizeImageSmall.width, sizeImageSmall.height);
        [image drawInRect:smallImageRect];
        UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        image = smallImage;
        
        //        NSData *dataImage = UIImageJPEGRepresentation(smallImage, 1.0);
        //        sendImageData = dataImage;
    }
    
    return image;
}

#pragma mark 保存图片到Doc
+ (void)saveImageToDocWithImage:(UIImage *)image imageName:(NSString *)imageName
{
    NSString *aPath=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),AvailableString(imageName)]; //.png
    NSData *imgData = UIImageJPEGRepresentation(image,0);
    [imgData writeToFile:aPath atomically:YES];
}

/*取出图片*/
+ (UIImage *)getImageFromDocWithImageName:(NSString *)imageName
{
    NSString *aPath3=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),AvailableString(imageName)]; //.png
    UIImage *image=[[UIImage alloc]initWithContentsOfFile:aPath3];
    
    return image;
}

/*取出图片 通过链接*/
+ (UIImage *)getImageFromDocWithImageUrl:(NSString *)imageUrl
{
    return [self getImageFromDocWithImageName:[self getImageNameWithImageUrl:imageUrl]];
}

#pragma mark 判断本地是否存在
+ (BOOL)docHaveImageWithImageUrl:(NSString *)imageUrl
{
    NSString *imageName = [self getImageNameWithImageUrl:imageUrl];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //    NSError *error = nil;
    //    NSArray *fileList = [[NSArray alloc] init];
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    NSString *aPath = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),AvailableString(imageName)];  //.png
    //    fileList = [fileManager contentsOfDirectoryAtPath:aPath error:&error];
    //    if ([fileList count]>0) {
    //        return YES;
    //    }
    if([fileManager fileExistsAtPath:aPath]) //如果存在
    {
        return YES;
    }
    
    return NO;
}

#pragma mark 截取图片名字
+ (NSString *)getImageNameWithImageUrl:(NSString *)imageUrl
{
    NSArray *array = [imageUrl componentsSeparatedByString:@"/"];
    NSString *imageName = AvailableString([array objectAtIndex:[array count]-1]);
    return imageName;
}

#pragma mark 拼接名字
+ (NSString *)getImageNameWithImageUrl:(NSString *)imageUrl lastStr:(NSString *)lastStr
{
    NSArray *stringArray = @[];
    NSString *imgTypeStr = @"";
    if ([AvailableString(imageUrl) rangeOfString:@".png"].location != NSNotFound)
    {
        //png
        stringArray = [AvailableString(imageUrl) componentsSeparatedByString:@".png"];
        imgTypeStr = @".png";
        
    }else{
        
        if ([AvailableString(imageUrl) rangeOfString:@".jpg"].location != NSNotFound) {
            stringArray = [AvailableString(imageUrl) componentsSeparatedByString:@".jpg"];
            imgTypeStr = @".jpg";
        }
    }
    
    if ([stringArray count] == 0) {
        return AvailableString(imageUrl);
    }
    
    NSString *frontStr = stringArray[0];
    //小图片
    imageUrl = StringFromIdToId(frontStr, lastStr);
    
    return StringFromIdToId(imageUrl, imgTypeStr);
}

/*裁剪图片*/
+ (UIImage *)cutImage:(UIImage *)image newSize:(CGSize)newSize
{
    //压缩图片
    CGSize lastSize;
    CGImageRef imageRef;
    
    if ((image.size.width / image.size.height) < (newSize.width / newSize.height)) {
        lastSize.width = image.size.width;
        lastSize.height = image.size.width * newSize.height / newSize.width;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - lastSize.height) / 2, lastSize.width, lastSize.height));
        
    } else {
        lastSize.height = image.size.height;
        lastSize.width = image.size.height * newSize.width / newSize.height;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - lastSize.width) / 2, 0, lastSize.width, lastSize.height));
        
    }
    
    return [UIImage imageWithCGImage:imageRef];
}

/*获取最原始的图片*/
+ (instancetype)imageWithOriRenderingImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

//切图拉伸
+ (UIImage *)imageResizableWithName:(NSString *)imageName
{
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    return image;
}

+ (UIImage *)imageWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CALayer *layer = view.layer;
    [layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color size:CGSizeMake(1, 1)];
}

#pragma mark - 根据二维码生成图片

+ (UIImage *)QRCodeWithString:(NSString *)string size:(CGSize)size {
    
    //二维码过滤器
    CIFilter *qrImageFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //设置过滤器默认属性
    [qrImageFilter setDefaults];
    
    //将字符串转换成 NSdata (虽然二维码本质上是 字符串,但是这里需要转换,不转换就崩溃)
    //    字符串可以随意换成网址等
    NSData *qrImageData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    //设置过滤器的 输入值  ,KVC赋值
    [qrImageFilter setValue:qrImageData forKey:@"inputMessage"];
    
    //取出图片
    CIImage *qrImage = [qrImageFilter outputImage];
    
    //设置图片大小
    qrImage = [qrImage imageByApplyingTransform:CGAffineTransformMakeScale(size.width, size.height)];
    
    //转成 UI的 类型
    UIImage *qrUIImage = [UIImage imageWithCIImage:qrImage];
    
    return qrUIImage;
}

@end
