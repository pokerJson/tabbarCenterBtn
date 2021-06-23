//
//  CPCustomWebViewController.m
//  cockpit
//
//  Created by dzc on 2021/5/14.
//

#import "CPCustomWebViewController.h"

@interface CPCustomWebViewController ()

@end

@implementation CPCustomWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webV = [[DGWebViewController alloc] init];
    self.webV.isHideNaviBar = YES;
    [self addChildViewController:self.webV];
    
}


@end
