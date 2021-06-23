//
//  NSString+expand.h
//  JianYa
//
//  Created by mxd_iOS on 2017/3/16.
//  Copyright © 2017年 Xudong.ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (expand)

+ (NSString *)validString:(NSString *)string;
/**
 *  判断字符串是否为空
 */
+ (BOOL)isBlankString:(NSString *)string;

+ (NSString *)bas64For:(NSString *)str;

//md5
+ (NSString *)md5For16:(NSString *)str;

+ (NSString *)bas64EcodeFor:(NSString *)encodeStr;

//手机号判断
+ (BOOL)isVailDateMobNumber:(NSString *)moble;

/**
 *  手机号码验证 MODIFIED BY HELENSONG
 *
 *  @param mobile 手机号
 *
 *  @return 可用手机账号
 *
 *  @exception 判断用户名是否合法
 */
+ (BOOL)isValidateMobile:(NSString *)mobile;


/**
 *  邮箱验证 EMAIL BY HELENSONG
 *
 *  @param email 邮箱
 *
 *  @return 可用邮箱账号
 *
 *  @exception 判断用户名是否合法
 */
+ (BOOL)isValidateEmail:(NSString *)email;

/**
 *  身份证号码验证
 *
 *  @param identityCard 身份证
 *
 *  @return YES / NO
 */
+ (BOOL)availableIdentityCard:(NSString *)identityCard;

/**
 *  身份证号码验证
 *
 *  @param userID 身份证
 *
 *  @return YES / NO
 */
+ (BOOL)checkUserID:(NSString *)userID;

/**
 *  汉字验证
 *
 *  @param chineseCharStr 输入的字符串
 *
 *  @return YES / NO
 */
+ (BOOL)isChineseChar:(NSString *)chineseCharStr;

/**
 *  验证银行卡号
 *
 *  @param cardNo 银行卡号
 *
 *  @return YES / NO
 */
+ (BOOL)checkCardNo:(NSString*)cardNo;

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
                          str:(NSString *)str;

/**
 *  md5加密
 */
+ (NSString *)md5Handler:(NSString *)md5Str;

/**
 *  限制最大输入字符
 */

+ (BOOL)limitedMaxNumberOfString:(NSString *)string
                          Number:(NSInteger)number
                     limitedRang:(NSRange)limitedRang
                       textField:(UITextField *)textField;

/**
 *  判断是否包含特殊字符
 */
//+ (BOOL)isNotContainCspecialSymbol:(NSString *)cspecialSymbol;
/**
 *时间戳转化成 时间
 */
+ (NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;
/**
 *  毫秒转日期
 *
 *  @param time 时间戳
 */
+ (NSString *)transfomDateWithTime:(NSString *)time;
+ (NSString *)transfomYHDDateWithTime:(NSString *)time;

/**
 *  毫秒转 年月日
 *
 *  @param time 时间戳
 */
+ (NSString *)changeTimeToDateByTime:(NSString *)time;
/**
* 2020-07-25 23:59 转 2020年07月25日 23:59
*
*  @param time 时间戳
*/
+ (NSString *)timeChangeYearMonthDay:(NSString *)time;


- (BOOL)isBlankString;

/** 正则匹配用户密码6-20位数字和字母组合 */
+ (BOOL)checkPassword:(NSString *)passWord;

/** 正则匹配验证码6位数字 */
+ (BOOL)checkVerificationCode:(NSString *)verificationCode;

//获取IP地址
+ (NSString *)getIPAddress;


//是否含有表情（系统键盘判断）
+ (BOOL)stringContainsEmoji:(NSString *)string;

//判断字符串中是否存在emoji（第三方键盘）
- (BOOL)hasEmoji:(NSString*)string;

//去除字符串中所带的表情
- (NSString *)disable_emoji:(NSString *)text;

- (NSString *)getMMSSFromSS:(NSString *)totalTime;

+ (NSString *)dealAnswerTextByTargetStr:(NSString *)targetStr;
/**
 A-Z排序
 */
+ (NSString *)EnglishAlphabetSorting:(NSString *)string;

+ (id)jsonToObject:(NSString *)json;

+ (NSString *)dealLevelImgByLevel:(NSString *)level;
+ (NSString *)dealBigLevelImgByLevel:(NSString *)level;
+ (NSString *)dealRankLevel:(NSInteger)rank;
+ (NSString *)dealTaskType:(NSInteger)type;

- (BOOL)includeChinese;
- (BOOL)isVerifyOnlyNumberInString;
- (BOOL)isVerifyOnlyLetterInString;

/// 判断是否是英文和数字
- (BOOL)isVerifyNumberAndLetterInString;
  
//判断是否都是空格
+ (BOOL) isEmpty:(NSString*) str;
/// 大于等于0的正整数
+ (BOOL)checkPositiveIntegerGreaterThanOrEqual:(NSString *)string;
@end
