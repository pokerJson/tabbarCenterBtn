//
//  UIViewController+Expend.m
//  iWater
//
//  Created by Xudong.ma on 16/5/22.
//  Copyright © 2016年 Xudong.ma. All rights reserved.
//

#import "UIViewController+Expend.h"

@implementation UIViewController (Expend)

- (void)DG_Push:(UIViewController *)viewController animated:(BOOL)animated
{
    [self layOutDismissCoreAnimation];
    if ([self isKindOfClass:[UINavigationController class]])
    {
        if (viewController.hidesBottomBarWhenPushed == NO) {
            viewController.hidesBottomBarWhenPushed = YES;
        }
        UINavigationController *nav = (UINavigationController *) self;
        [nav pushViewController:viewController animated:animated];
    
    } else {
        
        if (viewController.hidesBottomBarWhenPushed == NO) {
            viewController.hidesBottomBarWhenPushed = YES;
        }
        /** 避免多次点击进入*/
        if ([self.navigationController.viewControllers lastObject] == self || self.navigationController.viewControllers.lastObject == self.parentViewController)
        {
            [self.navigationController pushViewController:viewController animated:animated];
        }
    }
}

- (void)DG_PresentVC:(UIViewController *)viewController
            animated:(BOOL)animated
          completion:(void (^ __nullable)(void))completion
{
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:viewController];
    //navi.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:navi animated:YES completion:^{
        completion();
    }];
}

- (void)DG_DismissVC:(UINavigationController *)naviVC
            animated:(BOOL)animated
          completion:(void (^ __nullable)(void))completion
{
    [naviVC dismissViewControllerAnimated:animated completion:^{
        completion();
    }];
}

- (void)DG_PopVC:(UINavigationController *)naviVC animated:(BOOL)animated
{
    [self layOutDismissCoreAnimation];
    [naviVC popViewControllerAnimated:animated];
}

- (void)DG_PopToVC:(UIViewController *)VC  naviVC:(UINavigationController *)naviVC animated:(BOOL)animated
{
    [self layOutDismissCoreAnimation];
    [naviVC popToViewController:VC animated:animated];
}

- (void)DG_PopToRootVC:(UINavigationController *)naviVC animated:(BOOL)animated
{
    [self layOutDismissCoreAnimation];
    [naviVC popToRootViewControllerAnimated:animated];
}

- (void)layOutDismissCoreAnimation
{
//    CATransition *animation = [CATransition animation];
//    animation.duration = 0.2;
//    animation.timingFunction = UIViewAnimationCurveEaseInOut;
//    animation.type = @"pageUnCurl";
//    animation.type = kCATransitionFade;
//    [self.view.window.layer addAnimation:animation forKey:nil];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


- (id)loadLocalJson:(NSString *)name {
    NSAssert(name.length != 0, @"传入文件不能为空");
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (!data) {return nil;}
    NSError *error = nil;
    id temp = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error) {return nil;};
    return temp;
}

@end
