//
//  DGUserInfo.m
//  DiscipleGroup
//
//  Created by maxudong on 2019/12/11.
//  Copyright © 2019 maxudong. All rights reserved.
//

#import "DGUserInfo.h"

/** 用户token*/
NSString *const kToken = @"dg_token";
/** 用户账号*/
NSString *const kMobileNumber = @"dg_mobileNumber";
/** 用户密码*/
NSString *const kPassword = @"dg_password";

/** 用户密码*/
NSString *const kFontScale = @"fontScale";

/** 首页活动是否开启 1开启 */
NSString *const kIsOpen = @"dg_isOpen";

/** 首页宗师是否开启 code=0开启 */
NSString *const kIsHaveMasterman = @"dg_isHaveMasterman";
/** 用户是否完善资料 */
NSString *const kUserInfoIsPerfect = @"dg_userInfoIsPerfect";

@implementation DGUserInfo

+ (__kindof DGUserInfo *)instance
{
    static DGUserInfo *userInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        userInfo = [[super allocWithZone:NULL] init];
    });
    
    return userInfo;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [DGUserInfo instance];
}

- (id)copy {
    return self;
}

- (id)mutableCopy {
    return self;
}


+ (instancetype)userInfoWithDictionary:(NSDictionary *)dictionary {
    DGUserInfo *userInfo = [DGUserInfo instance];
    if (!kDictIsEmpty(dictionary)) {
        userInfo.userId = [dictionary[@"id"] integerValue];
        userInfo.level = [dictionary[@"level"] integerValue];
        userInfo.isShowCoin = [dictionary[@"isShowCoin"] integerValue];
        userInfo.taskNum8 = [dictionary[@"taskNum8"] integerValue];
        userInfo.totalGrowthValue = [dictionary[@"totalGrowthValue"] integerValue];
        userInfo.levelName = dictionary[@"levelName"];
        userInfo.mobileNumber = dictionary[@"mobileNumber"];
        userInfo.growthValue = dictionary[@"growthValue"];
        userInfo.updateLevelNeedValue = dictionary[@"updateLevelNeedValue"];
        userInfo.credit = [dictionary[@"credit"] integerValue];
        userInfo.coin = [dictionary[@"coin"]integerValue];
        userInfo.userName = dictionary[@"userName"]?:@"";
        userInfo.groupName = dictionary[@"groupName"]?:@"";
        userInfo.photoUrl = dictionary[@"photoUrl"]?:@"";
        userInfo.cerStatus = [dictionary[@"cerStatus"] integerValue];
        userInfo.userStatus = [dictionary[@"userStatus"] integerValue];
        userInfo.activeStatus = [dictionary[@"activeStatus"] integerValue];
        userInfo.birthday = dictionary[@"birthday"] ;
        userInfo.address = dictionary[@"address"];
        userInfo.deviceToken = dictionary[@"deviceToken"];
        userInfo.sex = [dictionary[@"sex"] integerValue];
        userInfo.perfectInfoType = [dictionary[@"perfectInfoType"] integerValue];
        userInfo.userTarget = dictionary[@"userTarget"]?:@"";
        userInfo.totalLearnTime = dictionary[@"totalLearnTime"]?:@"";
        userInfo.phone = dictionary[@"phone"]?:@"";
        userInfo.userInfoIsPerfect = [dictionary[@"userInfoIsPerfect"] integerValue];;
        userInfo.userHaveDiscipleNo = [dictionary[@"userHaveDiscipleNo"] integerValue];
        userInfo.identity = [dictionary[@"identity"] integerValue];
        userInfo.userHaveAgreedTime = [dictionary[@"userHaveAgreedTime"] integerValue];
        
        userInfo.serviceEnd = dictionary[@"serviceEnd"];
        userInfo.userInfoIsPerfectForIOS = [dictionary[@"userInfoIsPerfectForIOS"] integerValue];
        userInfo.ifReceive = [dictionary[@"ifReceive"] integerValue];
        userInfo.account_status = [dictionary[@"account_status"] integerValue];
        
        userInfo.realName = dictionary[@"realName"]?:@"";
        userInfo.identityType = [dictionary[@"identityType"] integerValue];
        userInfo.sig = dictionary[@"sig"];
        
//        userInfo.ifGetTribe = [dictionary[@"ifGetTribe"] integerValue];


    }
    return userInfo;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self) {
        
        self.token          = [aDecoder decodeObjectForKey:kToken];
        self.mobileNumber   = [aDecoder decodeObjectForKey:kMobileNumber];
        self.password       = [aDecoder decodeObjectForKey:kPassword];
        self.fontScale           =  [aDecoder decodeFloatForKey:kFontScale];
        self.photoUrl       = [aDecoder decodeObjectForKey:@"photoUrl"]?:@"";
        self.userName       = [aDecoder decodeObjectForKey:@"userName"]?:@"";
        self.groupName       = [aDecoder decodeObjectForKey:@"groupName"]?:@"";
        self.coin       =  [aDecoder decodeIntegerForKey:@"coin"];
        self.credit       =  [aDecoder decodeIntegerForKey:@"credit"];
        self.cerStatus       =  [aDecoder decodeIntegerForKey:@"cerStatus"];
        self.level       =  [aDecoder decodeIntegerForKey:@"level"];
        self.levelName      = [aDecoder decodeObjectForKey:@"levelName"];
        self.userStatus       =  [aDecoder decodeIntegerForKey:@"userStatus"];
        self.haveDzCard       =  [aDecoder decodeIntegerForKey:@"haveDzCard"];
        self.userId       =  [aDecoder decodeIntegerForKey:@"id"];
        self.isShowCoin = [aDecoder decodeIntegerForKey:@"isShowCoin"];
        self.taskNum8 = [aDecoder decodeIntegerForKey:@"taskNum8"];
        self.totalGrowthValue = [aDecoder decodeIntegerForKey:@"totalGrowthValue"];
        self.updateLevelNeedValue          = [aDecoder decodeObjectForKey:@"updateLevelNeedValue"];
        self.growthValue          = [aDecoder decodeObjectForKey:@"growthValue"];
        self.cerStatus      =  [aDecoder decodeIntegerForKey:@"cerStatus"];
        self.userStatus     =  [aDecoder decodeIntegerForKey:@"userStatus"];
        self.activeStatus   =  [aDecoder decodeIntegerForKey:@"activeStatus"];
        self.updateLevelNeedValue = [aDecoder decodeObjectForKey:@"updateLevelNeedValue"];
        self.growthValue    = [aDecoder decodeObjectForKey:@"growthValue"];
        self.birthday    = [aDecoder decodeObjectForKey:@"birthday"];
        self.address     = [aDecoder decodeObjectForKey:@"address"];
        self.deviceToken     = [aDecoder decodeObjectForKey:@"deviceToken"];
        self.sex        = [aDecoder decodeIntegerForKey:@"sex"];
        
        self.isOpen  = [aDecoder decodeObjectForKey:kIsOpen];
        self.isHaveMasterman  = [aDecoder decodeObjectForKey:kIsHaveMasterman];
        self.perfectInfoType = [aDecoder decodeIntegerForKey:@"perfectInfoType"];
        self.userTarget       = [aDecoder decodeObjectForKey:@"userTarget"]?:@"";
        self.totalLearnTime   = [aDecoder decodeObjectForKey:@"totalLearnTime"]?:@"";
        self.phone = [aDecoder decodeObjectForKey:@"phone"] ? : @"";
        self.userInfoIsPerfect = [aDecoder decodeIntegerForKey:@"userInfoIsPerfect"];
        self.userHaveDiscipleNo = [aDecoder decodeIntegerForKey:@"userHaveDiscipleNo"];
        self.userInfoIsPerfectForIOS =  [aDecoder decodeIntegerForKey:@"userInfoIsPerfectForIOS"];
        self.ifReceive =  [aDecoder decodeIntegerForKey:@"ifReceive"];
        self.account_status =  [aDecoder decodeIntegerForKey:@"account_status"];
        self.identity = [aDecoder decodeIntegerForKey:@"identity"];
        self.userHaveAgreedTime = [aDecoder decodeIntegerForKey:@"userHaveAgreedTime"];
        self.serviceEnd = [aDecoder decodeObjectForKey:@"serviceEnd"];
        
        self.realName       = [aDecoder decodeObjectForKey:@"realName"]?:@"";
        self.identityType       =  [aDecoder decodeIntegerForKey:@"identityType"];
        self.sig     = [aDecoder decodeObjectForKey:@"sig"];
        
        self.ifGetTribe       =  [aDecoder decodeIntegerForKey:@"ifGetTribe"];


    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.token         forKey:kToken];
    [aCoder encodeFloat:self.fontScale      forKey:kFontScale];
    [aCoder encodeObject:self.mobileNumber  forKey:kMobileNumber];
    [aCoder encodeObject:self.password      forKey:kPassword];
    [aCoder encodeObject:self.photoUrl      forKey:@"photoUrl"];
    [aCoder encodeObject:self.userName      forKey:@"userName"];
    [aCoder encodeObject:self.groupName     forKey:@"groupName"];
    [aCoder encodeInteger:self.coin         forKey:@"coin"];
    [aCoder encodeInteger:self.credit       forKey:@"credit"];
    [aCoder encodeInteger:self.cerStatus    forKey:@"cerStatus"];
    [aCoder encodeObject:self.updateLevelNeedValue forKey:@"updateLevelNeedValue"];
    [aCoder encodeObject:self.growthValue   forKey:@"growthValue"];
    [aCoder encodeInteger:self.level        forKey:@"level"];
    [aCoder encodeObject:self.levelName     forKey:@"levelName"];
    [aCoder encodeInteger:self.userStatus   forKey:@"userStatus"];
    [aCoder encodeInteger:self.activeStatus forKey:@"activeStatus"];
    [aCoder encodeInteger:self.haveDzCard   forKey:@"haveDzCard"];
    [aCoder encodeInteger:self.userId       forKey:@"id"];
    [aCoder encodeInteger:self.isShowCoin forKey:@"isShowCoin"];
    [aCoder encodeInteger:self.taskNum8 forKey:@"taskNum8"];
    [aCoder encodeInteger:self.totalGrowthValue forKey:@"totalGrowthValue"];
    [aCoder encodeObject:self.birthday      forKey:@"birthday"];
    [aCoder encodeObject:self.address       forKey:@"address"];
    [aCoder encodeObject:self.deviceToken       forKey:@"deviceToken"];
    [aCoder encodeInteger:self.sex          forKey:@"sex"];
    [aCoder encodeObject:self.isOpen        forKey:kIsOpen];
    [aCoder encodeObject:self.isHaveMasterman  forKey:kIsHaveMasterman];
    [aCoder encodeObject:self.userTarget    forKey:@"userTarget"];
    [aCoder encodeObject:self.totalLearnTime forKey:@"totalLearnTime"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeInteger:self.perfectInfoType          forKey:@"perfectInfoType"];
    [aCoder encodeInteger:self.userInfoIsPerfect          forKey:@"userInfoIsPerfect"];
    [aCoder encodeInteger:self.userInfoIsPerfectForIOS          forKey:@"userInfoIsPerfectForIOS"];

    
    [aCoder encodeInteger:self.userHaveDiscipleNo          forKey:@"userHaveDiscipleNo"];
    [aCoder encodeInteger:self.ifReceive          forKey:@"ifReceive"];
    [aCoder encodeInteger:self.account_status          forKey:@"account_status"];
    [aCoder encodeInteger:self.identity          forKey:@"identity"];
    [aCoder encodeInteger:self.userHaveAgreedTime          forKey:@"userHaveAgreedTime"];
    [aCoder encodeObject:self.serviceEnd forKey:@"serviceEnd"];
    
    [aCoder encodeObject:self.realName forKey:@"realName"];
    [aCoder encodeInteger:self.identityType forKey:@"identityType"];
    [aCoder encodeObject:self.sig forKey:@"sig"];
    
    [aCoder encodeInteger:self.ifGetTribe forKey:@"ifGetTribe"];

}

@end
