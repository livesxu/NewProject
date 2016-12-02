
//  

#import "BaseModel.h"
#import <objc/runtime.h>

@implementation BaseModel

- (NSString *)description {
    
    NSMutableString *mutStr = [NSMutableString string];
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *name = @(property_getName(property));
        NSString *value = [self valueForKeyPath:name];
        [mutStr appendFormat:@"%@:%@;", name, value];
    }
    return mutStr;
}

@end
