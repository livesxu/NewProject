//
//  UIControl+syyExtsion.h
//  XiaoLiuRetail
//
//  Created by 束永永 on 16/4/12.
//  Copyright © 2016年 福中. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (SYYCategory)

//  点击间隔，防止重复点击,直接设置时间即可
@property (nonatomic, assign) NSTimeInterval syy_timeInterval;

@end
