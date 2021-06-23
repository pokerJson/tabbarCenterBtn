//
//  DGNavigationController.m
//  DiscipleGroup
//
//  Created by maxudong on 2019/11/18.
//  Copyright © 2019 maxudong. All rights reserved.
//

#import "DGNavigationController.h"

@interface DGNavigationController ()<UINavigationControllerDelegate>

@end

@implementation DGNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.enabled = NO;
    self.delegate = self;
    
    self.navigationController.navigationBarHidden = YES;
    self.navigationBarHidden = YES;
}

// UINavigationControllerDelegate
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.hidesBottomBarWhenPushed = self.childViewControllers.count == 1;
    [super pushViewController:viewController animated:animated];
}

@end
