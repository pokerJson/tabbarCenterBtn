//
//  AppDelegate.m
//  cockpit
//
//  Created by dzc on 2021/5/11.
//

#import "AppDelegate.h"
#import "CPXXXXXViewController.h"

//审核block
typedef void(^AppIsNowCheckingBlock)(void);
typedef void(^AppNotCheckedBlock)(void);

@interface AppDelegate ()

@end

@implementation AppDelegate

- (UIWindow *)window
{
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.backgroundColor = [UIColor whiteColor];
    }
    return _window;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window.rootViewController = [DGSingleManager singleInstance].baseTabBarVC;

    [self.window makeKeyAndVisible];
    
    if (@available(iOS 13.0, *)) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDarkContent;
    } else {
        // Fallback on earlier versions
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
    
    return YES;
}
- (void)appNowChecking:(AppIsNowCheckingBlock)nowCheckingBlock withNotChecked:(AppNotCheckedBlock)notCheckedlock{
//    notCheckedlock();
    [[RequestAPIClient APIClientInstance] sendJsonRequestPath:kCheckState params:@{} method:Get_Method success:^(id  _Nonnull responseObject) {
        DGLog(@"==%@",responseObject);
        if ([responseObject[@"code"] intValue] == 200) {
            NSArray *arr = responseObject[@"data"];
            BOOL isHide = [arr.firstObject[@"dictValue"] intValue] == 1;//2-未审核，1-审核中
            isHide ? nowCheckingBlock() : notCheckedlock();
        }else{
        }
    } failure:^(id  _Nonnull responseObject) {
        nowCheckingBlock();
    }];
}
// 极光 一键登录
- (void)configQuickLogin {
//    JVAuthConfig *config = [[JVAuthConfig alloc] init];
//    config.appKey = JG_AppKey;
//    config.authBlock = ^(NSDictionary *result) {
//        NSLog(@"初始化结果 result:%@", result);
//    };
//    [JVERIFICATIONService setupWithConfig:config];
//    [JVERIFICATIONService preLogin:60 completion:^(NSDictionary *result) {
//        NSLog(@"登录预取号 result:%@", result);
//    }];
//    [DGTools jgCustomView];

}


@end
