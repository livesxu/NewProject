//
//  UITextField+InputNumberControl.h
//  XiaoLiuFisheries
//
//  Created by Livespro on 2016/10/18.
//  Copyright © 2016年 福中集团软件公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (InputNumberControl)

/**
 * 小数点输入控制。 输入框..最大极限值..小数点后保留几位
 */
+(void)apply:(UITextField *)tfUsed inputMax:(CGFloat)maxNumber DecimalPointLater:(NSInteger)pointNumber;

/**
 * 整数输入控制。 输入框..最大极限值
 */
+(void)apply:(UITextField *)tfUsed inputIntegerMax:(NSInteger)maxNumber;

/**
 * 输入长度控制。 输入框..输入的最大长度
 */
+(void)apply:(UITextField *)tfUsed inputLengthMax:(NSInteger)maxNumber;



@end
