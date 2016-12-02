//
//  KeyBoardCustom.m
//  InitKeyBoard_dome
//
//  Created by Livespro on 2016/11/10.
//  Copyright © 2016年 lf. All rights reserved.
//

#import "KeyBoardCustom.h"
#import "CustomKeyBoardItem.h"

#define KScreenKeyBoardNumberItemWidth [UIScreen mainScreen].bounds.size.width/4
#define KScreenKeyBoardNumberItemHeight 50


@interface KeyBoardCustom ()

@end

@implementation KeyBoardCustom


-(void)dealloc{
    
    NSLog(@"键盘销毁！！");
}

-(instancetype)initWithType:(CustomKeyBoardType)type TfPass:(UITextField *)tf;{
    self=[super init];
    if (self) {
       
        switch (type) {
            case 0:
                [self numberShowtypeGo:tf];
                break;
                
            default:
                break;
        }
        
    }
    return self;
    
}

+(void)applyTo:(UITextField *)textField Type:(CustomKeyBoardType)type;{
    
    textField.inputView=[[KeyBoardCustom alloc]initWithType:type TfPass:textField];
    [textField reloadInputViews];
    
}

-(void)numberShowtypeGo:(UITextField *)tfPass{
    
    self.backgroundColor = [UIColor whiteColor];
    self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - KScreenKeyBoardNumberItemHeight * 4, KScreenKeyBoardNumberItemWidth * 4, KScreenKeyBoardNumberItemHeight * 4);
    
    __weak UITextField *weakTF=tfPass;
    
    NSArray *numberArr=@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@".",@"0"];
    for (NSInteger i=0; i < numberArr.count; i++) {
        
        CustomKeyBoardItem *itemNumber=[[CustomKeyBoardItem alloc]initWithFrame:CGRectMake(i%3 * KScreenKeyBoardNumberItemWidth, i/3 * KScreenKeyBoardNumberItemHeight, KScreenKeyBoardNumberItemWidth, KScreenKeyBoardNumberItemHeight) Image:nil Text:numberArr[i] RightLine:YES tagSign:i+1 ItemClick:^(NSInteger tagSign) {
           
            NSString *strSto=weakTF.text;
            if (tagSign < 10) {
                
                weakTF.text=[NSString stringWithFormat:@"%@%ld",strSto,tagSign];
                
            } else if(tagSign == 10){
                
                weakTF.text=[NSString stringWithFormat:@"%@.",strSto];
                
            }else if (tagSign == 11){
                
                weakTF.text=[NSString stringWithFormat:@"%@0",strSto];
            }
            
        }];
        
        [self addSubview:itemNumber];
    }
    CustomKeyBoardItem *itemDown=[[CustomKeyBoardItem alloc]initWithFrame:CGRectMake(KScreenKeyBoardNumberItemWidth *2, KScreenKeyBoardNumberItemHeight *3, KScreenKeyBoardNumberItemWidth, KScreenKeyBoardNumberItemHeight) Image:@"keybord_down" Text:nil RightLine:YES tagSign:12 ItemClick:^(NSInteger tagSign) {
        
        [weakTF resignFirstResponder];
    }];
    
    CustomKeyBoardItem *itemBack=[[CustomKeyBoardItem alloc]initWithFrame:CGRectMake(KScreenKeyBoardNumberItemWidth *3, 0, KScreenKeyBoardNumberItemWidth, KScreenKeyBoardNumberItemHeight *2) Image:@"backspace" Text:nil RightLine:NO tagSign:13 ItemClick:^(NSInteger tagSign) {
        
        NSMutableString *muStr = [[NSMutableString alloc] initWithString:weakTF.text];
        if (muStr.length <= 0) {
            return;
        }
        [muStr deleteCharactersInRange:NSMakeRange([muStr length] - 1, 1)];
        weakTF.text = muStr;
    }];
    itemBack.contentImage.frame=CGRectMake((KScreenKeyBoardNumberItemWidth-24)/2, (KScreenKeyBoardNumberItemHeight*2-24)/2, 24, 24);
    
    CustomKeyBoardItem *itemSure=[[CustomKeyBoardItem alloc]initWithFrame:CGRectMake(KScreenKeyBoardNumberItemWidth *3, KScreenKeyBoardNumberItemHeight *2, KScreenKeyBoardNumberItemWidth, KScreenKeyBoardNumberItemHeight *2) Image:nil Text:@"确定" RightLine:NO tagSign:14 ItemClick:^(NSInteger tagSign) {
        
        [weakTF resignFirstResponder];
    }];
    
    itemSure.backgroundColor=[UIColor colorWithRed:16/255.0f green:142/255.0f blue:233/255.0f alpha:1];
    itemSure.contentLabel.textColor=[UIColor whiteColor];
    itemSure.contentLabel.font=[UIFont systemFontOfSize:18];
    
    [self addSubview:itemDown];
    
    [self addSubview:itemBack];
    
    [self addSubview:itemSure];
    
}




@end
