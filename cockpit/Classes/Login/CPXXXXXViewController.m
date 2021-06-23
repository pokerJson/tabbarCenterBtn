//
//  CPXXXXXViewController.m
//  cockpit
//
//  Created by dzc on 2021/5/14.
//

#import "CPXXXXXViewController.h"

@interface CPXXXXXViewController ()

@end

@implementation CPXXXXXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //强制登录 这里做判断弹出登录页
    [DGTools checkLoginWithIsOnlyNoramal:kIsNoramlLogin];
}


@end
