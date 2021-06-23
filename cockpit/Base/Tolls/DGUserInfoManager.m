//
//  DGUserInfoManager.m
//  DiscipleGroup
//
//  Created by maxudong on 2019/12/11.
//  Copyright © 2019 maxudong. All rights reserved.
//

#import "DGUserInfoManager.h"

@implementation DGUserInfoManager

/**
 *  数据存入本地
 *
 *  @param userInfo 数据
 */
+ (void)archiveToFileWith:(__kindof DGUserInfo *)userInfo
{
    NSString *path = [kDocumentPath stringByAppendingString:@"DGUserInfo.data"];
    [NSKeyedArchiver archiveRootObject:userInfo toFile:path];
}

/**
 *  更新本地数据
 *
 *  @return userInfo 最新数据
 */
+ (__kindof DGUserInfo*)unarchive
{
    NSString *path = [kDocumentPath stringByAppendingString:@"DGUserInfo.data"];
    DGUserInfo *userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (!userInfo) {
        userInfo = [DGUserInfo instance];
        [DGUserInfoManager archiveToFileWith:userInfo];
    }
    
    return userInfo;
}

@end
