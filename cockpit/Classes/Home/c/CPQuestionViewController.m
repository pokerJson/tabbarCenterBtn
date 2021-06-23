//
//  CPQuestionViewController.m
//  cockpit
//
//  Created by dzc on 2021/5/11.
//

#import "CPQuestionViewController.h"

@interface CPQuestionViewController ()

@end

@implementation CPQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.webV.urlString = [NSString stringWithFormat:@"%@%@",kMainH5Url_HTTP,kQuestionAnswering];
    [self.view addSubview:self.webV.view];

}



@end
