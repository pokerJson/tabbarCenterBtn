//
//  DGSingleManager.h
//  DiscipleGroup
//
//  Created by maxudong on 2019/12/11.
//  Copyright © 2019 maxudong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DGBaseTabBarViewController.h"
#import "DGNavigationController.h"

/** 首页*/
#import "CPHomeViewController.h"
/** 学堂*/
#import "CPQuestionViewController.h"
/** 学习*/
#import "CPDataViewController.h"
/** 问答*/
#import "CPRankViewController.h"
/** 我的*/
#import "CPMineViewController.h"
/** 真正用到的vc*/
#import "CPMainVC.h"


NS_ASSUME_NONNULL_BEGIN

@interface DGSingleManager : NSObject

/** 单例类实例*/
+ (instancetype)singleInstance;

/** 底部桌面控制器*/
@property (nonatomic, strong) DGBaseTabBarViewController     *baseTabBarVC;

/** 导航控制器*/
@property (nonatomic, strong) DGNavigationController *mainNaviVC;

/** 首页*/
@property (nonatomic, strong) CPHomeViewController *homePageVC;

/** 学堂*/
@property (nonatomic, strong) CPQuestionViewController   *schoolVC;

/** 学习*/
@property (nonatomic, strong) CPDataViewController *studyPageVC;

/** 问答*/
@property (nonatomic, strong) CPRankViewController       *qaVC;

/** 我的*/
@property (nonatomic, strong) CPMineViewController     *mineVC;


/** 真正用到导航控制器*/
@property (nonatomic, strong) DGNavigationController *mainNav;
/** 真正用到的vc*/
@property (nonatomic, strong) CPMainVC     *mainVC;

@end

NS_ASSUME_NONNULL_END
