//
//  NaviStandCopy.m
//  NewProject
//
//  Created by Livespro on 16/10/11.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import "NaviStandCopy.h"

@implementation NaviStandCopy

-(instancetype)initWithTitle:(NSString *)title;{
    
    if ([super init]) {
        
        self.frame=CGRectMake(0, 0, kScreenWidth, 64);
        
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        _titleLabel.font=[UIFont systemFontOfSize:15];
        _titleLabel.backgroundColor=[UIColor clearColor];
        _titleLabel.text=title;
        
        [self addSubview:_titleLabel];
        
    }
    return self;
}

-(void)setTitle:(NSString *)title{
    
    _titleLabel.text=title;
}

-(NSMutableArray *)leftButtons{
    if (!_leftButtons) {
        
        _leftButtons=[NSMutableArray array];
    }
    return _leftButtons;
}

-(NSMutableArray *)rightButtons{
    if (!_rightButtons) {
        
        _rightButtons=[NSMutableArray array];
    }
    return _rightButtons;
}

-(void)addNaviBarItemFrame:(CGRect)frame New:(UIButton *)itemBtn;{
    
    itemBtn.frame=frame;
    [self addSubview:itemBtn];
    
}

-(void)layoutSubviews{
    
    CGFloat widthLeft_Space = kNaviItemEdgeSpace;
    
    for (NSInteger i=0; i < _leftButtons.count; i++) {
        
        UIButton *button=_leftButtons[i];
        
        CGSize buttonSizeSto=button.frame.size;
        
        button.frame=CGRectMake(widthLeft_Space, 20 + (44 - buttonSizeSto.height)/2, buttonSizeSto.width, buttonSizeSto.height);
        
        widthLeft_Space += (buttonSizeSto.width + kNaviItemsSpace);
    }
    
    CGFloat widthRight_Space = kNaviItemEdgeSpace;
    
    for (NSInteger i=0; i < _rightButtons.count; i++) {
        
        UIButton *button=_rightButtons[i];
        
        CGSize buttonSizeSto=button.frame.size;
        
        button.frame=CGRectMake(kScreenWidth - widthRight_Space - buttonSizeSto.width, 20 + (44 - buttonSizeSto.height)/2, buttonSizeSto.width, buttonSizeSto.height);
        
        widthRight_Space += (buttonSizeSto.width + kNaviItemsSpace);
    }
    
    CGFloat widthTitleVacant = widthLeft_Space > widthRight_Space ? widthLeft_Space : widthRight_Space;
    
    _titleLabel.frame=CGRectMake(widthTitleVacant, 20, kScreenWidth - 2*widthTitleVacant, 44);
}

@end
