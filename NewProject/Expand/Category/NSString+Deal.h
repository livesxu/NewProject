

#import <Foundation/Foundation.h>

@interface NSString (Deal)

//字符串去掉&
+ (NSString *)stringWithOutAnd:(NSString *)string;

//拼接post的xml字符串
+ (NSString *)stringByModular:(NSString *)modular requestName:(NSString *)requestNameStr insertXml:(NSString *)insertXmlStr;

//字符串md5转码
+(NSString *)getMd5Str:(NSString *)str;

//判断字符串是否为null
+ (NSString *)stringWithoutNull:(NSString *)editStr;

//邮箱加*
+ (NSString *)getSecretEmailWithEmail:(NSString *)email;
//身份证加*
+ (NSString *)getSecretIdNumWithIdNum:(NSString *)idNum;
//手机号加*
+ (NSString *)getSecretMobileWithMobilePhone:(NSString *)mobile;

#pragma mark 截取字符串
+ (NSString *)cutStringWithString:(NSString *)string index:(NSUInteger)index;

// <br> 换成 \n
//+ (NSString *)changeLineWithString:(NSString *)string;

#pragma mark 发送转义字符串
+ (NSString *)changeStringWithRequestString:(NSString *)string;

#pragma mark 返回转义字符串
+ (NSString *)changeStringWithResponsString:(NSString *)string;

#pragma mark 屏蔽字符
+ (NSString *)changeStringWithoutChatByString:(NSString *)string;

//去除换行
+ (NSString *)changeStringWithoutChangeLineString:(NSString *)string;

//去除前后的逗号
+ (NSString *)stringWithoutSepWithString:(NSString *)string;

//判断是否全是空格
+ (BOOL)isAllSpaceWithString:(NSString *)string;

#pragma mark - json字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

#pragma mark 用于论坛处显示的时间
/*
 1、不同年则返回年月日
 2、同年、不同日则返回月日
 3、同年、同日、不在一个小时内则返回时分
 4、同年、同日、同时、超过一分钟则返回xxx分钟前
 5、一分钟以内则返回刚刚
 */
+ (NSString *)showAddTimeWithCreateTime:(NSString *)time currentTime:(NSString *)currentTime;


/**
 *  退款金额字符串处理
 *
 *  @param string 退款金额
 *
 *  @return 0：数字格式正确  1：数字格式错误  2：金额精确度有误
 */

+(int)returnMoneyJudgeWithString:(NSString *)string;

#pragma mark - 字符串正则验证
/*一些简单的字符串处理函数*/
- (NSString *)trim;
/*是否是有效字符串*/
- (BOOL)isValid;
/*邮箱*/
- (BOOL)validateEmail;
/*手机号码验证*/
- (BOOL)validateMobile;
/*车牌号验证*/
- (BOOL)validateCarNo;
/*车型*/
- (BOOL)validateCarType;
/*用户名*/
- (BOOL)validateUserName;
/*密码*/
- (BOOL)validatePassword;
/*昵称*/
- (BOOL)validateNickname;
/*身份证号*/
- (BOOL)validateIdentityCard;
/*电话号码*/
- (BOOL)validateTel;
/*标题*/
- (BOOL)validateTitle;
/*数字输入校验,只能输入数字和小数点*/
- (BOOL)validateNumberAndPoint;
/*数字输入校验，只能输入小数或整数*/
- (BOOL)validateNumberOrPoint;
/*纯数字校验*/
- (BOOL)validateNumber;
/*是否含有中文*/
- (BOOL)hasChiese;
/*是否是13位整数 或 13位证书和两位小数*/
- (BOOL)validateMaxPrice;
/*字符串转义将\n转成\\n等*/
- (NSString *)yd_transferredString;

#pragma mark - 字符串编码格式转换：由iso8859-1转成UTF-8格式
/**
 *  字符串编码格式转换：由iso8859-1转成UTF-8格式
 *
 *  @param ISOString iSO8859-1编码的字符串
 *
 *  @return UTF-8编码的字符串
 */
+ (instancetype)UTF8EncodingWithISOISOLatin1:(NSString *)ISOString;

@end
