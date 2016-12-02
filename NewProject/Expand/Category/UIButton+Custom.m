//
//  UIButton+Custom.m
//  XiaoLiuRetail
//
//  Created by imac on 15/11/16.
//  Copyright © 2015年 福中. All rights reserved.
//

#import "UIButton+Custom.h"
#import "UIColor+Turn.h"

#import <objc/runtime.h>

@implementation UIButton (Custom)

+(UIButton *)buttonWithNomalBackgroundImage:(NSString *)imageName Frame:(CGRect)rect Target:(id)target Selector:(SEL)selector;{
    
    UIButton *button=[[UIButton alloc]initWithFrame:rect];
    
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
  
    return button;
}

+(UIButton *)buttonWithCustomTypeAndNomalStateTitle:(NSString *)title TitleFont:(CGFloat)font TitleColor:(UIColor *)tc BackgroundColor:(UIColor *)color Frame:(CGRect)frame Image:(NSString *)imageName;{
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    button.titleLabel.font=[UIFont systemFontOfSize:font];
    if (tc) {
        
       [button setTitleColor:tc forState:UIControlStateNormal];
    }
    if (color) {
        
        button.backgroundColor=color;
    }
    button.frame=frame;
    
    if (imageName) {
        
       [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
//    button.syy_timeInterval=1.0f;
    
    return button;
}

+(UIButton *)buttonWithCustomTypeNomalImage:(NSString *)imageName Frame:(CGRect)frame;{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    button.frame=frame;
    
    return button;
    
}
+(UIButton *)buttonTopCoupon:(NSString *)title target:(id)target selector:(SEL)sel;{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:@"008aea"] forState:UIControlStateSelected];
    btn.titleLabel.font=[UIFont systemFontOfSize:14];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor=[UIColor whiteColor];
    
    return btn;
}

+(UIButton *)buttonWithFrame:(CGRect)frame BackgroundColor:(UIColor *)bColor Title:(NSString *)title TitleColor:(UIColor *)tColor TitleFont:(CGFloat)font Target:(id)target Selector:(SEL)selector;{
    
    UIButton *button=[[UIButton alloc]initWithFrame:frame];
    if (bColor) {
        
       button.backgroundColor=bColor;
    }
    if (title) {
        
       [button setTitle:title forState:UIControlStateNormal];
    }
    if (tColor) {
        
       [button setTitleColor:tColor forState:UIControlStateNormal];
    }
    if (font) {
        
        button.titleLabel.font=[UIFont systemFontOfSize:font];
    }
    
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    
    return button;
}

-(instancetype)initWithDic:(NSDictionary *)configContent Target:(id)target Selector:(SEL)selector;{
    if ([super init]) {
        
        [self configureInDic:configContent Target:target Selector:selector];
        
    }
    return self;
}

-(void)configureInDic:(NSDictionary *)configContent Target:(id)target Selector:(SEL)selector;{
    //font
    if ([configContent objectForKey:@"font"] && [[configContent objectForKey:@"font"] isKindOfClass:[UIFont class]]) {
        
        self.titleLabel.font=[configContent objectForKey:@"font"];
    }
    //textColor---normal
    if ([configContent objectForKey:@"textColor"] && [[configContent objectForKey:@"textColor"] isKindOfClass:[UIColor class]]) {
        
        [self setTitleColor:[configContent objectForKey:@"textColor"] forState:UIControlStateNormal];
    }
    //textColor---selected
    if ([configContent objectForKey:@"textColorSelected"] && [[configContent objectForKey:@"textColorSelected"] isKindOfClass:[UIColor class]]) {
        
        [self setTitleColor:[configContent objectForKey:@"textColorSelected"] forState:UIControlStateSelected];
    }
    //backgroundColor
    if ([configContent objectForKey:@"backgroundColor"] && [[configContent objectForKey:@"backgroundColor"] isKindOfClass:[UIColor class]]) {
        
        self.backgroundColor=[configContent objectForKey:@"backgroundColor"];
    }
    //text---normal
    if ([configContent objectForKey:@"text"] && [[configContent objectForKey:@"text"] isKindOfClass:[NSString class]]) {
        
        [self setTitle:[configContent objectForKey:@"text"] forState:UIControlStateNormal];
    }
    //text---selected
    if ([configContent objectForKey:@"textSelected"] && [[configContent objectForKey:@"textSelected"] isKindOfClass:[NSString class]]) {
        
        [self setTitle:[configContent objectForKey:@"textSelected"] forState:UIControlStateSelected];
    }
    //image---normal
    if ([configContent objectForKey:@"image"] && [[configContent objectForKey:@"image"] isKindOfClass:[UIImage class]]) {
        
        [self setImage:[configContent objectForKey:@"image"] forState:UIControlStateNormal];
    }
    //image---selected
    if ([configContent objectForKey:@"imageSelected"] && [[configContent objectForKey:@"imageSelected"] isKindOfClass:[UIImage class]]) {
        
        [self setImage:[configContent objectForKey:@"imageSelected"] forState:UIControlStateSelected];
    }
    //titleEdgeInsets
    if ([configContent objectForKey:@"titleEdgeInsets"] && [[configContent objectForKey:@"titleEdgeInsets"] isKindOfClass:[NSValue class]]) {
        
        NSValue *edgeInsetsValue=[configContent objectForKey:@"titleEdgeInsets"];
        self.titleEdgeInsets=edgeInsetsValue.UIEdgeInsetsValue;
    }
    //imageEdgeInsets
    if ([configContent objectForKey:@"imageEdgeInsets"] && [[configContent objectForKey:@"imageEdgeInsets"] isKindOfClass:[NSValue class]]) {
        NSValue *edgeInsetsValue=[configContent objectForKey:@"titleEdgeInsets"];
        self.imageEdgeInsets=edgeInsetsValue.UIEdgeInsetsValue;
        
    }
    //tintColor
    if ([configContent objectForKey:@"tintColor"] && [[configContent objectForKey:@"tintColor"] isKindOfClass:[UIColor class]]) {
        
        self.tintColor=[configContent objectForKey:@"tintColor"];
    }
    //frame
    if ([configContent objectForKey:@"frame"] && [[configContent objectForKey:@"frame"] isKindOfClass:[NSValue class]]) {
        
        NSValue *frameValue=[configContent objectForKey:@"frame"];
        self.frame=frameValue.CGRectValue;
    }
    
    [self addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];

}

+(UIButton *)buttonWithDic:(NSDictionary *)configContent Target:(id)target Selector:(SEL)selector;{
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button configureInDic:configContent Target:target Selector:selector];
    
    return button;
    
}

@end
