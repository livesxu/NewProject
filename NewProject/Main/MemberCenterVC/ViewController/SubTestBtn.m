//
//  SubTestBtn.m
//  NewProject
//
//  Created by Livespro on 2016/12/20.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import "SubTestBtn.h"

@implementation SubTestBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if ([self.delegate respondsToSelector:@selector(testPrintfSome)]) {
        
         [self.delegate testPrintfSome];
    }
}


@end
