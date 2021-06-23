//
//  CPMineViewController.m
//  cockpit
//
//  Created by dzc on 2021/5/11.
//

#import "CPMineViewController.h"

@interface CPMineViewController ()

@end

@implementation CPMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.webV.urlString = [NSString stringWithFormat:@"%@%@",kMainH5Url_HTTP,kPersonalCenter];
    [self.view addSubview:self.webV.view];
}


@end
