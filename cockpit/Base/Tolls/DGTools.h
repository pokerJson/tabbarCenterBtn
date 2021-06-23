//
//  DGTools.h
//  DiscipleGroup
//
//  Created by maxudong on 2019/12/12.
//  Copyright © 2019 maxudong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**友盟统计-参数一类型*/
typedef enum {
    MobClickEventWithPhoneNumber = 0, //手机号
    MobClickEventWithPhoneDevice, //手机设备
    MobClickEventWithOther //其它参数，请至other字典中自行添加
} MobClickEventWith;

@class DGShareModel;

typedef void (^GetUserDataCallBackBlock)(void); //成功状态
typedef void (^GetShareDataCallBackBlock)(void); //获取分享信息

@interface DGTools : NSObject

+ (__kindof DGTools *)instance;

+ (void)showInfo:(NSString *)info;
+ (void)showInfo:(NSString *)info delyTime:(float)time;
+ (void)showHUDWithText:(NSString *)text;
+ (void)bl_Dismiss;
// 退出登录,清除用户数据
+ (BOOL)dumpDataOfUser;
@property(nonatomic, copy)NSString * sText;
@property(nonatomic, copy)NSString * sMasterOfficeText;
/**
 *过滤HTML标签
 */
+ (NSAttributedString *)filterHtmlTags:(NSString *)content;
+(NSString *)filterHTML:(NSString *)html;
- (void)dealLocalToken;
/**
 去除 HTML 的标签
 */
+ (NSString *)filterHTMLLabel:(NSString *)string;
/**
 *YYLabel
 *给字符串部分字符添加点击
 */
+ (NSMutableAttributedString *)richText:(NSString *)str color:(UIColor *)color font:(UIFont *)font clickStr:(NSString *)clickStr clickColor:(UIColor *)clickColor clickBlock:(void(^)(void))clickBlock;
/**
 *YYLabel
 *复制文本
 */
+ (NSMutableAttributedString *)pasteboardRichText:(NSString *)str color:(UIColor *)color font:(UIFont *)font lineSpace:(float)lineSpace clickBlock:(void(^)(void))clickBlock;
/**
 *YYLabel
 *给字符串部分字符添加点击
 *复制文本
 */
+ (NSMutableAttributedString *)foldingAndPasteboardRichText:(NSString *)str color:(UIColor *)color font:(UIFont *)font clickStr:(NSString *)clickStr clickColor:(UIColor *)clickColor pasteboardClickBlock:(void(^)(void))pasteboardClickBlock foldingClickBlock:(void(^)(void))foldingClickBlock;

+ (BOOL)checkHtmlContainsImg:(NSString *)html;

// 获取用户信息
- (void)getUserInfoNetworkHandler:(GetUserDataCallBackBlock)callbackBlock;
//获取最新的的用户信息登录IM 同步头像昵称等
- (void)getFullInfo:(GetUserDataCallBackBlock)callbackBlock;

+ (NSMutableAttributedString *)richText:(NSString *)str color:(UIColor *)color font:(UIFont *)font;
/**SVProgressHUD  loading*/
+ (void)DG_SVProgressHUD_Show;

//查看新任务数量
- (void)getQueryNewTaskNumNetworkHandler;
////更新新任务条数
- (void)getUpdateNewTaskNumNetworkHandler;
//判断用户是否登录
- (void)judgeUserIsLogin;

/** 点击事件统计*/
- (void)event:(NSString *)eventId;
/** 开始记录*/
- (void)beginLogCurrentPageVC:(__unsafe_unretained Class)CurrentPageVC;
/** 结束记录*/
- (void)endLogCurrentPageVC:(__unsafe_unretained Class)CurrentPageVC;
/** 友盟埋点2.0 eventId="edg_"*/
+ (void)event:(NSString *)eventId with:(MobClickEventWith)type useCommon:(BOOL)use other:(NSDictionary *)attributes;
/// 修改行间距
/// @param text 标题
/// @param space 行间距大小
- (NSMutableAttributedString *)changeText:(NSString *)text LineSpace:(CGFloat)space;

///后台播放专用
@property (nonatomic,assign) BOOL isMasterType;



//一键登录加普通登录 noraml是否是一键登录
+ (void)checkLoginWithIsOnlyNoramal:(BOOL)noraml;
+ (void)quickLoginWith:(NSString *)token;


+(void)jgCustomView;

@end

NS_ASSUME_NONNULL_END
