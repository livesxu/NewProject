//
//  UIButton+Custom.h
//  XiaoLiuRetail
//
//  Created by imac on 15/11/16.
//  Copyright © 2015年 福中. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Custom)


+(UIButton *)buttonWithNomalBackgroundImage:(NSString *)imageName Frame:(CGRect)rect Target:(id)target Selector:(SEL)selector;//创建导航栏上按钮

+(UIButton *)buttonWithCustomTypeAndNomalStateTitle:(NSString *)title TitleFont:(CGFloat)font TitleColor:(UIColor *)tc BackgroundColor:(UIColor *)color Frame:(CGRect)frame Image:(NSString *)imageName;//detailBottom按钮

+(UIButton *)buttonWithCustomTypeNomalImage:(NSString *)imageName Frame:(CGRect)frame;//设置一张背景nomal图片的button

//普通button
+(UIButton *)buttonWithFrame:(CGRect)frame BackgroundColor:(UIColor *)bColor Title:(NSString *)title TitleColor:(UIColor *)tColor TitleFont:(CGFloat)font Target:(id)target Selector:(SEL)selector;

+(UIButton *)buttonTopCoupon:(NSString *)title target:(id)target selector:(SEL)sel;

-(instancetype)initWithDic:(NSDictionary *)configContent Target:(id)target Selector:(SEL)selector;

-(void)configureInDic:(NSDictionary *)configContent Target:(id)target Selector:(SEL)selector;

+(UIButton *)buttonWithDic:(NSDictionary *)configContent Target:(id)target Selector:(SEL)selector;


@end
