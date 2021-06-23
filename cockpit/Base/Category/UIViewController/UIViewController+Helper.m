// Copyright © 2020 PeoGooCore. All rights reserved.

#import "UIViewController+Helper.h"

@implementation UIViewController (Helper)

// MARK: General
- (void)showViewController:(UIViewController *)viewControllerToShow animated:(BOOL)animated {
    if (!([self.navigationController.viewControllers.lastObject isEqual:self] || [self.navigationController.viewControllers.lastObject isEqual:self.parentViewController])) {
        DGLog(@"禁止重复 Push!!!");
    } else {
        viewControllerToShow.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewControllerToShow animated:animated];
    }
}

- (void)setNextViewControllerBackButtonTitleToGeneric {
    [self setNextViewControllersBackButtonTitle:NSLocalizedString(@"Back", nil)];
}

- (void)setNextViewControllersBackButtonTitle:(NSString *)backButtonTitle {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:backButtonTitle style:UIBarButtonItemStylePlain target:nil action:nil];
}


- (void)showSignInVC{
    CPLoginViewController *login = [CPLoginViewController new];
    DGNavigationController *nav = [[DGNavigationController alloc]initWithRootViewController:login];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}

- (void)popOrDismissSelfWithAnimated:(BOOL)animated completed:(CompletedBlcok)block{
    if (self.navigationController != nil && [self.navigationController.viewControllers indexOfObject:self] > 0) {
        [self.navigationController popToViewController:self.navigationController.viewControllers[[self.navigationController.viewControllers indexOfObject:self] - 1] animated:animated];
    }else{
        [self.presentingViewController dismissViewControllerAnimated:animated completion:block];
    }
}

+ (UIViewController *)findBestViewController:(UIViewController *)vc {

    if (vc.presentedViewController) {

        // Return presented view controller
        return [UIViewController findBestViewController:vc.presentedViewController];

    } else if ([vc isKindOfClass:UISplitViewController.class]) {

        // Return right hand side
        UISplitViewController *svc = (UISplitViewController *) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;

    } else if ([vc isKindOfClass:UINavigationController.class]) {

        // Return top view
        UINavigationController *svc = (UINavigationController *) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.topViewController];
        else
            return vc;

    } else if ([vc isKindOfClass:UITabBarController.class]) {

        // Return visible view
        UITabBarController *svc = (UITabBarController *) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.selectedViewController];
        else
            return vc;

    } else {
        // Unknown view controller type, return last child view controller
        return vc;

    }
}

+ (UIViewController *)currentViewController {
    // Find best view controller
    UIViewController *viewController = [[UIApplication sharedApplication].delegate window].rootViewController;
    return [UIViewController findBestViewController:viewController];
}



@end
