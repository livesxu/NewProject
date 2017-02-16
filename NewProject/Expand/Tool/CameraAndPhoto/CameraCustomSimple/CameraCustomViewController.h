//
//  CameraCustomViewController.h
//  XiaoLiuFisheries
//
//  Created by Livespro on 2016/10/24.
//  Copyright © 2016年 福中集团软件公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CameraPass)(UIImage *image, NSDictionary *data);

@interface CameraCustomViewController : UIViewController

@property (nonatomic ,copy) CameraPass cameraPass;

-(instancetype)initCameraData:(CameraPass)cameraPass isClip:(BOOL)isClip;

@end
