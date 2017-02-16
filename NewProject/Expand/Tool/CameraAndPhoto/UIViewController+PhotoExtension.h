//
//  UIViewController+PhotoExtension.h
//  NewProject
//
//  Created by Livespro on 2016/12/6.
//  Copyright © 2016年 FZ. All rights reserved.
//添加裁剪、、、2016.12.16

#import <UIKit/UIKit.h>
#import "LGPhoto.h"
@class LGPhotoPickerViewController;
@class CameraCustomViewController;

typedef void(^PhotoAction)(UIImage *image);

@interface UIViewController (PhotoExtension)

-(void)photoAlertShowAction:(PhotoAction)photoAction IsClip:(BOOL)isClip;

-(void)cameraerShowAction:(PhotoAction)photoAction IsClip:(BOOL)isClip;

-(void)pickerShowAction:(PhotoAction)photoAction IsClip:(BOOL)isClip;

@end
