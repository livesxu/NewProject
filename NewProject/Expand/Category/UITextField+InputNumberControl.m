//
//  UITextField+InputNumberControl.m
//  XiaoLiuFisheries
//
//  Created by Livespro on 2016/10/18.
//  Copyright © 2016年 福中集团软件公司. All rights reserved.
//

#import "UITextField+InputNumberControl.h"

@implementation UITextField (InputNumberControl)

+(void)apply:(UITextField *)tfUsed inputMax:(CGFloat)maxNumber DecimalPointLater:(NSInteger)pointNumber;{
    
    tfUsed.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    tfUsed.returnKeyType=UIReturnKeyDone;
    
    [[tfUsed rac_signalForControlEvents:(UIControlEventEditingChanged)] subscribeNext:^(id x) {
        
        NSString *usedSto=tfUsed.text;
        
        NSRegularExpression *regularPrice=[[NSRegularExpression alloc]initWithPattern:@"[^\\d^\\.]*" options:0 error:nil];
        
        NSString *newTextPrice=[regularPrice stringByReplacingMatchesInString:AvailableString(usedSto) options:0 range:NSMakeRange(0,usedSto.length) withTemplate:@""];
        usedSto=newTextPrice;
        
        if ([newTextPrice containsString:@"."]) {
            NSInteger location=[newTextPrice rangeOfString:@"."].location;
            
            NSInteger more= newTextPrice.length-location > pointNumber+1 ? pointNumber+1 : newTextPrice.length-location;
            
            usedSto= [newTextPrice substringWithRange:NSMakeRange(0, location +more)];
            
            NSString *decimal=[newTextPrice substringWithRange:NSMakeRange(location+1, more-1)];
            
            if ([decimal containsString:@"."]) {
                
                usedSto=[usedSto substringWithRange:NSMakeRange(0, location +1 +[decimal rangeOfString:@"."].location)];
                
            }
        }
        
        if (usedSto.length >=2) {//不许前面存在两个0,0后面跟的不是.删掉0
            
            if ([[usedSto substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"00"] || ([[usedSto substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"0"] && ![[usedSto substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"."])) {
                
                usedSto=[usedSto substringWithRange:NSMakeRange(1,usedSto.length-1)];
                
            }
            
        }
        
        if ([usedSto isEqualToString:@"."]) {//只输入.在前面添上0
            
            usedSto=@"0.";
        }
        
        if (usedSto.floatValue >= maxNumber) {
            
            NSString *strControl=[NSString stringWithFormat:@"%%.%ldf",pointNumber];
            
            usedSto=[NSString stringWithFormat:strControl,maxNumber-1/pow(10, pointNumber)];
        }
        
        tfUsed.text=usedSto;
    }];
    
    [[tfUsed rac_signalForControlEvents:(UIControlEventEditingDidEndOnExit)] subscribeNext:^(id x) {
        
        [tfUsed resignFirstResponder];
    }];
}


+(void)apply:(UITextField *)tfUsed inputIntegerMax:(NSInteger)maxNumber;{
    
    tfUsed.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    tfUsed.returnKeyType=UIReturnKeyDone;

    [[tfUsed rac_signalForControlEvents:(UIControlEventEditingChanged)] subscribeNext:^(id x) {
     
        //正则截掉所有非数字的东西
        NSRegularExpression *regular=[[NSRegularExpression alloc]initWithPattern:@"(\\D)*" options:0 error:nil];
        
        NSString *newText=[regular stringByReplacingMatchesInString:AvailableString(tfUsed.text) options:0 range:NSMakeRange(0,tfUsed.text.length) withTemplate:@""];
        tfUsed.text=newText;
        
        if (newText.length && [newText substringWithRange:NSMakeRange(1, newText.length-1)].integerValue ==newText.integerValue) {
            tfUsed.text=[newText substringWithRange:NSMakeRange(1, newText.length-1)];
        }
        
        if (tfUsed.text.integerValue >= maxNumber) {
            
            tfUsed.text=[NSString stringWithFormat:@"%ld",maxNumber-1];
        }

    }];
    
    [[tfUsed rac_signalForControlEvents:(UIControlEventEditingDidEndOnExit)] subscribeNext:^(id x) {
        
        [tfUsed resignFirstResponder];
    }];
   
}

+(void)apply:(UITextField *)tfUsed inputLengthMax:(NSInteger)maxNumber;{
    
    tfUsed.returnKeyType=UIReturnKeyDone;
    
    [[tfUsed rac_signalForControlEvents:(UIControlEventEditingChanged)] subscribeNext:^(id x) {
        
        if (tfUsed.text.length > maxNumber) {
            tfUsed.text=[tfUsed.text substringWithRange:NSMakeRange(0,maxNumber)];
        }
    }];
    
    [[tfUsed rac_signalForControlEvents:(UIControlEventEditingDidEndOnExit)] subscribeNext:^(id x) {
        
        [tfUsed resignFirstResponder];
    }];
  
}

@end
