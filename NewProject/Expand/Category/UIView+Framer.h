//
//  UIView+Framer.h
//  NewProject
//
//  Created by Livespro on 2016/12/2.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Framer)

// shortcuts for frame properties
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

// shortcuts for positions
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;


@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat left;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@end
