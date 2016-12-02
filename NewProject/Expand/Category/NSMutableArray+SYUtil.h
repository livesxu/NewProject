//
//  NSMutableArray+SYUtil.h
//  XiaoLiuRetail
//
//  Created by imac on 16/1/2.
//  Copyright © 2016年 福中. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (SYUtil)

/*
 检查数组是否越界和NSNull,若是则返回nil
 */
- (id)objectAtIndexCheck:(NSUInteger)index;

@end
