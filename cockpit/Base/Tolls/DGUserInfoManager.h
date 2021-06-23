//
//  DGUserInfoManager.h
//  DiscipleGroup
//
//  Created by maxudong on 2019/12/11.
//  Copyright © 2019 maxudong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class DGUserInfo;

@interface DGUserInfoManager : NSObject

/**
 *  数据存入本地
 *
 *  @param userInfo 数据
 */
+ (void)archiveToFileWith:(__kindof DGUserInfo *)userInfo;

/**
 *  更新本地数据
 *
 *  @return userInfo 最新数据
 */
+ (__kindof DGUserInfo *)unarchive;

@end

NS_ASSUME_NONNULL_END
