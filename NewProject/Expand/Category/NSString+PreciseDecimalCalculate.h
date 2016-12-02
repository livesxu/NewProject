//
//  NSString+PreciseDecimalCalculate.h
//  XiaoLiuFisheries
//
//  Created by Livespro on 2016/10/19.
//  Copyright © 2016年 福中集团软件公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PreciseDecimalCalculate)

/**
 * 加
 */
+(NSString *)addCalculate:(NSString *)numericalValueOne With:(NSString *)numericalValueOther;

/**
 * 减
 */
+(NSString *)subtractCalculate:(NSString *)numericalValueOne With:(NSString *)numericalValueOther;

/**
 * 乘
 */
+(NSString *)multiplyCalculate:(NSString *)numericalValueOne With:(NSString *)numericalValueOther;

/**
 * 除
 */
+(NSString *)divideCalculate:(NSString *)numericalValueOne With:(NSString *)numericalValueOther;

@end
