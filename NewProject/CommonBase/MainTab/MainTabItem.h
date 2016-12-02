//
//  MainTabItem.h
//  NewProject
//
//  Created by Livespro on 16/10/10.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MainItemAction)();

@interface MainTabItem : UIView

@property(nonatomic,strong) UIButton *imgItem;

@property(nonatomic,strong) UILabel *lableItem;

@property(nonatomic,strong) UIColor *nomalColor;

@property(nonatomic,strong) UIColor *selectedColor;

@property(nonatomic,assign) BOOL isBeSelected;

@property(nonatomic,assign) NSInteger tag_sign;

@property(nonatomic,copy) MainItemAction mainItemAction;

-(instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title NomalColor:(UIColor *)nomalColor SelectedColor:(UIColor *)selectedColor NomalImg:(NSString *)nomalImgName SelectedImg:(NSString *)selectedImgName Tag:(NSInteger)tagSign MainItemAction:(MainItemAction)itemAction;

@end
