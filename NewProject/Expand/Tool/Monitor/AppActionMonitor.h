
//操作足迹监测

#import <Foundation/Foundation.h>

@interface AppActionMonitor : NSObject

+(instancetype)shareAppMonitor;

@property (nonatomic,copy) NSMutableString *monitorContent;//完整足迹

@property (nonatomic,copy) NSMutableString *actorContent;//动作足迹

//添加足迹
-(void)footPrint:(NSString *)foot;

//操作足迹,得到用户操作的流程
//-(NSString *)actionContent;//取消,采用双重记录
-(void)activityPrint:(NSString *)action;

//翻译足迹,将方法、控制器、事件 对应翻译,方便查看
-(NSString *)translateContent:(NSString *)content;

@end
