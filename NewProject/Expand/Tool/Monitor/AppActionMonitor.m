//
//  AppActionMonitor.m
//  NewProject
//
//  Created by Livespro on 2016/12/20.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import "AppActionMonitor.h"

@implementation AppActionMonitor

+(instancetype)shareAppMonitor;{
    
    static AppActionMonitor *appMonitor=nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appMonitor=[[AppActionMonitor alloc]init];
    });
    
    return appMonitor;
    
}

-(void)footPrint:(NSString *)foot;{
    if (!_monitorContent) {
        _monitorContent = [NSMutableString string];
    }
    
    [self.monitorContent appendString:foot];
    
}

-(void)activityPrint:(NSString *)action;{
    
    if (!_actorContent) {
        _actorContent = [NSMutableString string];
    }
    
    [self.actorContent appendString:action];
}

////操作足迹,得到用户操作的流程
//-(NSString *)actionContent;{
//    
//    //正则截掉所有非数字的东西
//    NSRegularExpression *regularAction=[[NSRegularExpression alloc]initWithPattern:@"-<ActionMonitor>-[^[<>]]*-<ActionMonitor>-" options:0 error:nil];
//    
//    NSArray *matchResult = [regularAction matchesInString:_monitorContent options:0 range:NSMakeRange(0, _monitorContent.length)];
//    
//    NSMutableString *strSto = [NSMutableString string];
//    [strSto appendString:@"\n"];
//    for (NSInteger i =0; i < matchResult.count; i++) {
//        
//        NSTextCheckingResult *rangeValue = matchResult[i];
//        [strSto appendString:[_monitorContent substringWithRange:rangeValue.range]];
//        [strSto appendString:@"\n"];
//        
//    }
//    return strSto;
//}

//翻译足迹,将方法、控制器、事件 对应翻译,方便查看
-(NSString *)translateContent:(NSMutableString *)content;{
    
    NSDictionary *translateDic = @{
                                   @"LXGuideAndLaunch" :@"导航和引导",
                                   
                                   };
    
    for (NSString *key in translateDic) {
        
        [content replaceOccurrencesOfString:key withString:translateDic[key] options:NSRegularExpressionSearch range:NSMakeRange(0, content.length)];
        
    }
    
    return content;
}

@end
