//
//  UIViewController+PhotoExtension.h
//  NewProject
//
//  Created by Livespro on 2016/12/6.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGPhoto.h"
@class LGPhotoPickerViewController;
@class CameraCustomViewController;

typedef void(^PhotoAction)(UIImage *image);

@interface UIViewController (PhotoExtension)<LGPhotoPickerViewControllerDelegate>

-(void)photoAlertShowAction:(PhotoAction)photoAction;

-(void)cameraerShowAction:(PhotoAction)photoAction;

-(void)pickerShowAction:(PhotoAction)photoAction;

@end
