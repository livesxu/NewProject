
//

#import "UIView+Picker.h"
#import <objc/runtime.h>

@interface UIView ()

@property(nonatomic,copy) PickData pickData_picker;

@property(nonatomic,strong) NSArray *dataSource_picker;

@property(nonatomic,assign) CustomPickerSourceType sourceType_picker;

@property(nonatomic,assign) NSInteger component_picker;

@property(nonatomic,strong) PickViewCustom *inputViewSto;

@end

@implementation UIView (Picker)

static char inputViewKey;
static char dataSourceKey;
static char sourceTypeKey;
static char componentKey;
static char pickDataKey;
static char inputViewStoKey;

- (void)setInputView:(PickViewCustom *)inputView{
    [self willChangeValueForKey:@"inputViewKey"];
    objc_setAssociatedObject(self, &inputViewKey,
                             inputView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"inputViewKey"];
}

- (PickViewCustom *)inputView{
    
    return objc_getAssociatedObject(self, &inputViewKey);
}

- (void)setDataSource_picker:(NSArray *)dataSource{
    [self willChangeValueForKey:@"dataSourceKey"];
    objc_setAssociatedObject(self, &dataSourceKey,
                             dataSource,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"dataSourceKey"];
}

- (NSArray *)dataSource_picker{
    return objc_getAssociatedObject(self, &dataSourceKey);
}

- (void)setSourceType_picker:(CustomPickerSourceType)sourceType{
    [self willChangeValueForKey:@"sourceTypeKey"];
    objc_setAssociatedObject(self, &sourceTypeKey,
                             @(sourceType),
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"sourceTypeKey"];
}

- (CustomPickerSourceType)sourceType_picker{
    return [objc_getAssociatedObject(self, &sourceTypeKey) integerValue];
}

- (void)setComponent_picker:(NSInteger)component{
    [self willChangeValueForKey:@"componentKey"];
    objc_setAssociatedObject(self, &componentKey,
                             @(component),
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"componentKey"];
}

- (NSInteger)component_picker{
    return [objc_getAssociatedObject(self, &componentKey) integerValue];
}

- (void)setPickData_picker:(PickData)pickData{
    [self willChangeValueForKey:@"pickDataKey"];
    objc_setAssociatedObject(self, &pickDataKey,
                             pickData,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"pickDataKey"];
}

- (PickData)pickData_picker{
    return objc_getAssociatedObject(self, &pickDataKey);
}

- (void)setInputViewSto:(PickViewCustom *)inputViewSto{
    [self willChangeValueForKey:@"inputViewStoKey"];
    objc_setAssociatedObject(self, &inputViewStoKey,
                             inputViewSto,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"inputViewStoKey"];
}

- (PickViewCustom *)inputViewSto{
    return objc_getAssociatedObject(self, &inputViewStoKey);
}


- (BOOL) canBecomeFirstResponder {
    return YES;
}

-(void)pickCategroyDataSource:(NSArray *)dataSource SourceType:(CustomPickerSourceType)sourceType Component:(NSInteger)groupNum PickData:(PickData)pickData;{
    if (!self.dataSource_picker) {
        self.dataSource_picker = dataSource;
    }
    if (!self.sourceType_picker) {
        self.sourceType_picker = sourceType;
    }
    if (!self.component_picker) {
        self.component_picker = groupNum;
    }
    if (!self.pickData_picker) {
        self.pickData_picker = pickData;
    }
    
    if (!self.inputViewSto) {
        
        PickViewCustom *pick=[[PickViewCustom alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - KScreenPickViewHeight, KScreenPickViewWidth, KScreenPickViewHeight) DataSource:self.dataSource_picker SourceType:self.sourceType_picker Group:self.component_picker];
        __weak typeof(self) weakSelf=self;
        pick.backData=^(NSArray *dataBack,BOOL onlyBack){
            
            [weakSelf resignFirstResponder];
            
            if (!onlyBack) {
                if (weakSelf.pickData_picker) {
                    
                    weakSelf.pickData_picker(dataBack);
                }
                
            }
        };
            self.inputViewSto=pick;
    }
}

-(void)changeCategroyPickDataSource:(NSArray *)datasource;{
    
    self.dataSource_picker = datasource;
    
    PickViewCustom *pick=[[PickViewCustom alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - KScreenPickViewHeight, KScreenPickViewWidth, KScreenPickViewHeight) DataSource:self.dataSource_picker SourceType:self.sourceType_picker Group:self.component_picker];
    __weak typeof(self) weakSelf=self;
    pick.backData=^(NSArray *dataBack,BOOL onlyBack){
        
        [weakSelf resignFirstResponder];
        
        if (!onlyBack) {
            if (weakSelf.pickData_picker) {
                
                weakSelf.pickData_picker(dataBack);
            }
            
        }
    };
    self.inputViewSto=pick;
    
}

-(void)pickerShow;{
    
    self.inputView = self.inputViewSto;
    
    [self becomeFirstResponder];
}

@end
