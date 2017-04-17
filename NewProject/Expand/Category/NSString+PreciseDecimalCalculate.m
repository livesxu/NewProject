//
//  NSString+PreciseDecimalCalculate.m
//  XiaoLiuFisheries
//
//  Created by Livespro on 2016/10/19.
//  Copyright © 2016年 福中集团软件公司. All rights reserved.
//

#import "NSString+PreciseDecimalCalculate.h"

@implementation NSString (PreciseDecimalCalculate)

+(NSString *)addCalculate:(NSString *)numericalValueOne With:(NSString *)numericalValueOther;{
    
    if (!numericalValueOne || [numericalValueOne isEqualToString:@"(null)"] || !numericalValueOther || [numericalValueOther isEqualToString:@"(null)"]) {
        
        return @"0";
    }
    NSDecimalNumber *valueOne = [NSDecimalNumber decimalNumberWithString:numericalValueOne];
    NSDecimalNumber *valueOther = [NSDecimalNumber decimalNumberWithString:numericalValueOther];
    
    return [NSString stringWithFormat:@"%@",[valueOne decimalNumberByAdding:valueOther]];
}

+(NSString *)subtractCalculate:(NSString *)numericalValueOne With:(NSString *)numericalValueOther;{
    
    if (!numericalValueOne || [numericalValueOne isEqualToString:@"(null)"] || !numericalValueOther || [numericalValueOther isEqualToString:@"(null)"]) {
        
        return @"0";
    }
    NSDecimalNumber *valueOne = [NSDecimalNumber decimalNumberWithString:numericalValueOne];
    NSDecimalNumber *valueOther = [NSDecimalNumber decimalNumberWithString:numericalValueOther];
    
    return [NSString stringWithFormat:@"%@",[valueOne decimalNumberBySubtracting:valueOther]];
}

+(NSString *)multiplyCalculate:(NSString *)numericalValueOne With:(NSString *)numericalValueOther;{
    
    if (!numericalValueOne || [numericalValueOne isEqualToString:@"(null)"] || !numericalValueOther || [numericalValueOther isEqualToString:@"(null)"]) {
        
        return @"0";
    }
    NSDecimalNumber *valueOne = [NSDecimalNumber decimalNumberWithString:numericalValueOne];
    NSDecimalNumber *valueOther = [NSDecimalNumber decimalNumberWithString:numericalValueOther];
    
    return [NSString stringWithFormat:@"%@",[valueOne decimalNumberByMultiplyingBy:valueOther]];
}

+(NSString *)divideCalculate:(NSString *)numericalValueOne With:(NSString *)numericalValueOther;{
    
    if (!numericalValueOne || [numericalValueOne isEqualToString:@"(null)"] || !numericalValueOther || [numericalValueOther isEqualToString:@"(null)"]) {
        
        return @"0";
    }
    NSDecimalNumber *valueOne = [NSDecimalNumber decimalNumberWithString:numericalValueOne];
    NSDecimalNumber *valueOther = [NSDecimalNumber decimalNumberWithString:numericalValueOther];
    
    return [NSString stringWithFormat:@"%@",[valueOne decimalNumberByDividingBy:valueOther]];
}

@end
