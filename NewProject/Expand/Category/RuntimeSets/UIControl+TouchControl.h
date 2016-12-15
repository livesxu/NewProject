//
//  UIControl+TouchControl.h
//  NewProject
//
//  Created by Livespro on 2016/12/14.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define defaultInterval .0f  //默认时间间隔
@interface UIControl (TouchControl)
/**设置点击时间间隔*/
@property (nonatomic, assign) NSTimeInterval timeInterval;
/**
 *  用于设置单个按钮不需要被hook
 */
@property (nonatomic, assign) BOOL isIgnore;

@end
