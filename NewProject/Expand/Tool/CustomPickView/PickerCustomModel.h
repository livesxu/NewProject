//
//  PickerCustomModel.h
//  TESTTF
//
//  Created by Livespro on 2016/11/11.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PickerCustomModel : NSObject

@property (nonatomic,copy) NSString *pickName;

@property (nonatomic,copy) NSString *pickKey;

@property (nonatomic,strong) NSMutableArray *subSource;

@end
