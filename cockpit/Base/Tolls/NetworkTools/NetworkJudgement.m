//
//  NetworkJudgement.m
//  iWater
//
//  Created by Xudong.ma on 16/5/11.
//  Copyright © 2016年 Xudong.ma. All rights reserved.
//

#import "NetworkJudgement.h"
#import "AFNetworking.h"
#import "DGTools.h"
@implementation NetworkJudgement

+ (__kindof NetworkJudgement *)defaultInstance
{
    static NetworkJudgement *networkJudgement = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        networkJudgement = [[NetworkJudgement alloc] init];
    });
    
    return networkJudgement;
}

- (BOOL)networkRechablity
{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

- (void)judgeNetWorkIsAvailable
{
    /**
     *  获得网络监控的管理者
     */
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /**
     *  设置网络状态改变后的处理 (当网络状态发生变化会自动调用下面block)
     */
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
                
            case AFNetworkReachabilityStatusUnknown:
                
//                postNotificationWhenNetworkingConnectFailed();
                [[NSNotificationCenter defaultCenter]postNotificationName:@"NetworkingConnectFailed" object:nil];

                DGLog(@"未知网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                [DGTools showInfo:@"网络已断开"];
//                postNotificationWhenNetworkingConnectFailed();
                [[NSNotificationCenter defaultCenter]postNotificationName:@"NetworkingConnectFailed" object:nil];
                
                DGLog(@"没有网络(断网)");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                
                DGLog(@"wifi");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                
                DGLog(@"手机自带网络");
                break;
        }
    }];
    
    /**
     *  开始监听
     */
    [manager startMonitoring];
}

@end
