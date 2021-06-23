//
//  CPMainVC.m
//  cockpit
//
//  Created by dzc on 2021/5/19.
//

#import "CPMainVC.h"
#import "CPShowUpdateView.h"

@interface CPMainVC ()

@end

@implementation CPMainVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.webV.urlString = [NSString stringWithFormat:@"%@%@",kMainH5Url_HTTP,kDepartmentComments];
    [self.view addSubview:self.webV.view];

    
    [self getUpdateVersion];
   
}

- (void)getUpdateVersion{
    NSMutableDictionary *dict = @{}.mutableCopy;
    
    [[RequestAPIClient APIClientInstance] sendRequestPath:kVersionUpgrade params:dict method:Post_Method success:^(id  _Nonnull responseObject) {
       
        if (0 == [responseObject[@"code"] integerValue]) {
            [CPShowUpdateView showUpdateViewWith:self.view call:^{
                DGLog(@"去升级");
            }];
//            self.upgradModel = [DGUpgradModel mj_objectWithKeyValues:responseObject[@"data"]];
//            NSString *iosVersionName = [self.upgradModel.iosVersionName ? self.upgradModel.iosVersionName : @"" stringByReplacingOccurrencesOfString:@"." withString:@""];
//            NSString *localVersion = [kCurrentAppVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
            
//            if ([iosVersionName integerValue] > [localVersion integerValue]) {
//              //有版本升级弹框 则广告弹框不弹 就不调-->广告接口 [self showAdAlertView]
//                [[DGAlertHandler shareInstance] showAppUpdateContent:@[self.upgradModel.iosUpdateDescription ? self.upgradModel.iosUpdateDescription : @""] titleStr:[NSString stringWithFormat:@"发现新版本%@",self.upgradModel.iosVersionName] forceUpdate:YES confirmBlock:^{
//                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"mask_show"];//升级成功后 蒙板重新弹
//                    [[NSUserDefaults standardUserDefaults] synchronize];
//                        NSURL *url = [NSURL URLWithString:self.upgradModel.iosApkUrl];
//                        if([[UIApplication sharedApplication] canOpenURL:url]) {
//                            [[UIApplication sharedApplication] openURL:url];
//                        }
//
//                    } cancelBlock:^{
//
//                    }];
//
//            } else {
//            }
        } else {
        }
        
    } failure:^(id  _Nonnull responseObject) {
    }];
}

@end
