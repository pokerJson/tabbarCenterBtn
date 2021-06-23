// Copyright © 2020 PeoGooCore. All rights reserved.

#import <UIKit/UIKit.h>

typedef void(^CompletedBlcok)(void);

@interface UIViewController (Helper)


// General
- (void)showViewController:(UIViewController *)vc animated:(BOOL)animated;
/// Sets the next view controller's back button title to "Back"
- (void)setNextViewControllerBackButtonTitleToGeneric;
/// Sets the next view controller's back button title to your custom string.
- (void)setNextViewControllersBackButtonTitle:(NSString *)backButtonTitle;
- (void)setCustomBackButtonAction:(SEL)action;
+ (UIViewController *)currentViewController;

//弹出自己系统的登录页
- (void)showSignInVC;

- (void)popOrDismissSelfWithAnimated:(BOOL)animated completed:(CompletedBlcok)block;

@end
