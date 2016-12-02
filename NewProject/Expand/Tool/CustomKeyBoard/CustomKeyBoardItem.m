//
//  CustomKeyBoardItem.m
//  InitKeyBoard_dome
//
//  Created by Livespro on 2016/11/10.
//  Copyright © 2016年 lf. All rights reserved.
//

#import "CustomKeyBoardItem.h"

@implementation CustomKeyBoardItem

-(instancetype)initWithFrame:(CGRect)frame Image:(NSString *)imageName Text:(NSString *)text RightLine:(BOOL)isRightShow tagSign:(NSInteger)tagSign ItemClick:(ItemClick)itemClick;{
    
    self=[super initWithFrame:frame];
    if (self) {
        
        if (imageName) {
            
            [self addSubview:self.contentImage];
            _contentImage.image=[UIImage imageNamed:imageName];
        }
        
        if (text) {
            
            [self addSubview:self.contentLabel];
            _contentLabel.text=text;
            
        }
        [self addSubview:self.lineTop];
        
        if (isRightShow) {
            
            [self addSubview:self.lineRight];
        }
        
        self.tagSign=tagSign;
        
        _itemClick=itemClick;
        
    }
    return self;
}

-(UIImageView *)contentImage{
    if (!_contentImage) {
       
        _contentImage=[[UIImageView alloc]initWithFrame:CGRectMake((self.bounds.size.width -32)/2, (self.bounds.size.height -32)/2, 32, 32)];
        
    }
    return _contentImage;
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        
        _contentLabel=[[UILabel alloc]initWithFrame:self.bounds];
        _contentLabel.textAlignment=NSTextAlignmentCenter;
        _contentLabel.font=[UIFont systemFontOfSize:24];
        
    }
    return _contentLabel;
}

-(UIView *)lineTop{
    if (!_lineTop) {
        
        _lineTop=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, .3f)];
        _lineTop.backgroundColor=[UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:.8];
        
    }
    return _lineTop;
}

-(UIView *)lineRight{
    if (!_lineRight) {
        
        _lineRight=[[UIView alloc]initWithFrame:CGRectMake(self.bounds.size.width -.3f, 0, .3, self.bounds.size.height)];
        _lineRight.backgroundColor=[UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:.8];
        
    }
    return _lineRight;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.itemClick) {
        
        self.itemClick(_tagSign);
    }
}

@end
