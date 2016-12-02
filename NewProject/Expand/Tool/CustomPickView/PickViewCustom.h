//
//  PickViewCustom.h
//  TESTTF
//
//  Created by Livespro on 2016/11/10.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerCustomModel.h"

#define KScreenPickViewWidth [UIScreen mainScreen].bounds.size.width
#define KScreenPickViewHeight 250
#define KScreenPickViewToolHeight 40
#define KTopButtonWidth 40
#define KTopItemSpace 10
#define KTopItemColor [UIColor colorWithRed:16/255.0f green:142/255.0f blue:233/255.0f alpha:1]

typedef void(^PickBackData)(NSArray *dataBack,BOOL onlyBack);

typedef NS_ENUM(NSInteger, CustomPickerSourceType) {
    CustomPickerSourceTypeAlone = 0,//独立数据，无关联
    CustomPickerSourceTypeChain,//链式数据
    
};

@interface PickViewCustom : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong) UIPickerView *pickView;

@property(nonatomic,strong) UIView *topView;

@property(nonatomic,strong) UILabel *titleLabel;

@property(nonatomic,strong) NSArray *dataSource;

@property(nonatomic,assign) CustomPickerSourceType sourceType;

@property(nonatomic,assign) NSInteger componentNum;

@property(nonatomic,strong) NSMutableArray *waySto;

@property(nonatomic,copy) PickBackData backData;

-(instancetype)initWithFrame:(CGRect)frame DataSource:(NSArray *)dataSource SourceType:(CustomPickerSourceType)sourceType Group:(NSInteger)groupNum;

@end
