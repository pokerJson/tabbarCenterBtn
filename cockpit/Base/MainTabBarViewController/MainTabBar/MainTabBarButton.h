//
//  MainTabBarButton.h
//  ThreePersonEducation
//
//  Created by maxudong on 2019/4/8.
//  Copyright © 2019 maxudong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainTabBarButton : UIButton

@property (nonatomic, strong) UITabBarItem *tabBarItem;
@property (nonatomic, copy) NSString *badgeCount;

@end

NS_ASSUME_NONNULL_END
