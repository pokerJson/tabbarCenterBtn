//
//  DGBaseTabBarViewController.h
//  DiscipleGroup
//
//  Created by maxudong on 2019/11/18.
//  Copyright © 2019 maxudong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainTabBar;
NS_ASSUME_NONNULL_BEGIN

@interface DGBaseTabBarViewController : UITabBarController

- (void)selecedItemIndex:(NSInteger)index;
- (void)itemIndex:(NSInteger)index badgeCount:(NSString *)count;
- (NSArray *)barFrameInMainTabar;
@property (nonatomic, strong) MainTabBar *mainTabBar;
@end

NS_ASSUME_NONNULL_END
