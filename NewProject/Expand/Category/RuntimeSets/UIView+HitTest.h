
//点击区域扩展 And 越区域点击响应

#import <UIKit/UIKit.h>

@interface UIView (HitTest)

@property (nonatomic) UIEdgeInsets hitTestEdgeInsets;//可接受点击的偏移区域 top, left, bottom, right

@property (nonatomic) BOOL isOverStepTouch;//子视图是否可越区域接受点击事件

@end
