//
//  CellSupportPicker.m
//  TESTTF
//
//  Created by Livespro on 2016/11/10.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import "CellSupportPicker.h"

@implementation CellSupportPicker

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL) canBecomeFirstResponder {
    return YES;
}

-(PickViewCustom *)inputView{
    if (!_inputView) {
        
        PickViewCustom *pick=[[PickViewCustom alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - KScreenPickViewHeight, KScreenPickViewWidth, KScreenPickViewHeight) DataSource:_dataSource SourceType:_sourceType Group:_component];
        __weak CellSupportPicker *weakSelf=self;
        pick.backData=^(NSArray *dataBack,BOOL onlyBack){
            
            [weakSelf resignFirstResponder];
            
            if (!onlyBack) {
                if (weakSelf.pickData) {
                    
                    weakSelf.pickData(dataBack);
                }
                
            }
        };
        _inputView=pick;
    }
    return _inputView;
}

-(void)pickDataSource:(NSArray *)dataSource SourceType:(CustomPickerSourceType)sourceType Component:(NSInteger)groupNum PickData:(PickData)pickData;{
    _dataSource=dataSource;
    _sourceType=sourceType;
    _component=groupNum;
    _pickData=pickData;
    
}

-(void)changePickDataSource:(NSArray *)datasource;{
    
    PickViewCustom *pick=[[PickViewCustom alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - KScreenPickViewHeight, KScreenPickViewWidth, KScreenPickViewHeight) DataSource:datasource SourceType:_sourceType Group:_component];
    __weak CellSupportPicker *weakSelf=self;
    pick.backData=^(NSArray *dataBack,BOOL onlyBack){
        
        [weakSelf resignFirstResponder];
        
        if (!onlyBack) {
            if (weakSelf.pickData) {
                
                weakSelf.pickData(dataBack);
            }
            
        }
    };
    _inputView=pick;
}

@end
