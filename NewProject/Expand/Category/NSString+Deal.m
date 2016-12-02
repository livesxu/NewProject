

#import "NSString+Deal.h"
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

//若字符串为空则返回@""
#define AvailableString(string) string == nil || ![string isKindOfClass:[NSString class]] ? @"":string

@implementation NSString (Deal)
//拼接post的xml字符串
+ (NSString *)stringByModular:(NSString *)modular requestName:(NSString *)requestNameStr insertXml:(NSString *)insertXmlStr
{
    // AppInfo *app = [AppInfo shareInstance];
    
    NSMutableString *mutString = [[NSMutableString alloc]init];
    
    [mutString appendString:[NSString stringWithFormat:@"<fzjt><head>"]];
    [mutString appendString:[NSString stringWithFormat:@"<username>123</username>"]];
    [mutString appendString:[NSString stringWithFormat:@"<password>123</password>"]];
    [mutString appendString:[NSString stringWithFormat:@"<modular>%@</modular>",modular]];
    [mutString appendString:[NSString stringWithFormat:@"<requestname>%@</requestname>",requestNameStr]];
    [mutString appendString:[NSString stringWithFormat:@"<timestamp>11111</timestamp>"]];
    [mutString appendString:[NSString stringWithFormat:@"<peoplename>1111</peoplename>"]];
    [mutString appendString:[NSString stringWithFormat:@"<versions>1111</versions>"]];
    //
    [mutString appendString:[NSString stringWithFormat:@"</head><body><info>"]];
    
    [mutString appendString:insertXmlStr];
    
    [mutString appendString:[NSString stringWithFormat:@"</info></body></fzjt>"]];
    
    return mutString;
}

//字符串去掉&
+ (NSString *)stringWithOutAnd:(NSString *)string
{
    NSString *changeStr = [string stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    return changeStr;
}

+ (NSString *)getMd5Str:(NSString *)str
{
    const char *cStr = [str UTF8String];//转换成utf-8
    
    unsigned char result[16];//开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
    
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
    
    /*
     extern unsigned char *CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
     把cStr字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了result这个空间中
     */
    
    extern unsigned char *CC_MD5(const void *data, CC_LONG len, unsigned char *md);
    
    NSString *daxieStr = [NSString stringWithFormat:
                          
                          @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                          
                          result[0], result[1], result[2], result[3],
                          
                          result[4], result[5], result[6], result[7],
                          
                          result[8], result[9], result[10], result[11],
                          
                          result[12], result[13], result[14], result[15]
                          
                          ];
    
    // Convert string to lowercase
    NSString *lowerStr = [daxieStr lowercaseStringWithLocale:[NSLocale currentLocale]];
    
    return lowerStr;
    
    /*
     x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
     SYYLog("%02X", 0x888);  //888
     SYYLog("%02X", 0x4); //04
     */
}

//#pragma mark <br> 换成 \n
//+ (NSString *)changeLineWithString:(NSString *)string
//{
//    NSString *jsStr = [string stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"] ;
//    
//    return jsStr;
//}

#pragma mark 邮箱加*号
+ (NSString *)getSecretEmailWithEmail:(NSString *)email
{
    NSArray *strArray = [email componentsSeparatedByString:@"@"];
    
    NSMutableString *mutableStr = [[NSMutableString alloc]initWithString:AvailableString([strArray objectAtIndex:0])];
    
    NSInteger mutLength = [mutableStr length];
    
    NSMutableString *insertStr = [[NSMutableString alloc]init];
    
    //邮箱长度
    if (mutLength>6)
    {
        //显示 前3 后3
        for (int i=0; i<(mutLength-3-3); i++)
        {
            [insertStr insertString:@"*" atIndex:0];
        }
        
        [mutableStr replaceCharactersInRange:NSMakeRange(mutLength>3?3:mutLength, mutLength-3-3<0?0:mutLength-3-3) withString:insertStr];
    }
    else
    {
        [mutableStr replaceCharactersInRange:NSMakeRange(0, 1) withString:@"*"];
    }
    
    return [NSString stringWithFormat:@"%@@%@",mutableStr,[strArray objectAtIndex:1]];
}

#pragma mark 身份证号加*
+ (NSString *)getSecretIdNumWithIdNum:(NSString *)idNum
{
    if (idNum.length < 17) {
        return idNum;
    }
    
    NSMutableString *mutableStr = [[NSMutableString alloc]initWithString:idNum];
    [mutableStr replaceCharactersInRange:NSMakeRange(6, 8) withString:@"********"];
    
    return mutableStr;
}

#pragma mark 手机号加*
+ (NSString *)getSecretMobileWithMobilePhone:(NSString *)mobile
{
    if (mobile.length < 11) {
        return mobile;
    }
    
    NSMutableString *mutableStr = [[NSMutableString alloc]initWithString:mobile];
    [mutableStr replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    
    return mutableStr;
}
#pragma mark - 根据字符串获取字符串高度
+(int)heightForString:(NSString *)string stringWidth:(CGFloat)width fontSize:(CGFloat)fontSize
{
    CGSize titleSize = [string sizeWithFont:[UIFont systemFontOfSize:fontSize]  constrainedToSize:CGSizeMake(width, MAXFLOAT)
                              lineBreakMode:NSLineBreakByWordWrapping];
    return ceilf(titleSize.height);
}

#pragma mark - 根据字符串获取字符串宽带
+(int)widthForString:(NSString *)string fontSize:(CGFloat)fontSize
{
    CGSize titleSize = [string sizeWithFont:[UIFont systemFontOfSize:fontSize]  constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    return ceilf(titleSize.width);
}


#pragma mark 截取字符串
+ (NSString *)cutStringWithString:(NSString *)string index:(NSUInteger)index
{
    if ([string length]<=index)
    {
        return string;
    }
    
    string = [string substringToIndex:index];
    
    return string;
}

#pragma mark 截取中间字符串
+ (NSString *)cutSubStringWithString:(NSString *)string fromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    if ([string length] <= toIndex || [string length] <= fromIndex)
    {
        return string;
    }
    string = [string substringWithRange:NSMakeRange(fromIndex, toIndex-fromIndex+1)];
    
    return string;
}

#pragma mark 发送转义字符串
//去除换行
+ (NSString *)changeStringWithoutChangeLineString:(NSString *)string
{
    NSString *changeStr = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return changeStr;
}

+ (NSString *)changeStringWithRequestString:(NSString *)string
{
    //    NSString *jsStr = [[[string stringByReplacingOccurrencesOfString:@"\n" withString:@"&lt;br&gt;"] stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"] stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
    
    NSString *jsStr = [[[[[[string stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]
                           stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"]
                          stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"]
                         stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"]
                        stringByReplacingOccurrencesOfString:@"\'" withString:@"&apos;"] stringByReplacingOccurrencesOfString:@"\n" withString:@"&lt;br&gt;"];
    
    return jsStr;
}

#pragma mark 返回转义字符串
+ (NSString *)changeStringWithResponsString:(NSString *)string
{
    NSString *jsStr = [[[[string stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"] stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"] stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"] stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
    
    return jsStr;
}

#pragma mark 屏蔽字符
+ (NSString *)changeStringWithoutChatByString:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
    
    return string;
}

#pragma mark 字符串判断
+ (NSString *)stringWithoutNull:(NSString *)editStr
{
    
    //    NSString *strUrl = [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([editStr isEqualToString:@"(null)"] || editStr == nil || editStr == NULL || [editStr isKindOfClass:[NSNull class]] || [[editStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        editStr = @"";
    }
    return editStr;
}

#pragma mark 去掉前后的逗号
+ (NSString *)stringWithoutSepWithString:(NSString *)string
{
    if ([string length]==0) {
        return string;
    }
    
    if ([[string substringToIndex:1] isEqualToString:@","]) {
        string = [string substringFromIndex:1];
    }
    
    if ([[string substringFromIndex:[string length]-1] isEqualToString:@","]) {
        string = [string substringToIndex:[string length]-1];
    }
    
    return string;
}

#pragma mark 用于显示的时间
/*
 1、不同年则返回年月日
 2、同年、不同日则返回月日
 3、同年、同日、不在一个小时内则返回时分
 4、同年、同日、同时、超过一分钟则返回xxx分钟前
 5、一分钟以内则返回刚刚
 */
+ (NSString *)showAddTimeWithCreateTime:(NSString *)time currentTime:(NSString *)currentTime
{
    NSUInteger creatYear = [[NSString cutStringWithString:time index:4] integerValue];
    NSUInteger currentYear = [[NSString cutStringWithString:currentTime index:4] integerValue];
    //若不是同年，则只显示 年月日
    if(creatYear != currentYear)
    {
        return [NSString cutStringWithString:time index:10];
    }
    //若同年
    else{
        NSUInteger creatDay = [[time substringWithRange:NSMakeRange(8, 2)] integerValue];
        NSUInteger currentDay = [[currentTime substringWithRange:NSMakeRange(6, 2)] integerValue];
        //不同日，则只显示 月日
        if(creatDay != currentDay)
        {
            return [time substringWithRange:NSMakeRange(5, 5)];
        }
        //同日
        else
        {
            NSDateFormatter *creatFormatter = [[NSDateFormatter alloc] init];
            [creatFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *creatDate = [creatFormatter dateFromString:time];
            
            NSDateFormatter *currentFormatter = [[NSDateFormatter alloc] init];
            [currentFormatter setDateFormat:@"yyyyMMddHHmmss"];
            NSDate *currentDate = [currentFormatter dateFromString:currentTime];
            NSTimeInterval differTime = [currentDate timeIntervalSinceDate:creatDate];
            //不在一小时内，则只显示 时分
            if(differTime > 60 * 60 || differTime < 0)
            {
                return [time substringWithRange:NSMakeRange(11, 5)];
            }
            //在一小时内，则只显示 xx分钟前
            else
            {
                if((int)differTime/60 <= 0)
                {
                    return [NSString stringWithFormat:@"刚刚"];
                }
                return [NSString stringWithFormat:@"%d分钟前",(int)differTime/60];
            }
        }
    }
}

#pragma mark 判断是否全是空格
+ (BOOL)isAllSpaceWithString:(NSString *)string
{
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        
        return YES;
    }
    
    return NO;
}



+(int)returnMoneyJudgeWithString:(NSString *)string
{
    NSString * reg = @"^[1-9]\\d*\\.\\d+|0\\.\\d+|[1-9]\\d*$";
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",reg];
    
    NSString *regRight = @"^[1-9]\\d*\\.\\d{1,2}|0\\.\\d{1,2}|[1-9]\\d*$";
    
    NSPredicate *preRight = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regRight];
    
    if(![pre evaluateWithObject:string])
    {
        
        return 1;
    }
    
    if([pre evaluateWithObject:string] && ![preRight evaluateWithObject:string])
    {
        
        return 2;
    }
    
    return 0;
}


- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

//是否是有效的字符串
- (BOOL)isValid
{
    return self && [self isKindOfClass:[NSString class]] && [[self trim] length] > 0;
}

//邮箱
- (BOOL) validateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}


//手机号码验证
- (BOOL) validateMobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}


//车牌号验证
- (BOOL) validateCarNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:self];
}


//车型
- (BOOL) validateCarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:self];
}


//用户名
- (BOOL) validateUserName
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:self];
    return B;
}


//密码
- (BOOL) validatePassword
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}


//昵称
- (BOOL) validateNickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:self];
}


//身份证号
- (BOOL) validateIdentityCard
{
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}

//电话号码
- (BOOL)validateTel
{
    NSString *telRegex = @"((\\d{11})|^((\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1})|(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1}))$)";
    NSPredicate *telPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telRegex];
    return [telPredicate evaluateWithObject:self];
}

/**
 *  字符串编码格式转换：由iso8859-1转成UTF-8格式
 */
+ (instancetype)UTF8EncodingWithISOISOLatin1:(NSString *)ISOString
{
    NSString *ISOStr = AvailableString(ISOString);
    NSStringEncoding stringEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1);
    NSData *ISOData = [ISOStr dataUsingEncoding:stringEncoding];
    NSString *UTF8String =[[NSString alloc] initWithData:ISOData encoding:NSUTF8StringEncoding];
    return UTF8String;
}

/*标题*/
- (BOOL)validateTitle {
    NSString *titleRegex = @"^[a-zA-Z0-9\u4e00-\u9fa5]{1,20}$";
    NSPredicate *titlePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", titleRegex];
    return [titlePredicate evaluateWithObject:self];
}

/*
 *  数字输入校验,只能输入数字和小数点
 */
- (BOOL)validateNumberAndPoint {
    NSString *regex = @"^([0-9]|\\.)$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

/*
 *  数字输入校验，只能输入小数或整数
 */
- (BOOL)validateNumberOrPoint {
    NSString *regex = @"^[0-9]+((\\.[0-9]+)|([0-9]+)|\\.)?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

/*
 *  纯数字校验
 */
- (BOOL)validateNumber {
    NSString *regex = @"^[0-9]$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

/*是否含有中文*/
- (BOOL)hasChiese {
    NSString *regex = @"^[\u4e00-\u9fa5]$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

/*是否是13位整数 或 13位证书和两位小数*/
- (BOOL)validateMaxPrice {
    NSString *regex = @"^([0-9]{1,13}||[0-9]{1,13}\\.[0-9]{1,2}||[0-9]{1,13}\\.)$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

/*字符串转义将\n转义等*/
- (NSString *)yd_transferredString {
   return [[self stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"]
           stringByReplacingOccurrencesOfString:@"\r" withString:@"\\r"];
}

#pragma mark - json字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    if (!data) {
        return nil;
    }
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    return dic;
}



#pragma clang diagnostic pop

@end
