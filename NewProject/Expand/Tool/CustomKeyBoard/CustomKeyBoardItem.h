//
//  CustomKeyBoardItem.h
//  InitKeyBoard_dome
//
//  Created by Livespro on 2016/11/10.
//  Copyright © 2016年 lf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ItemClick)(NSInteger tagSign);

@interface CustomKeyBoardItem : UIView

@property (nonatomic,strong) UIView *lineTop;

@property (nonatomic,strong) UIView *lineRight;

@property (nonatomic,strong) UILabel *contentLabel;

@property (nonatomic,assign) NSInteger tagSign;

@property (nonatomic,strong) UIImageView *contentImage;

@property (nonatomic,copy) ItemClick itemClick;

-(instancetype)initWithFrame:(CGRect)frame Image:(NSString *)imageName Text:(NSString *)text RightLine:(BOOL)isRightShow tagSign:(NSInteger)tagSign ItemClick:(ItemClick)itemClick;

@end
