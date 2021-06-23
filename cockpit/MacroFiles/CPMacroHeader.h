//
//  CPMacroHeader.h
//  cockpit
//
//  Created by dzc on 2021/5/11.
//

#ifndef CPMacroHeader_h
#define CPMacroHeader_h

#import "UIColor+hexColor.h"
#import "UILabel+Expend.h"
#import "UIButton+Init.h"
#import "UIViewController+Expend.h"
#import "UIViewController+Helper.h"
#import "UIView+Category.h"
#import "UIView+ChangeView.h"
#import "DGSingleManager.h"
#import "DGNavigationController.h"
#import "CPLoginViewController.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
#import "DGTools.h"
#import "DGUserInfo.h"
#import "DGUserInfoManager.h"
#import <YYKit.h>
#import <SVProgressHUD/SVProgressHUD.h>
//#import "JVERIFICATIONService.h"
#import "RequestAPIClient.h"
#import "UITextField+expand.h"
#import "UITextField+PHPlaceholder.h"
#import "NSArray+additional.h"
#import "NSDictionary+extends.h"
#import "UIFont+FontExpends.h"
#import "NSMutableArray+expands.h"


//url
//数据
#define kCharts @"/charts"

//互评
#define kDepartmentComments @"/departmentComments"

//答疑
#define kQuestionAnswering @"/questionAnswering"

//排行榜
#define kRankingList @"/rankingList"

//节点
#define kNodeManagement @"/nodeManagement"

//个人中心
#define kPersonalCenter @"/personalCenter"


//登录
#define kLoginUrl @"/login"
//升级
#define kVersionUpgrade @"/升级接口"

//审核接口
#define kCheckState @"/open/dict/data/type/ios_review_status"

#pragma mark -
#pragma mark - 是否是一键登录 后期自己控制
#define kIsNoramlLogin YES


///** 弟子群打印宏 结合NSArray和NSdictory分类控制台打印中文*/
#ifdef DEBUG
#define DGLog(fmt, ...) NSLog((@"%s [Line %d] \n ->> " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DGLog(...)
#endif


#define RGBA(r,g,b,a)                       [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
/** 配置宽高比例*/
#define Set_WidthScale(pointer)  pointer * SCREEN_WIDTH / 375.f

/** 判断是否为iPhone X 系列或以上 这样写消除了在Xcode10上的警告*/
#define isMoreThan_IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

/** 状态栏高度*/
#define kSTATUSBAR_HEIGHT (isMoreThan_IPHONE_X ? 44. : 20.)
/** 状态栏+导航栏高度*/
#define kNAVBAR_HEIGHT    (isMoreThan_IPHONE_X ? 88. : 64.)
/** tabbar高度*/
#define kTABBAR_HEIGHT    (isMoreThan_IPHONE_X ? 83. : 49.)
/** 底部安全区域远离高度*/
#define kBottomSafeHeight (CGFloat)(isMoreThan_IPHONE_X ? 34. : 0)
/**DGAlertView宽度*/
#define kAlertViewWidth Set_WidthScale(295.)

/** 弱指针*/
#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define CPFont(font) [UIFont systemFontOfSize:font]
#define CPBoldFont(font) [UIFont boldSystemFontOfSize:font]
/** 字符串是否为空*/
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO)

/** 数组是否为空*/
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)

/** 字典是否为空*/
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)

/** 获取系统版本*/
#define kCurrentSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]

/** 获取当前语言*/
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

/** 当前版本号*/
#define kCurrentAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/** 当前app名称*/
#define kCurrentAppName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

/** userDefault存储数据到沙盒(选用)*/
#define GET_USER_DEFAULT(KEY)  [[NSUserDefaults standardUserDefaults] objectForKey:KEY]

#define SAVE_USE_RDEFAULT(VALUE,KEY)  [[NSUserDefaults standardUserDefaults] setObject:VALUE forKey:KEY]

/**沙盒document路径*/
#define kDocumentPath ([NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject])



#endif /* CPMacroHeader_h */
