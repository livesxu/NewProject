
//防止数组调用arr[0]崩溃,runtime策略two

#import <Foundation/Foundation.h>

@interface NSArray (Safety)

-(id)objectAtIndexSafe:(NSInteger)index;

@end
