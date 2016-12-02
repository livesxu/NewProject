//
//  DecideString.h
//  XTWL_XFJY
//
//  Created by xuntiangwangluo on 14-11-3.
//  Copyright (c) 2014年 xuntiangwangluo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DecideString : NSObject

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;
//用户名
+ (BOOL) validateUserName:(NSString *)name;
//密码
+ (BOOL) validatePassword:(NSString *)passWord;
//邮编
+ (BOOL) validateYouBian:(NSString *)youbian;
//邮箱
+ (BOOL) validateEmail:(NSString *)email;
//包含字母数字的6~15位密码
+ (BOOL) availablePassword:(NSString *)passWord;
//只能包含字母、数字和文字的昵称
+ (BOOL) availableNickName:(NSString *)name;
//只能包含字母、数字和文字和部分字符的昵称
+ (BOOL) availableTitle:(NSString *)string;
//只能包含数字和.
+ (BOOL) availableMoney:(NSString *)string;
//昵称长度
+ (BOOL) validateNickname:(NSString *)nickname;
//收货人姓名
+ (BOOL) availableAddTitle:(NSString *)string;
//详细地址
+(BOOL) availabeDetailAdd:(NSString *)string;
//普通文本内容
+ (BOOL) availableContext:(NSString *)string;
//只能包含数字
+ (BOOL) availableNumber:(NSString *)string;
//纳税人识别号
+ (BOOL) availableBillPayerID:(NSString *)string;
//只能中文
+(BOOL)availableChinese:(NSString *)string;
//银行卡
+ (BOOL) availableBankNum:(NSString *)string;
//判断文字是否包含表情符号 YES:包含  NO：不包含
+ (BOOL)stringContainsEmoji:(NSString *)string;
@end
