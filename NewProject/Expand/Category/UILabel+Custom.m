//
//  UILabel+Custom.m
//  XiaoLiuRetail
//
//  Created by MacBook pro on 16/4/20.
//  Copyright © 2016年 福中. All rights reserved.
//

#import "UILabel+Custom.h"
#import "UIColor+Turn.h"

@implementation UILabel (Custom)

+(UILabel *)labelWithText:(NSString *)text TextFont:(CGFloat)font TextColor:(UIColor *)color Frame:(CGRect)frame NumberOfLines:(NSInteger)line;{
    
    UILabel *label=[[UILabel alloc]init];
    if (text) {
        
       label.text=text;
    }
    if (font) {
        
       label.font=[UIFont systemFontOfSize:font];
    }
    if (color) {
        
      label.textColor=color;
    }
    
    label.numberOfLines=line;
    
    label.frame=frame;
 
    return label;
}

+(UILabel *)labelWithText:(NSString *)text TextFont:(CGFloat)font TextColor:(UIColor *)color Frame:(CGRect)frame NumberOfLines:(NSInteger)line TextAlignment:(NSTextAlignment)ali BackgroundColor:(UIColor *)bColor;{
    
    UILabel *label=[UILabel labelWithText:text TextFont:font TextColor:color Frame:frame NumberOfLines:line];
    
    label.textAlignment=ali;
    
    if (bColor) {
        
      label.backgroundColor=bColor;
    }
    
    return label;
    
}

-(void)configureWithText:(NSString *)text TextColor:(UIColor *)color TextFont:(CGFloat)font NumberOfLines:(NSInteger)line;{
    
    self.text=text;
    
    self.textColor=color;
    
    self.font=[UIFont systemFontOfSize:font];
    
    self.numberOfLines=line;
    
    
    
}

-(instancetype)initWithDic:(NSDictionary *)configContent;{
    if ([super init]) {
        
        [self configureInDic:configContent];
    }
    return self;
}

-(void)configureInDic:(NSDictionary *)configContent{
    //font
    if ([configContent objectForKey:@"font"] && [[configContent objectForKey:@"font"] isKindOfClass:[UIFont class]]) {
        
        self.font=[configContent objectForKey:@"font"];
    }
    //textColor
    if ([configContent objectForKey:@"textColor"] && [[configContent objectForKey:@"textColor"] isKindOfClass:[UIColor class]]) {
        
        self.textColor=[configContent objectForKey:@"textColor"];
    }
    //backgroundColor
    if ([configContent objectForKey:@"backgroundColor"] && [[configContent objectForKey:@"backgroundColor"] isKindOfClass:[UIColor class]]) {
        
        self.backgroundColor=[configContent objectForKey:@"backgroundColor"];
    }
    //text
    if ([configContent objectForKey:@"text"] && [[configContent objectForKey:@"text"] isKindOfClass:[NSString class]]) {
        
        self.text=[configContent objectForKey:@"text"];
    }
    //numberOfLines
    if ([configContent objectForKey:@"numberOfLines"] && [[configContent objectForKey:@"numberOfLines"] isKindOfClass:[NSNumber class]]) {
        
        NSNumber *numberLine=[configContent objectForKey:@"numberOfLines"];
        self.numberOfLines=numberLine.integerValue;
    }
    //textAlignment
    if ([configContent objectForKey:@"textAlignment"] && [[configContent objectForKey:@"textAlignment"] isKindOfClass:[NSNumber class]]) {
        
        NSNumber *numberLine=[configContent objectForKey:@"textAlignment"];
        self.textAlignment=numberLine.integerValue;
    }
    //frame
    if ([configContent objectForKey:@"frame"] && [[configContent objectForKey:@"frame"] isKindOfClass:[NSValue class]]) {
        
        NSValue *frameValue=[configContent objectForKey:@"frame"];
        self.frame=frameValue.CGRectValue;
    }
}

+(UILabel *)labelWithDic:(NSDictionary *)configContent;{
    
    UILabel *label = [[UILabel alloc]initWithDic:configContent];
    
    return label;
}


@end
