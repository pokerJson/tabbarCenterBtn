//
//  UIViewController+Expend.h
//  iWater
//
//  Created by Xudong.ma on 16/5/22.
//  Copyright © 2016年 Xudong.ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Expend)

/**
 *   Push视图 (避免多次点击进入)
 */
- (void)DG_Push:(__kindof UIViewController * _Nullable)viewController
       animated:(BOOL)animated;

/**
 *  模态视图
 */
- (void)DG_PresentVC:(UIViewController *_Nullable)viewController
            animated:(BOOL)animated
          completion:(void (^ __nullable)(void))completion;

/**
 *  模态视图消失
 */
- (void)DG_DismissVC:( UINavigationController * _Nullable)naviVC
            animated:(BOOL)animated
          completion:(void (^ __nullable)(void))completion;

/**
 *  Pop视图(带自定义动画)返回到上一级
 */
- (void)DG_PopVC:(UINavigationController *_Nullable)naviVC
        animated:(BOOL)animated;

/**
 *  Pop视图(带自定义动画)pop到指定视图控制器
 */
- (void)DG_PopToVC:(UIViewController *_Nullable)VC
            naviVC:(UINavigationController *_Nullable)naviVC
          animated:(BOOL)animated;

/**
 *  Pop视图(带自定义动画)pop到根视图控制器
 */
- (void)DG_PopToRootVC:(UINavigationController *_Nullable)naviVC
              animated:(BOOL)animated;


/// 获取本机 JSON 文件数据
- (id)loadLocalJson:(NSString *)name;
@end
