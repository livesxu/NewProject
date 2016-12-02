//
//  KeyBoardCustom.h
//  InitKeyBoard_dome
//
//  Created by Livespro on 2016/11/10.
//  Copyright © 2016年 lf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CustomKeyBoardType) {
    CustomKeyBoardTypeNumber = 0,
    CustomKeyBoardTypeOther
};

@interface KeyBoardCustom : UIView

+(void)applyTo:(UITextField *)textField Type:(CustomKeyBoardType)type;

@end
