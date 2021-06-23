//
//  NSString+expand.m
//  JianYa
//
//  Created by mxd_iOS on 2017/3/16.
//  Copyright © 2017年 Xudong.ma. All rights reserved.
//

#import "NSString+expand.h"
#import <CommonCrypto/CommonDigest.h>
//Get IP 需要导入的库文件
#import <ifaddrs.h>
#import <arpa/inet.h>
#import "NSMutableArray+expands.h"

#define kEmptyStr @""

@implementation NSString (expand)

+ (NSString *)validString:(NSString *)string {
    
    if ([self isBlankString:string]) {
        return  kEmptyStr;
    } else {
        return string;
    }
}

/**
 *  判断字符串是否为空
 */
+ (BOOL)isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSString class]] == NO) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

+ (NSString *)bas64For:(NSString *)str
{
    NSData* originData = [str dataUsingEncoding:NSASCIIStringEncoding];
    NSString *encodeResult  = [originData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return encodeResult;
}

//md5
+ (NSString *)md5For16:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
};


+ (NSString *)bas64EcodeFor:(NSString *)encodeStr
{

    NSData *data = [[NSData alloc]initWithBase64EncodedString:encodeStr options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

//手机号判断
+ (BOOL)isVailDateMobNumber:(NSString *)moble
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9])|(19[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:moble];
    
}

/**
 *  手机号码验证 MODIFIED BY HELENSONG
 *
 *  @param mobile 手机号
 *
 *  @return 可用手机账号
 *
 *  @exception 判断用户名是否合法
 */
+ (BOOL)isValidateMobile:(NSString *)mobile
{
    /**
     *  控制手机号位数
     */
    if (mobile.length != 11)
    {
        return NO;
    }
    
    /** 2019最新验证手机号正则*/
    NSString *Mobile_2019 = @"^(13[0-9]|14[05679]|15[0-3,5-9]|16[2567]|17[01235678]|18[0-9]|19[189])\\d{8}$";
    
    /** 2018最新验证手机号正则*/
    NSString *Mobile_2018 = @"^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$";
    
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
    
    /**
     * 中国移动：China Mobile
     *
     *  134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextest2018 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Mobile_2018];
    NSPredicate *regextest2019 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Mobile_2019];
    
    if (([regextestmobile evaluateWithObject:mobile] == YES)
        || ([regextestcm evaluateWithObject:mobile] == YES)
        || ([regextestct evaluateWithObject:mobile] == YES)
        || ([regextestcu evaluateWithObject:mobile] == YES)
        || ([regextest2018 evaluateWithObject:mobile] == YES)
        || ([regextest2019 evaluateWithObject:mobile] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

/**
 *  邮箱验证 EMAIL BY HELENSONG
 *
 *  @param email 邮箱
 *
 *  @return 可用邮箱账号
 *
 *  @exception 判断用户名是否合法
 */
+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


/**
 *  计算属性字符文本占用的宽高
 *
 *  @param font    显示的字体
 *  @param maxSize 最大的显示范围
 *  @param lineSpacing 行间距
 *
 *  @return 占用的宽高
 */
- (CGSize)attrStrSizeWithFont:(UIFont *)font
                   andmaxSize:(CGSize)maxSize
                  lineSpacing:(CGFloat)lineSpacing
                          str:(NSString *)str
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    NSDictionary *dict = @{NSFontAttributeName: font,
                           NSParagraphStyleAttributeName: paragraphStyle};
    CGSize sizeToFit = [str boundingRectWithSize:maxSize // 用于计算文本绘制时占据的矩形块
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                      attributes:dict        // 文字的属性
                                         context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    return sizeToFit;
}

/**
 *  获取label的高度
 *
 *  label
 *
 *  return
 */
- (CGFloat)theHeightOfcommentLabel:(UILabel *)label
{
    label.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGSize size = [label sizeThatFits:CGSizeMake(label.frame.size.width, MAXFLOAT)];
    
    return size.height;
}



/**
 *  身份证号码验证
 *
 *  @param identityCard 身份证
 *
 *  @return YES / NO
 */
+ (BOOL)availableIdentityCard:(NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

/**
 *  身份证号码验证
 *
 *  @param userID 身份证
 *
 *  @return YES / NO
 */
+ (BOOL)checkUserID:(NSString *)userID
{
    //长度不为18的都排除掉
    if (userID.length != 18) {
        return NO;
    }
    
    //校验格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL flag = [identityCardPredicate evaluateWithObject:userID];
    
    if (!flag) {
        return flag;    //格式错误
    }else {
        //格式正确在判断是否合法
        //将前17位加权因子保存在数组里
        NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
        
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
        
        //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0;
        for(int i = 0; i < 17; i++)
        {
            NSInteger subStrIndex = [[userID substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
            
            idCardWiSum+= subStrIndex * idCardWiIndex;
            
        }
        
        //计算出校验码所在数组的位置
        NSInteger idCardMod = idCardWiSum % 11;
        
        //得到最后一位身份证号码
        NSString * idCardLast= [userID substringWithRange:NSMakeRange(17, 1)];
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2)
        {
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
            {
                return YES;
            }else
            {
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
    }
}


/**
 *  汉字验证
 *
 *  @param chineseCharStr 输入的字符串
 *
 *  @return YES / NO
 */
+ (BOOL)isChineseChar:(NSString *)chineseCharStr
{
    BOOL flag;
    if (chineseCharStr.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^[\u4E00-\u9FA5]+$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex2];
    return [identityCardPredicate evaluateWithObject:chineseCharStr];
}


/// 是否包含汉字
- (BOOL)includeChinese
{
    for(int i=0; i< [self length];i++)
    {
        int a =[self characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
        }
    }
    return NO;
}

//根据正则，过滤特殊字符
- (NSString *)filterCharactor:(NSString *)string withRegex:(NSString *)regexStr {
    NSString *searchText = string;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *result = [regex stringByReplacingMatchesInString:searchText options:NSMatchingReportCompletion range:NSMakeRange(0, searchText.length) withTemplate:@""];
    return result;
}

/**
 *  验证银行卡号
 *
 *  @param cardNo 银行卡号
 *
 *  @return YES / NO
 */
+ (BOOL)checkCardNo:(NSString*)cardNo
{
    int oddsum  = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum  = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength - 1 ; i >= 1; i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i - 1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 == 1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal >= 10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

/**
 *  md5加密
 */
+ (NSString *)md5Handler:(NSString *)md5Str
{
    const char *cStr = [md5Str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}



/**
 *  限制最大输入字符
 */

+ (BOOL)limitedMaxNumberOfString:(NSString *)string
                          Number:(NSInteger)number
                     limitedRang:(NSRange)limitedRang
                       textField:(UITextField *)textField
{
    NSInteger _existedLength;
    NSInteger _selectedLength;
    NSInteger _replaceLength;
    
    _existedLength  = textField.text.length;
    _selectedLength = limitedRang.length;
    _replaceLength  = string.length;
    
    if (string.length == 0 || string == nil) {
        
        return YES;
        
    } else if (_existedLength - _selectedLength + _replaceLength > number || _existedLength > number) {
        
        return NO;
    }
    
    return YES;
}
/**
 *时间戳转化成 时间
 */
+ (NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; // （@"YYYY-MM-dd HH:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp / 1000];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
    
}
/**
 *  毫秒转日期
 *
 *  @param time 时间戳
 */
+ (NSString *)transfomDateWithTime:(NSString *)time
{
    /**
     传入时间转NSDate类型
     */
    NSDate *timeDate = [[NSDate alloc]initWithTimeIntervalSince1970:[time longLongValue] / 1000.0];
    
    /**
     初始化并定义Formatter
     
     :returns: NSDate
     */
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    
    /**
     *  使用Formatter格式化时间（传入时间和当前时间）为NSString
     */
    NSString *timeStr    = [dateFormatter stringFromDate:timeDate];
    return timeStr;
    //    NSString *nowDateStr = [dateFormatter stringFromDate:[NSDate date]];
    //
    //    /**
    //     *  判断前四位是不是本年，不是本年直接返回完整时间
    //     */
    //    if ([[timeStr substringWithRange:NSMakeRange(0, 4)] rangeOfString:[nowDateStr substringWithRange:NSMakeRange(0, 4)]].location == NSNotFound) {
    //        return timeStr;
    //
    //    } else {
    //        /**
    //         *  判断是不是本天，是本天返回HH:mm,不是返回MM-dd HH:mm
    //         */
    //        if ([[timeStr substringWithRange:NSMakeRange(5, 5)] rangeOfString:[nowDateStr substringWithRange:NSMakeRange(5, 5)]].location != NSNotFound) {
    //
    //            return [timeStr substringWithRange:NSMakeRange(11, 5)];
    //
    //        } else {
    //
    //            return [timeStr substringWithRange:NSMakeRange(5, 11)];
    //        }
    //    }
}
+ (NSString *)transfomYHDDateWithTime:(NSString *)time
{
    /**
     传入时间转NSDate类型
     */
    NSDate *timeDate = [[NSDate alloc]initWithTimeIntervalSince1970:[time longLongValue] / 1000.0];
    
    /**
     初始化并定义Formatter
     
     :returns: NSDate
     */
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    /**
     *  使用Formatter格式化时间（传入时间和当前时间）为NSString
     */
    NSString *timeStr    = [dateFormatter stringFromDate:timeDate];
    return timeStr;
    //    NSString *nowDateStr = [dateFormatter stringFromDate:[NSDate date]];
    //
    //    /**
    //     *  判断前四位是不是本年，不是本年直接返回完整时间
    //     */
    //    if ([[timeStr substringWithRange:NSMakeRange(0, 4)] rangeOfString:[nowDateStr substringWithRange:NSMakeRange(0, 4)]].location == NSNotFound) {
    //        return timeStr;
    //
    //    } else {
    //        /**
    //         *  判断是不是本天，是本天返回HH:mm,不是返回MM-dd HH:mm
    //         */
    //        if ([[timeStr substringWithRange:NSMakeRange(5, 5)] rangeOfString:[nowDateStr substringWithRange:NSMakeRange(5, 5)]].location != NSNotFound) {
    //
    //            return [timeStr substringWithRange:NSMakeRange(11, 5)];
    //
    //        } else {
    //
    //            return [timeStr substringWithRange:NSMakeRange(5, 11)];
    //        }
    //    }
}
/**
 *  毫秒转 年月日
 *
 *  @param time 时间戳
 */
+ (NSString *)changeTimeToDateByTime:(NSString *)time
{
    /**
     传入时间转NSDate类型
     */
    NSDate *timeDate = [[NSDate alloc]initWithTimeIntervalSince1970:[time longLongValue] / 1000.0];
    
    /**
     初始化并定义Formatter
     
     :returns: NSDate
     */
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM-dd";
    
    /**
     *  使用Formatter格式化时间（传入时间和当前时间）为NSString
     */
    NSString *timeStr    = [dateFormatter stringFromDate:timeDate];
    return timeStr;
}
/**
* 2020-07-25 23:59 转 2020年07月25日 23:59
*
*  @param time 时间戳
*/
+ (NSString *)timeChangeYearMonthDay:(NSString *)time{
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    // 设置日期格式
    [formatter1 setDateFormat:@"yyyy-MM-ddHH:mm"];
    // 要转换的日期字符串
    NSString *dateString1 = time;
    // NSDate形式的日期
    NSDate *date =[formatter1 dateFromString:dateString1];
    
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:@"yyyy年MM月dd日HH:mm"];
    NSString *dateString2 = [formatter2 stringFromDate:date];
    return dateString2;
}
//字符串是否为空
- (BOOL) isBlankString {
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

/*  判断用户输入的密码是否符合规范，符合规范的密码要求：
 1. 长度大于8位
 2. 密码中必须同时包含数字和字母
 */
+ (BOOL)judgePassWordLegal:(NSString *)pass
{
    BOOL result = false;
    if ([pass length] >= 8)
    {
        // 判断长度大于8位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}

/** 正则匹配用户密码6位数字和字母组合 */
+ (BOOL)checkPassword:(NSString *)passWord {
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

/** 正则匹配验证码6位数字 */
+ (BOOL)checkVerificationCode:(NSString *)verificationCode {
    NSString *verificationCodeRegex = @"^[0-9]{6,6}+$";
    NSPredicate *verificationCodePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",verificationCodeRegex];
    return [verificationCodePredicate evaluateWithObject:verificationCode];
}

+ (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

- (NSString *)getMMSSFromSS:(NSString *)totalTime {
    
    NSInteger seconds = [totalTime integerValue] / 1000;
    
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    if ([str_hour integerValue] < 0) {
        str_hour = @"00";
    }
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    if ([str_minute integerValue] < 0) {
        str_minute = @"00";
    }
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    if ([str_second integerValue] < 0) {
        str_second = @"00";
    }
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    
    return format_time;
}


//是否含有表情
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop)
     {
         const unichar hs = [substring characterAtIndex:0];
         
         
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
             
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
         } else {
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

/**
 
  *  判断字符串中是否存在emoji
 
  * @param string 字符串
 
  * @return YES(含有表情)
 
  */
- (BOOL)hasEmoji:(NSString*)string {
    
    NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    
    BOOL isMatch = [pred evaluateWithObject:string];
    
    return isMatch;
    
}

//去除字符串中所带的表情
- (NSString *)disable_emoji:(NSString *)text{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}


/**
 字符串排序

 @param targetStr 需要转换的字符串
 @return 转换完成的字符串
 */
+ (NSString *)dealAnswerTextByTargetStr:(NSString *)targetStr
{
    NSString *newStr = targetStr;
    if (newStr.length <= 1) {
        return newStr;
    }
    
    NSString *fStr = [NSString string];
    NSMutableArray *fArray = @[].mutableCopy;
    for (NSInteger i = 0; i < newStr.length; i++) {
        fStr = [newStr substringWithRange:NSMakeRange(i, 1)];
        [fArray addObject:fStr];
    }
    
    NSArray *resultArray = [NSMutableArray getSortArrayByList:fArray];
    NSString *temp = nil;
    NSString *finalStr = [NSString string];
    
    for (NSInteger i = 0; i < resultArray.count; i++) {
        
        temp = resultArray[i];
        NSString *appendStr = nil;
        if (i == resultArray.count - 1) {
            appendStr = temp;
        } else {
            appendStr = [NSString stringWithFormat:@"%@、", temp];
        }
        finalStr = [finalStr stringByAppendingString:appendStr];
        DGLog(@"");
    }
    
    if (kStringIsEmpty(finalStr)) {
        finalStr = @"未答";
    }
    
    return finalStr;
}
/**
 A-Z排序
 */
+ (NSString *)EnglishAlphabetSorting:(NSString *)string {
    NSMutableArray *arry = [NSMutableArray new];
    NSMutableArray *temArry = [NSMutableArray new];
    __block NSString *endStr = @"";
    for (int i = 0; i < string.length; i++) {
        unichar strChar =  [string characterAtIndex:i];
        [arry addObject:[NSString stringWithFormat:@"%c",strChar]];
    }
    
    if (arry.count > 0) {
        temArry = [NSMutableArray getSortArrayByList:arry];
    }
    if (temArry.count > 0) {
        [temArry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            endStr = [NSString stringWithFormat:@"%@%@",endStr,obj];
        }];
    }
    return endStr;
}

+ (id)jsonToObject:(NSString *)json
{
    //string转data
    NSData * jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    //json解析
    id obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    return obj;
}

+ (NSString *)dealLevelImgByLevel:(NSString *)level
{
    NSInteger levelStatus = [level integerValue];
    
    if (1 == levelStatus) {
        return @"dg_home_studentRank_lv_1";
    }
    if (2 == levelStatus) {
        return @"dg_home_studentRank_lv_2";
    }
    if (3 == levelStatus) {
        return @"dg_home_studentRank_lv_3";
    }
    if (4 == levelStatus) {
        return @"dg_home_studentRank_lv_4";
    }
    if (5 == levelStatus) {
        return @"dg_home_studentRank_lv_5";
    }
    if (6 == levelStatus) {
        return @"dg_home_studentRank_lv_6";
    }
    
    return @"dg_home_studentRank_lv_1";
}


+ (NSString *)dealBigLevelImgByLevel:(NSString *)level
{
    NSInteger levelStatus = [level integerValue];
    
    if (1 == levelStatus) {
        return @"dg_home_studentRank_big_lv_1";
    }
    if (2 == levelStatus) {
        return @"dg_home_studentRank_big_lv_2";
    }
    if (3 == levelStatus) {
        return @"dg_home_studentRank_big_lv_3";
    }
    if (4 == levelStatus) {
        return @"dg_home_studentRank_big_lv_4";
    }
    if (5 == levelStatus) {
        return @"dg_home_studentRank_big_lv_5";
    }
    if (6 == levelStatus) {
        return @"dg_home_studentRank_big_lv_6";
    }
    if (7 == levelStatus) {
        return @"dg_home_studentRank_big_lv_7";
    }
    if (8 == levelStatus) {
        return @"dg_home_studentRank_big_lv_8";
    }
    if (9 == levelStatus) {
        return @"dg_home_studentRank_big_lv_9";
    }
    
    return @"dg_home_studentRank_big_lv_1";
}

+ (NSString *)dealRankLevel:(NSInteger)rank {
        
    if (1 == rank) {
        return @"study_ranklist_no1";
    }
    if (2 == rank) {
        return @"study_ranklist_no2";
    }
    if (3 == rank) {
        return @"study_ranklist_no3";
    }
    return @"study_ranklist_no1";
}

+ (NSString *)dealTaskType:(NSInteger)type {
    if (1 == type) {
        return @"dg_task_type_zhanzhuang";
    }
    if (2 == type) {
        return @"dg_task_type_dazuo";
    }
    if (3 == type) {
        return @"dg_task_type_dingli";
    }
    if (4 == type) {
        return @"dg_task_type_mingxiang";
    }
    return @"dg_task_type_zhanzhuang";
}

- (BOOL)isVerifyOnlyNumberInString {
    NSString * regex = [[NSString alloc] initWithFormat:@"[0-9]"];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}


- (BOOL)isVerifyOnlyLetterInString {
    NSString *regex = [[NSString alloc] initWithFormat:@"[A-Za-z]"];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}
- (BOOL)isVerifyNumberAndLetterInString
{
    NSString *regexLM = @"[a-zA-Z0-9]*";
    NSPredicate *predLM = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexLM];
    if (![predLM evaluateWithObject:self]) {
        return NO;
    }else {
        return YES;
    }
}

+ (BOOL) isEmpty:(NSString*) str {
    if(!str) {
        return YES;
    }else{
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        if([trimedString length] == 0){
            return YES;
        }else{
            return NO;
        }
    }
}

/// 大于等于0的正整数
+ (BOOL)checkPositiveIntegerGreaterThanOrEqual:(NSString *)string
{
    NSString *reg = @"^(0|[1-9][0-9]*)$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    if (![pred evaluateWithObject:string]) {
        return NO;
    }
    return YES;
}
@end
