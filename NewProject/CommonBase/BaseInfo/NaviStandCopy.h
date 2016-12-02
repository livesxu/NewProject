//
//  NaviStandCopy.h
//  NewProject
//
//  Created by Livespro on 16/10/11.
//  Copyright © 2016年 FZ. All rights reserved.
//


#import <UIKit/UIKit.h>

#define kNaviItemsSpace 5  //item间隔
#define kNaviItemEdgeSpace 10  //item边距

typedef void(^NaviItemsAction)(NSInteger rightItemIndex);

@interface NaviStandCopy : UIView

@property(nonatomic,strong) UILabel *titleLabel;

@property(nonatomic,strong) NSMutableArray *leftButtons;

@property(nonatomic,strong) NSMutableArray *rightButtons;

@property(nonatomic,copy) NaviItemsAction itemsAction;

@property (nonatomic,copy) NSString *title;

-(instancetype)initWithTitle:(NSString *)title;

-(void)addNaviBarItemFrame:(CGRect)frame New:(UIButton *)itemBtn;

@end
