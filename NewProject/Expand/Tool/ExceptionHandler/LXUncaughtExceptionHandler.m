
//

#import "LXUncaughtExceptionHandler.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIDevice.h>
#import "AlertBlockCustom.h"

NSString * const LXUncaughtExceptionHandlerSignalExceptionName = @"LXUncaughtExceptionHandlerSignalExceptionName";
NSString * const LXUncaughtExceptionHandlerSignalKey = @"LXUncaughtExceptionHandlerSignalKey";
NSString * const LXUncaughtExceptionHandlerAddressesKey = @"LXUncaughtExceptionHandlerAddressesKey";

volatile int32_t LXUncaughtExceptionCount = 0;
const int32_t LXUncaughtExceptionMaximum = 10;

const NSInteger LXUncaughtExceptionHandlerSkipAddressCount = 4;
const NSInteger LXUncaughtExceptionHandlerReportAddressCount = 5;

@interface LXUncaughtExceptionHandler ()

@property(nonatomic,assign) BOOL canDismiss;

@end

@implementation LXUncaughtExceptionHandler

+ (NSArray *)backtrace
{
    void* callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);
    
    int i;
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (
         i = LXUncaughtExceptionHandlerSkipAddressCount;
         i < LXUncaughtExceptionHandlerSkipAddressCount +
         LXUncaughtExceptionHandlerReportAddressCount;
         i++)
    {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    
    return backtrace;
}

-(NSMutableDictionary *)otherInfoGet{
    
    NSMutableDictionary *log = [[NSMutableDictionary alloc]init];
    
    //Time info
    NSDate *date = [NSDate date]; // 获得时间对象
    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    NSTimeInterval time = [zone secondsFromGMTForDate:date];// 以秒为单位返回当前时间与系统格林尼治时间的差
    NSDate *dateNow = [date dateByAddingTimeInterval:time];// 然后把差的时间加上,就是当前系统准确的时间
    [log setObject:dateNow forKey:@"date"];
    
    // Device info
    [log setObject:iphoneTypeGet() forKey:@"device"];
    [log setObject:[UIDevice currentDevice].name forKey:@"deviceName"];
    [log setObject:[UIDevice currentDevice].systemVersion forKey:@"osversion"];
    
    // batteryLevel(电量) info
    [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
    [log setObject:[NSNumber numberWithFloat:[UIDevice currentDevice].batteryLevel*100] forKey:@"batteryLevel"];
    [[UIDevice currentDevice] setBatteryMonitoringEnabled:NO];
        
    // Network info
    [log setObject:NetworkingStatesFromStatebar() forKey:@"networkInfo"];
    
    //monitor(操作跟踪)
    [log setObject:[AppActionMonitor shareAppMonitor].monitorContent  forKey:@"monitor"];

    return log;

}

//错误处理
- (void)handleException:(NSException *)exception
{
    // exception info
    NSArray *errorInfo = [[exception userInfo] objectForKey:LXUncaughtExceptionHandlerAddressesKey];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    
    NSMutableDictionary *log = [self otherInfoGet];
    
    [log setObject:name forKey:@"BUG Name"];
    [log setObject:reason forKey:@"BUG Reason"];
    [log setObject:errorInfo forKey:@"BUG ErrorInfo"];
    
#pragma mark - 此时的log是完整的崩溃信息,采取写文件，上传，展示等操作...
    
    AlertBlockCustom *alert = [[AlertBlockCustom alloc]initWithTitle:@"抱歉,程序出现异常" message:[NSString stringWithFormat:                                              @"%@",log] cancelButtonTitle:@"暂不执行此操作" clickBlockAction:^(AlertBlockCustom *alertView, NSInteger buttonIndex) {
        
        if (buttonIndex == 1) {
            
            _canDismiss = YES;
        }
        
    } otherButtonTitles:@"继续", nil];
    
    [alert show];
    
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
    
    while (!_canDismiss)
    {
        for (NSString *mode in (__bridge  NSArray *)allModes)
        {
            CFRunLoopRunInMode((__bridge CFStringRef)mode, 0.001, false);
        }
    }
    
    CFRelease(allModes);
    
    NSSetUncaughtExceptionHandler(NULL);
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
    
    if ([[exception name] isEqual:LXUncaughtExceptionHandlerSignalExceptionName])
    {
        kill(getpid(), [[[exception userInfo] objectForKey:LXUncaughtExceptionHandlerSignalKey] intValue]);
    }
    else
    {
        [exception raise];
    }
}

@end

void HandleException(NSException *exception)
{
//    int32_t exceptionCount = OSAtomicIncrement32(&LXUncaughtExceptionCount);
//    if (exceptionCount > LXUncaughtExceptionMaximum)
//    {
//        return;
//    }
//    
//    NSArray *callStack = [LXUncaughtExceptionHandler backtrace];
     NSArray *callStack = [exception callStackSymbols];//得到当前调用栈信息
    NSMutableDictionary *userInfo =
    [NSMutableDictionary dictionaryWithDictionary:[exception userInfo]];
    [userInfo
     setObject:callStack
     forKey:LXUncaughtExceptionHandlerAddressesKey];
    
    [[[LXUncaughtExceptionHandler alloc] init]
     performSelectorOnMainThread:@selector(handleException:)
     withObject:
     [NSException
      exceptionWithName:[exception name]
      reason:[exception reason]
      userInfo:userInfo]
     waitUntilDone:YES];
}

void SignalHandler(int signal)
{
    int32_t exceptionCount = OSAtomicIncrement32(&LXUncaughtExceptionCount);
    if (exceptionCount > LXUncaughtExceptionMaximum)
    {
        return;
    }
    
    NSMutableDictionary *userInfo =
    [NSMutableDictionary
     dictionaryWithObject:[NSNumber numberWithInt:signal]
     forKey:LXUncaughtExceptionHandlerSignalKey];
    
    NSArray *callStack = [LXUncaughtExceptionHandler backtrace];
    [userInfo
     setObject:callStack
     forKey:LXUncaughtExceptionHandlerAddressesKey];
    
    [[[LXUncaughtExceptionHandler alloc] init]
     performSelectorOnMainThread:@selector(handleException:)
     withObject:
     [NSException
      exceptionWithName:LXUncaughtExceptionHandlerSignalExceptionName
      reason:
      [NSString stringWithFormat:
       NSLocalizedString(@"Signal %d was raised.", nil),
       signal]
      userInfo:
      [NSDictionary
       dictionaryWithObject:[NSNumber numberWithInt:signal]
       forKey:LXUncaughtExceptionHandlerSignalKey]]
     waitUntilDone:YES];
}

//begain
void LXInstallUncaughtExceptionHandler(void)
{
    NSSetUncaughtExceptionHandler(&HandleException);
    signal(SIGABRT, SignalHandler);
    signal(SIGILL, SignalHandler);
    signal(SIGSEGV, SignalHandler);
    signal(SIGFPE, SignalHandler);
    signal(SIGBUS, SignalHandler);
    signal(SIGPIPE, SignalHandler);
}
