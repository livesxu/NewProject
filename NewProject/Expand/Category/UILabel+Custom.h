//
//  UILabel+Custom.h
//  XiaoLiuRetail
//
//  Created by MacBook pro on 16/4/20.
//  Copyright © 2016年 福中. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Custom)

+(UILabel *)labelWithText:(NSString *)text TextFont:(CGFloat)font TextColor:(UIColor *)color Frame:(CGRect)frame NumberOfLines:(NSInteger)line;

+(UILabel *)labelWithText:(NSString *)text TextFont:(CGFloat)font TextColor:(UIColor *)color Frame:(CGRect)frame NumberOfLines:(NSInteger)line TextAlignment:(NSTextAlignment)ali BackgroundColor:(UIColor *)bColor;

-(void)configureWithText:(NSString *)text TextColor:(UIColor *)color TextFont:(CGFloat)font NumberOfLines:(NSInteger)line;

-(instancetype)initWithDic:(NSDictionary *)configContent;

-(void)configureInDic:(NSDictionary *)configContent;

+(UILabel *)labelWithDic:(NSDictionary *)configContent;

@end
