//
//  CPRankViewController.m
//  cockpit
//
//  Created by dzc on 2021/5/11.
//

#import "CPRankViewController.h"

@interface CPRankViewController ()

@end

@implementation CPRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.webV.urlString = [NSString stringWithFormat:@"%@%@",kMainH5Url_HTTP,kRankingList];
    [self.view addSubview:self.webV.view];
}



@end
