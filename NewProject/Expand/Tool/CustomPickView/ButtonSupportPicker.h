//
//  ButtonSupportPicker.h
//  TESTTF
//
//  Created by Livespro on 2016/11/10.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickViewCustom.h"

typedef void(^PickData)(NSArray *dataArray);

@interface ButtonSupportPicker : UIButton

@property(strong,nonatomic,readwrite) PickViewCustom *inputView;//关键触发点

@property(nonatomic,copy) PickData pickData;

-(void)pickDataSource:(NSArray *)dataSource SourceType:(CustomPickerSourceType)sourceType Component:(NSInteger)groupNum PickData:(PickData)pickData;

@property(nonatomic,strong) NSArray *dataSource;

@property(nonatomic,assign) CustomPickerSourceType sourceType;

@property(nonatomic,assign) NSInteger component;

-(void)changePickDataSource:(NSArray *)datasource;

@end
