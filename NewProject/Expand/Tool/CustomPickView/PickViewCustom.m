//
//  PickViewCustom.m
//  TESTTF
//
//  Created by Livespro on 2016/11/10.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import "PickViewCustom.h"

@implementation PickViewCustom

-(instancetype)initWithFrame:(CGRect)frame DataSource:(NSArray *)dataSource SourceType:(CustomPickerSourceType)sourceType Group:(NSInteger)groupNum;{
    self=[super initWithFrame:frame];
    if (self) {
        
        _dataSource=dataSource;
        _sourceType=sourceType;
        _componentNum=groupNum > 3 ? 3 : groupNum;//最多3级联动
        
        [self creatWaySto];
        
        [self addSubview:self.topView];
        
        [self addSubview:self.pickView];
        
    }
    return self;
}

-(void)creatWaySto{
    
    _waySto=[NSMutableArray arrayWithCapacity:_componentNum];
    for (NSInteger i=0; i < _componentNum; i++) {
        
        [_waySto addObject:@"0"];
    }
}

-(UIView *)topView{
    if (!_topView) {
        
        _topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenPickViewWidth, KScreenPickViewToolHeight)];
        
        UIButton *cancelItem=[UIButton buttonWithType:UIButtonTypeCustom];
        [cancelItem setTitle:@"取消" forState:UIControlStateNormal];
        [cancelItem setTitleColor:KTopItemColor forState:UIControlStateNormal];
        cancelItem.frame=CGRectMake(KTopItemSpace, 0, KTopButtonWidth, KScreenPickViewToolHeight);
        [cancelItem addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *sureItem=[UIButton buttonWithType:UIButtonTypeCustom];
        [sureItem setTitle:@"确定" forState:UIControlStateNormal];
        [sureItem setTitleColor:KTopItemColor forState:UIControlStateNormal];
        sureItem.frame=CGRectMake(KScreenPickViewWidth - KTopButtonWidth - KTopItemSpace, 0, KTopButtonWidth, KScreenPickViewToolHeight);
        [sureItem addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(KTopItemSpace * 2 + KTopButtonWidth, 0, KScreenPickViewWidth - (KTopItemSpace * 4 + KTopButtonWidth * 2), KScreenPickViewToolHeight)];
        _titleLabel.textColor=KTopItemColor;
        
        [_topView addSubview:cancelItem];
        [_topView addSubview:sureItem];
        [_topView addSubview:_titleLabel];
        
    }
    return _topView;
}

-(void)cancelAction{
    
    if (self.backData) {
        self.backData([NSArray array],YES);
    }
}

-(void)sureAction{
    
    switch (_sourceType) {
        case CustomPickerSourceTypeAlone:
            
            return  [self aloneSureBack];
            
            break;
            
        case CustomPickerSourceTypeChain:
            
            return  [self chainSureBack];
            
            break;
            
        default:
            break;
    }
    
}
-(void)aloneSureBack{
    
    NSMutableArray *dataBack=[NSMutableArray array];
    
    for (NSInteger i=0; i < _waySto.count; i++) {
        
        NSString *rowStr = _waySto[i];
        if ([self aloneModelGet:i Row:rowStr.integerValue]) {
           
            [dataBack addObject:[self aloneModelGet:i Row:rowStr.integerValue]];
        }
    }
    
    if (self.backData) {
        self.backData(dataBack,NO);
    }
}
-(void)chainSureBack{
    
    NSMutableArray *dataBack=[NSMutableArray array];
    
    for (NSInteger i=0; i < _waySto.count; i++) {
        
        NSString *rowStr = _waySto[i];
        if ([self chainModelGet:i Row:rowStr.integerValue]) {
            
            [dataBack addObject:[self chainModelGet:i Row:rowStr.integerValue]];
        }
    }
    
    if (self.backData) {
        self.backData(dataBack,NO);
    }
}

-(UIPickerView *)pickView{
    if (!_pickView) {
        
        _pickView=[[UIPickerView alloc]initWithFrame:CGRectMake(0, KScreenPickViewToolHeight, KScreenPickViewWidth, KScreenPickViewHeight - KScreenPickViewToolHeight)];
        _pickView.delegate=self;
        _pickView.dataSource=self;
        _pickView.backgroundColor=[UIColor whiteColor];
        
    }
    return _pickView;
}


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;{
    
    return _componentNum;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;{
    
    switch (_sourceType) {
        case CustomPickerSourceTypeAlone:
            
            return [self aloneRowGet:component];
            
            break;
            
        case CustomPickerSourceTypeChain:
            
            return [self chainRowGet:component];
            
            break;
            
        default:
            break;
    }
    return 0;
}

-(NSInteger)aloneRowGet:(NSInteger)component{
    
    NSArray *componentArr=_dataSource[component];
    
    return componentArr.count;
}

-(NSInteger)chainRowGet:(NSInteger)component{
   
    if (component == 1) {//第二栏
        
        NSString * fatherLoaction= _waySto[0];
        PickerCustomModel *model = _dataSource[fatherLoaction.integerValue];
        
        if (model.subSource && model.subSource.count) {
            
            return model.subSource.count;
        } else {
            return 0;
        }
        
    } else if(component == 2){//第三栏
        
        NSString * fatherLoaction= _waySto[0];
        PickerCustomModel *model = _dataSource[fatherLoaction.integerValue];
        
        if (model.subSource && model.subSource.count) {
            
            NSString * fatherLoactionNext= _waySto[1];
            PickerCustomModel *modelNext = model.subSource[fatherLoactionNext.integerValue];
            
            if (modelNext.subSource && modelNext.subSource.count) {
                
                return modelNext.subSource.count;
            } else {
                return 0;
            }
        } else {
            return 0;
        }
    }else{
       
        return _dataSource.count;//第一栏
    }
    return 0;
}

// returns width of column and height of row for each component.
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component __TVOS_PROHIBITED;{
    
    return KScreenPickViewWidth/_componentNum;
}
// these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
// If you return back a different object, the old one will be released. the view will be centered in the row rect
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED;{
    switch (_sourceType) {
        case CustomPickerSourceTypeAlone:
            
            return  [self aloneModelGet:component Row:row] ? [self aloneModelGet:component Row:row].pickName :@"";
            
            break;
            
        case CustomPickerSourceTypeChain:
            
            return  [self chainModelGet:component Row:row] ? [self chainModelGet:component Row:row].pickName :@"";
            
            break;
            
        default:
            break;
    }
    return @"";
}

-(PickerCustomModel *)aloneModelGet:(NSInteger)component Row:(NSInteger)row{
    
    NSArray *componentArr=_dataSource[component];

    return componentArr[row];
}

-(PickerCustomModel *)chainModelGet:(NSInteger)component Row:(NSInteger)row{
    
    if (component == 1) {//第二栏
        
        NSString * fatherLoaction= _waySto[0];
        PickerCustomModel *model = _dataSource[fatherLoaction.integerValue];
        
        if (model.subSource && model.subSource.count) {
            
            return model.subSource[row];
        } else {
            return nil;
        }
        
    } else if(component == 2){//第三栏
        
        NSString * fatherLoaction= _waySto[0];
        PickerCustomModel *model = _dataSource[fatherLoaction.integerValue];
        
        if (model.subSource && model.subSource.count) {
            
            NSString * fatherLoactionNext= _waySto[1];
            PickerCustomModel *modelNext = model.subSource[fatherLoactionNext.integerValue];
            
            if (modelNext.subSource && modelNext.subSource.count) {
                
                return modelNext.subSource[row];
            } else {
                return nil;
            }
        } else {
            return nil;
        }
    }else{
        
        return _dataSource[row];//第一栏
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED;{
    
    switch (_sourceType) {
        case CustomPickerSourceTypeAlone:
            
            [self aloneSelectedModel:component Row:row];
            
            break;
            
        case CustomPickerSourceTypeChain:
            
            return  [self chainSelectedModel:component Row:row];
            
            break;
            
        default:
            break;
    }
   
}
-(void)aloneSelectedModel:(NSInteger)component Row:(NSInteger)row{
    
    [_waySto replaceObjectAtIndex:component withObject:[NSString stringWithFormat:@"%ld",row]];
 
}

-(void)chainSelectedModel:(NSInteger)component Row:(NSInteger)row{
    
    [_waySto replaceObjectAtIndex:component withObject:[NSString stringWithFormat:@"%ld",row]];
    if (component == 0) {
        [_waySto replaceObjectAtIndex:1 withObject:@"0"];
        [_waySto replaceObjectAtIndex:2 withObject:@"0"];
        [_pickView reloadComponent:1];
        [_pickView reloadComponent:2];
        [_pickView selectRow:0 inComponent:1 animated:YES];
        [_pickView selectRow:0 inComponent:2 animated:YES];
    }
    if (component == 1) {
        [_waySto replaceObjectAtIndex:2 withObject:@"0"];
        [_pickView reloadComponent:2];
        [_pickView selectRow:0 inComponent:2 animated:YES];
    }
}

-(void)setDataSource:(NSArray *)dataSource{
    _dataSource=dataSource;
    
    [_pickView reloadAllComponents];
    
}


@end
