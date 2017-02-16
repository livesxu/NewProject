
//http://www.cnblogs.com/gatsbywang/p/5555200.html
//https://github.com/bestswifter/BSBacktraceLogger   BSBacktraceLogger
//采集线程具体信息借助 BSBacktraceLogger --> 同理可替换LXUncaughtExceptionHandler backtrace

#import "PerformanceMonitor.h"
#import "BSBacktraceLogger.h"

@interface PerformanceMonitor ()
{
    CFRunLoopObserverRef observer;
    
    @public
    dispatch_semaphore_t semaphore;
    CFRunLoopActivity activity;
}
@end

@implementation PerformanceMonitor

+ (instancetype)sharedInstance
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        
        _notes = [NSMutableString string];
    }
    return self;
}

static void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    PerformanceMonitor *moniotr = (__bridge PerformanceMonitor*)info;
    
    moniotr->activity = activity;
    
    dispatch_semaphore_t semaphore = moniotr->semaphore;
    dispatch_semaphore_signal(semaphore);
}

- (void)stop
{
    if (!observer)
        return;
    
    CFRunLoopRemoveObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
    CFRelease(observer);
    observer = NULL;
}

- (void)start
{
    if (observer)
        return;
    
    // 信号
    semaphore = dispatch_semaphore_create(0);
    
    // 注册RunLoop状态观察
    CFRunLoopObserverContext context = {0,(__bridge void*)self,NULL,NULL};
    observer = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                       kCFRunLoopAllActivities,
                                       YES,
                                       0,
                                       &runLoopObserverCallBack,
                                       &context);
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
    
    // 在子线程监控时长
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (YES)
        {
            //延时100ms判定卡顿
            long st = dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, 100*NSEC_PER_MSEC));
            if (st != 0)
            {
                if (!observer)
                {
                    semaphore = 0;
                    activity = 0;
                    return;
                }
                
                if (activity==kCFRunLoopBeforeSources || activity==kCFRunLoopAfterWaiting)
                {
                    //--卡顿采集--
                    
                    NSString *mainBackTrace = [BSBacktraceLogger bs_backtraceOfMainThread];
                    
                    [[PerformanceMonitor sharedInstance].notes appendFormat:@"\nNote:-->\n%@\n",mainBackTrace.length > 800 ? [mainBackTrace substringToIndex:800] : mainBackTrace];//截取前面的堆栈信息，后面舍弃
                    
                    
                }
            }
        }
    });
}

@end
