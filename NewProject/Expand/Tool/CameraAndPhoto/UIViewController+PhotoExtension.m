//
//  UIViewController+PhotoExtension.m
//  NewProject
//
//  Created by Livespro on 2016/12/6.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import "UIViewController+PhotoExtension.h"
#import "CameraCustomViewController.h"

@interface UIViewController ()

@property (nonatomic,strong) LGPhotoPickerViewController *picker_photoExtension;

@property (nonatomic,strong) CameraCustomViewController *cameraer_photoExtension;

@property (nonatomic,strong) UIAlertController *photoAlert_photoExtension;

@property (nonatomic,copy) PhotoAction photoAction_photoExtension;

@end

@implementation UIViewController (PhotoExtension)
static char CameraerKey;
static char PickerKey;
static char PhotoAlertKey;
static char PhotoActionKey;

- (void)setCameraer_photoExtension:(CameraCustomViewController *)cameraer{
    [self willChangeValueForKey:@"CameraerKey"];
    objc_setAssociatedObject(self, &CameraerKey,
                             cameraer,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"CameraerKey"];
}

- (CameraCustomViewController *)cameraer_photoExtension{
    return objc_getAssociatedObject(self, &CameraerKey);
}


- (void)setPicker_photoExtension:(LGPhotoPickerViewController *)picker{
    [self willChangeValueForKey:@"PickerKey"];
    objc_setAssociatedObject(self, &PickerKey,
                             picker,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"PickerKey"];
}

-(LGPhotoPickerViewController *)picker_photoExtension{
    return objc_getAssociatedObject(self, &PickerKey);
}


- (void)setPhotoAlert_photoExtension:(UIAlertController *)photoAlert{
    [self willChangeValueForKey:@"PhotoAlertKey"];
    objc_setAssociatedObject(self, &PhotoAlertKey,
                             photoAlert,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"PhotoAlertKey"];
}

-(UIAlertController *)photoAlert_photoExtension{
    return objc_getAssociatedObject(self, &PhotoAlertKey);
}


- (void)setPhotoAction_photoExtension:(PhotoAction)photoAction{
    [self willChangeValueForKey:@"PhotoActionKey"];
    objc_setAssociatedObject(self, &PhotoActionKey,
                             photoAction,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"PhotoActionKey"];
}

-(PhotoAction)photoAction_photoExtension{
    return objc_getAssociatedObject(self, &PhotoActionKey);
}


-(void)photoAlertShowAction:(PhotoAction)photoAction;{
    if (!self.photoAction_photoExtension) {
        self.photoAction_photoExtension = photoAction;
    }
    if (!self.photoAlert_photoExtension) {
        
        self.photoAlert_photoExtension = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        __weak typeof(self) weakSelf = self ;
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            if (!weakSelf.cameraer_photoExtension) {
                
                weakSelf.cameraer_photoExtension = [[CameraCustomViewController alloc]initCameraData:^(UIImage *image, NSDictionary *data) {
                    
                    NSLog(@"camera图片");
                    weakSelf.photoAction_photoExtension(image);
                }];
            }
            [weakSelf presentViewController:weakSelf.cameraer_photoExtension animated:YES completion:nil];
        }];
        
        UIAlertAction *pickAction = [UIAlertAction actionWithTitle:@"从本地相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (!weakSelf.picker_photoExtension) {
                
                weakSelf.picker_photoExtension = [[LGPhotoPickerViewController alloc] initWithShowType:LGShowImageTypeImagePicker];
                weakSelf.picker_photoExtension.delegate = weakSelf;
                weakSelf.picker_photoExtension.maxCount = 1;//仅单张上传,业务
            }
            [weakSelf.picker_photoExtension showPickerVc:weakSelf];
        }];
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            [self.photoAlert_photoExtension addAction:cameraAction];
        }
        [self.photoAlert_photoExtension addAction:pickAction];
        [self.photoAlert_photoExtension addAction:cancelAction];
        
    }
    
    [self presentViewController:self.photoAlert_photoExtension animated:YES completion:nil];
    
}

-(void)cameraerShowAction:(PhotoAction)photoAction;{
    
    if (!self.photoAction_photoExtension) {
        self.photoAction_photoExtension = photoAction;
    }
    
    __weak typeof(self) weakSelf = self ;
    if (!self.cameraer_photoExtension) {
        
        self.cameraer_photoExtension = [[CameraCustomViewController alloc]initCameraData:^(UIImage *image, NSDictionary *data) {
            
            NSLog(@"camera图片");
            weakSelf.photoAction_photoExtension(image);
        }];
    }
    [self presentViewController:self.cameraer_photoExtension animated:YES completion:nil];
    
}

-(void)pickerShowAction:(PhotoAction)photoAction;{
    
    if (!self.photoAction_photoExtension) {
        self.photoAction_photoExtension = photoAction;
    }
    
    if (!self.picker_photoExtension) {
        
        self.picker_photoExtension = [[LGPhotoPickerViewController alloc] initWithShowType:LGShowImageTypeImagePicker];
        self.picker_photoExtension.delegate = self;
        self.picker_photoExtension.maxCount = 1;//仅单张上传,业务
    }
    [self.picker_photoExtension showPickerVc:self];
    
}

#pragma mark - LGPhotoPickerViewControllerDelegate

- (void)pickerViewControllerDoneAsstes:(NSArray *)assets isOriginal:(BOOL)original{
    /*
     //assets的元素是LGPhotoAssets对象，获取image方法如下:
     NSMutableArray *thumbImageArray = [NSMutableArray array];
     NSMutableArray *originImage = [NSMutableArray array];
     NSMutableArray *fullResolutionImage = [NSMutableArray array];
     
     for (LGPhotoAssets *photo in assets) {
     //缩略图
     [thumbImageArray addObject:photo.thumbImage];
     //原图
     [originImage addObject:photo.originImage];
     //全屏图
     [fullResolutionImage addObject:fullResolutionImage];
     }
     */
    LGPhotoAssets *photo=assets.lastObject;
    
    self.photoAction_photoExtension(photo.originImage);
    
    NSLog(@"拿到Image");
    
}

@end
