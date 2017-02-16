
//卡顿监测

#import <Foundation/Foundation.h>

@interface PerformanceMonitor : NSObject

@property (nonatomic,copy) NSMutableString *notes;//记录

+ (instancetype)sharedInstance;

- (void)start;
- (void)stop;

@end
