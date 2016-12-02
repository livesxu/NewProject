//
//  MainTabItem.m
//  NewProject
//
//  Created by Livespro on 16/10/10.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import "MainTabItem.h"

@implementation MainTabItem

-(instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title NomalColor:(UIColor *)nomalColor SelectedColor:(UIColor *)selectedColor NomalImg:(NSString *)nomalImgName SelectedImg:(NSString *)selectedImgName Tag:(NSInteger)tagSign MainItemAction:(MainItemAction)itemAction;{
    if ([super initWithFrame:frame]) {
        
        _mainItemAction=itemAction;
        _tag_sign=tagSign;
        _nomalColor = nomalColor;
        _selectedColor = selectedColor;
        
        _imgItem=[UIButton buttonWithType:UIButtonTypeCustom];
        _imgItem.frame=CGRectMake(0, 0, self.frame.size.width, 49 *2/3);
        [_imgItem setImage:[UIImage imageNamed:nomalImgName] forState:UIControlStateNormal];
        [_imgItem setImage:[UIImage imageNamed:selectedImgName] forState:UIControlStateSelected];
        _imgItem.userInteractionEnabled=NO;
        [self addSubview:_imgItem];
        
        _lableItem=[[UILabel alloc]initWithFrame:CGRectMake(0, 49 *2/3, self.frame.size.width, 49/3)];
        _lableItem.textAlignment=NSTextAlignmentCenter;
        _lableItem.font=[UIFont systemFontOfSize:12];
        _lableItem.text=title;
        _lableItem.textColor = nomalColor;
        [self addSubview:_lableItem];
    }
    return self;
}

-(void)setIsBeSelected:(BOOL)isBeSelected{
    _isBeSelected = isBeSelected;
    
    _imgItem.selected = _isBeSelected;
    
    _lableItem.textColor = _isBeSelected ? _selectedColor : _nomalColor;
}

//点击回调
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.mainItemAction) {
        
        self.mainItemAction();
    }
}

@end
