//
//  CPDataViewController.m
//  cockpit
//
//  Created by dzc on 2021/5/11.
//

#import "CPDataViewController.h"

@interface CPDataViewController ()

@end

@implementation CPDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.webV.urlString = [NSString stringWithFormat:@"%@%@",kMainH5Url_HTTP,kCharts];
    [self.view addSubview:self.webV.view];
}



@end
