//
//  MainTabBar.h
//  ThreePersonEducation
//
//  Created by maxudong on 2019/4/8.
//  Copyright © 2019 maxudong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MainTabBar;

@protocol MainTabBarDelegate <NSObject>

@optional

- (void)tabBar:(MainTabBar *)tabBar didSelectedButtonFrom:(long)fromBtnTag to:(long)toBtnTag;

- (void)tabBarClickWriteButton:(MainTabBar *)tabBar;
//是否可以跳转
- (BOOL)tabBarShouldSelectedButtonFrom:(long)fromBtnTag to:(long)toBtnTag;
@end

@interface MainTabBar : UIView

- (void)addTabBarButtonWithTabBarItem:(UITabBarItem *)tabBarItem;
- (void)selecedItemIndex:(NSInteger)index;
- (void)itemIndex:(NSInteger)index badgeCount:(NSString *)count;

//- (void)addTopLightGrayLine;

@property(nonatomic, weak)id <MainTabBarDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
