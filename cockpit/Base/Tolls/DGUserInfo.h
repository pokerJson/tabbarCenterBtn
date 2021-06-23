//
//  DGUserInfo.h
//  DiscipleGroup
//
//  Created by maxudong on 2019/12/11.
//  Copyright © 2019 maxudong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DGUserInfo : NSObject

/**
 *  本地数据持久化类(单例)
 *
 *  @return self
 */
+ (__kindof DGUserInfo *)instance;

/**
 
 activeStatus = 1;
 cerSubmitStatus = "<null>";
 createTime = 1575031801000;
 firstActiveTime = 1575031818000;
 groupId = 1200380904696016896;
 groupName = "<null>";
 id = 1200396494051536896;
 openId = "oWvy61AIPuiCEPSVvsm4_vMFTITo";
 password = "<null>";
 phone = 17316282968;
 photoUrl = "http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJDx6cbOxJqBRTn9NOR04usUPNrrPTOFoYQkdVGceicoyBicH8Z2Oia9olVxia2oegWzDgq14r0ibXK3BA/132";
 roomStatus = 1;
 token = MTczMTYyODI5Njg0MzAy;
 updateTime = 1578383169000;
 userName = "\U62c9\U4e0d\U51fa\U7684\U65cb\U5f8b";
 userStatus = 1;
 userType = 1;
 
 */

/** 用户token*/
@property (nonatomic, copy) NSString *token;
/** 账号*/
@property (nonatomic, copy) NSString *mobileNumber;
/** 密码*/
@property (nonatomic, copy) NSString *password;
/// 用户 id
@property(nonatomic, assign) NSInteger  userId;
/// 用户状态（0：未激活，1：已激活，2，审核未通过，3：禁用）
@property(nonatomic, assign) NSInteger  userStatus;
/// 1认证了 其它都为未认证
@property(nonatomic, assign) NSInteger  activeStatus;
/// 1已领取弟子证 2没有领取
@property(nonatomic, assign) NSInteger  haveDzCard;
///// 0未完善 1已完善
//@property(nonatomic, assign) NSInteger  userInfoIsPerfect;

/** 是否有转盘活动开启 （0：未开启，1：已开启）*/
@property (nonatomic, copy) NSString *isOpen;

/** 是否有转盘活动开启 （0：开启，-1：未开启）*/
@property (nonatomic, copy) NSString *isHaveMasterman;

/// 用户审核状态 1审核中，2审核通过，3审核驳回，4待审核
@property(nonatomic, assign) NSInteger  cerStatus;

/// 用户头像
@property(nonatomic, copy) NSString  *photoUrl;

/// 是否选择行业
@property(nonatomic, assign) NSInteger  ifGetTribe;

/// 用户群名
@property(nonatomic, copy) NSString  *groupName;

/// 用户昵称
@property(nonatomic, copy) NSString  *userName;
/// 用户真实姓名
@property(nonatomic, copy) NSString  *realName;
/// 身份级别
@property(nonatomic, assign) NSInteger  identityType;//份级别（等级权益（0：初始化用户，1：白身，2：堂主，3：盟主，4：铜牌舵主、5银牌舵主、6金牌舵主））
/// 用户金币
@property(nonatomic, assign) NSInteger coin;

/// 用户学分
@property(nonatomic, assign) NSInteger credit;

/// 当前级别所需成长值
@property(nonatomic, copy) NSDecimalNumber *updateLevelNeedValue;

/// 用户成长值
@property(nonatomic, copy) NSDecimalNumber *growthValue;

/// 用户等级
@property(nonatomic, assign) NSInteger  level;
/// 用户等级名称
@property(nonatomic, copy) NSString  *levelName;

/// 地址
@property(nonatomic, copy) NSString *address;

//deviceToken
@property(nonatomic, copy) NSString *deviceToken;
/// 生日
@property(nonatomic, copy) NSString *birthday;

/// 性别
@property(nonatomic, assign) NSInteger sex;
//用户设立的目标
@property(nonatomic, copy)  NSString    *userTarget;
//填写详细信息的类型（0个人，1企业，没提交时默认999）
@property(nonatomic, assign)NSInteger    perfectInfoType;
//用户信息是否完善（0未完善，1已完善）
@property(nonatomic, assign)NSInteger    userInfoIsPerfect;
@property(nonatomic, assign)NSInteger    userInfoIsPerfectAll;
//是否有弟子证 :0-未获得弟子证， 1-已获得弟子证
@property(nonatomic, assign)NSInteger    userHaveDiscipleNo;

@property(nonatomic, assign) NSInteger  userInfoIsPerfectForIOS;

@property(nonatomic, assign) NSInteger  account_status;//0-启用 ; 1-禁用 （停止服务）

//0未领取 1领取了
@property(nonatomic, assign)NSInteger ifReceive;

@property (nonatomic, assign) NSInteger userHaveAgreedTime;//用户是否有协议同意时间： 0无同意时间 ； 1有同意时间

@property (nonatomic, assign) NSInteger identity;//  1学生 2老师(新增字段)
@property(nonatomic, copy) NSString *sig;

//服务到期时间
@property(nonatomic, copy) NSString *serviceEnd;

@property (nonatomic, assign) CGFloat fontScale;

//是否展示金币入口（0：不展示，1：展示）
@property(nonatomic, assign)NSInteger isShowCoin;

@property (nonatomic, copy) NSString *phone;
//总学习时长（6小时34分）
@property (nonatomic, copy) NSString *totalLearnTime;
//总成长值（3445）
@property (nonatomic, assign) NSInteger totalGrowthValue;

@property (nonatomic, assign) NSInteger taskNum8;//  taskNum8 任务8是否完成 0 未完成 1完成



+ (instancetype)userInfoWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
