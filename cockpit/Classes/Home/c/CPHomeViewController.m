//
//  CPHomeViewController.m
//  cockpit
//
//  Created by dzc on 2021/5/11.
//

#import "CPHomeViewController.h"

@interface CPHomeViewController ()


@end

@implementation CPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
//    self.webV = [[DGWebViewController alloc] init];
//    self.webV.isHideNaviBar = YES;
//    self.webV.urlString = [NSString stringWithFormat:@"%@%@",kMainH5Url_HTTP,kDepartmentComments];
//    [self addChildViewController:self.webV];
//    [self.view addSubview:self.webV.view];
//
    self.webV.urlString = [NSString stringWithFormat:@"%@%@",kMainH5Url_HTTP,kDepartmentComments];
    [self.view addSubview:self.webV.view];
    
    

}

- (void)click{
    DGWebViewController *webView = [[DGWebViewController alloc] init];
    webView.isHideNaviBar = YES;
    webView.urlString = [NSString stringWithFormat:@"%@%@",kMainH5Url_HTTP,@"useAgreement"];
    [self DG_Push:webView animated:YES];
}


@end
