//
//  DGSingleManager.m
//  DiscipleGroup
//
//  Created by maxudong on 2019/12/11.
//  Copyright © 2019 maxudong. All rights reserved.
//

#import "DGSingleManager.h"

@implementation DGSingleManager

/** 单例类实例*/
+ (instancetype)singleInstance
{
    static DGSingleManager *singleManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        singleManager = [[DGSingleManager alloc] init];
    });
    
    return singleManager;
}

- (DGBaseTabBarViewController *)baseTabBarVC
{
    if (!_baseTabBarVC) {
        
        _baseTabBarVC = [[DGBaseTabBarViewController alloc] init];
    }
    
    return _baseTabBarVC;
}

- (DGNavigationController *)mainNaviVC
{
    if (!_mainNaviVC) {
        
        _mainNaviVC = [[DGNavigationController alloc] init];
    }
    
    return _mainNaviVC;
}

- (CPHomeViewController *)homePageVC
{
    if (!_homePageVC) {
        
        _homePageVC = [[CPHomeViewController alloc] init];
    }
    
    return _homePageVC;
}

- (CPQuestionViewController *)schoolVC
{
    if (!_schoolVC) {
        
        _schoolVC = [[CPQuestionViewController alloc] init];
    }
    
    return _schoolVC;
}

- (CPDataViewController *)studyPageVC
{
    if (!_studyPageVC) {
        
        _studyPageVC = [[CPDataViewController alloc] init];
    }
    
    return _studyPageVC;
}


- (CPRankViewController *)qaVC
{
    if (!_qaVC) {
        
        _qaVC = [[CPRankViewController alloc] init];
    }
    
    return _qaVC;
}

- (CPMineViewController *)mineVC
{
    if (!_mineVC) {
        
        _mineVC = [[CPMineViewController alloc] init];
    }
    
    return _mineVC;
}
- (DGNavigationController *)mainNav
{
//    if (!_mainNav) {
        
        _mainNav = [[DGNavigationController alloc] initWithRootViewController:self.mainVC];
//    }
    
    return _mainNav;
}
- (CPMainVC *)mainVC
{
//    if (!_mainVC) {
        
        _mainVC = [[CPMainVC alloc] init];
//    }
    
    return _mainVC;
}
@end
