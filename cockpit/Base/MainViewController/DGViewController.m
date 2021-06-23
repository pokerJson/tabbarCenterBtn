//
//  DGViewController.m
//  DiscipleGroup
//
//  Created by maxudong on 2019/11/18.
//  Copyright © 2019 maxudong. All rights reserved.
//

#import "DGViewController.h"

@interface DGViewController ()

/** 返回按钮*/
@property (nonatomic, strong) UIBarButtonItem *backBarButtonItem;

@end

@implementation DGViewController

#pragma mark -
#pragma mark - LazyLoading

#pragma mark -
#pragma mark - Set_Method

#pragma mark -
#pragma mark - ViewLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self instanceBaseSubViews];
    
   
}

- (void)kSubVCViewWillAppear{
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    
    if (@available(iOS 13.0, *)) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDarkContent;
    } else {
        // Fallback on earlier versions
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark -
#pragma mark - SystemMethod

- (void)dealloc
{
    
}

#pragma mark -
#pragma mark - InitializeMethod

- (void)instanceBaseSubViews
{
//    self.view.backgroundColor = [UIColor colorWithHexStr:@"#ffffff"];
//    if (_isClose) {
//        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        backBtn.frame = CGRectMake(0, 0, 40, 40);
//        [backBtn setImage:[UIImage imageNamed:@"result_btn_close"] forState:UIControlStateNormal];
//        [backBtn setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
//        [backBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
//        [backBtn addTarget:self action:@selector(backButtonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//        self.navigationItem.leftBarButtonItem = leftItem;
//        return;
//    }
//
//    if (self.navigationController.viewControllers.count > 1) {
//        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        backBtn.frame = CGRectMake(0, 0, 40, 40);
//        [backBtn setImage:[UIImage imageNamed:@"new_btn_back"] forState:UIControlStateNormal];
//        [backBtn setContentEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
//        [backBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
//        [backBtn addTarget:self action:@selector(backButtonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//        self.navigationItem.leftBarButtonItem = leftItem;
//    }
}

#pragma mark -
#pragma mark - PersonalMethod

- (void)setBaseLeftBarButtonItem
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"mineHomePage_btn_back"] forState:UIControlStateNormal];
    [backBtn setContentEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [backBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    [backBtn addTarget:self action:@selector(backButtonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
}

#pragma mark -
#pragma mark - ButtonClickMethod

- (void)backButtonClickedAction:(UIBarButtonItem *)buttonItem
{
    [self DG_PopVC:self.navigationController animated:YES];
}

#pragma mark -
#pragma mark - GestureRecognizerMethod

#pragma mark -
#pragma mark - NotificationMethod

#pragma mark -
#pragma mark - ...Delegate/DataSourceMethod

#pragma mark -
#pragma mark - NetworkHandlerMethod

#pragma mark - 屏幕方向控制

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
