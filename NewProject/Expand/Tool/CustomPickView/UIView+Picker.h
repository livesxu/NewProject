//

#import <UIKit/UIKit.h>
#import "PickViewCustom.h"

typedef void(^PickData)(NSArray *dataArray);

@interface UIView (Picker)

@property(strong,nonatomic,readwrite) PickViewCustom *inputView;

-(void)pickCategroyDataSource:(NSArray *)dataSource SourceType:(CustomPickerSourceType)sourceType Component:(NSInteger)groupNum PickData:(PickData)pickData;

-(void)changeCategroyPickDataSource:(NSArray *)datasource;

-(void)pickerShow;

@end
