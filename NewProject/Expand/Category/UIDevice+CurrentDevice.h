//
//  UIDevice+CurrentDevice.h
//  NewProject
//
//  Created by Livespro on 2016/12/19.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (CurrentDevice)

//获取设备信号
NSString * iphoneTypeGet(void);

//获取网络类型，根据Statebar获取
NSString * NetworkingStatesFromStatebar(void);

@end
