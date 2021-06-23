//
//  DGWebViewController.m
//  DiscipleGroup
//
//  Created by maxudong on 2019/12/16.
//  Copyright © 2019 maxudong. All rights reserved.
//

#import "DGWebViewController.h"
#import <WebKit/WebKit.h>



@interface DGWebViewController () <WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) UIProgressView *progressView;
//加载hub

@property (nonatomic, copy) NSString *jumpeType;
@property (nonatomic, assign) BOOL hasData;

@property (nonatomic, assign) NSInteger  readTime;
@property BOOL hasLoaded;
@property BOOL isUploading;

@end

@implementation DGWebViewController



- (void)setTitleName:(NSString *)titleName
{
    _titleName = titleName;
}


- (void)setUrlString:(NSString *)urlString
{
    _urlString = urlString;
}

- (void)setDynamicGetH5Title:(BOOL)dynamicGetH5Title
{
    _dynamicGetH5Title = dynamicGetH5Title;
}

- (void)setIsHideNaviBar:(BOOL)isHideNaviBar
{
    _isHideNaviBar = isHideNaviBar;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.wkWebView removeObserver:self forKeyPath:@"title" context:nil];
}

- (void)backButtonClickedAction:(UIBarButtonItem *)buttonItem
{
    
    
   
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationWhenNetworkingConnectFailed) name:@"NetworkingConnectFailed" object:nil];
    //先清缓存 解决进来加载不出来
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
    }];
    
    self.navigationItem.title = _titleName;
    

      
    self.view.backgroundColor = [UIColor whiteColor];
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.allowsInlineMediaPlayback = YES;
    WKPreferences *preference = [[WKPreferences alloc] init];
    configuration.preferences = preference;
    configuration.selectionGranularity = YES;
    CGFloat height = 0;
    if (_isHideNaviBar && isMoreThan_IPHONE_X) {
//        height = StateBarHeight-20;
    }
    self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, SCREEN_HEIGHT - kNAVBAR_HEIGHT) configuration:configuration];
#pragma mark - navigator.userAgent
//    if (!kStringIsEmpty(self.fromSource)) {//只有资讯才设置 navigator.userAgent
//        [self.wkWebView setCustomUserAgent:@"dzqiosapp"];//设置app内打开资讯 不要显示下载app
//    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    [self.wkWebView loadRequest:request];
    self.wkWebView.backgroundColor = [UIColor clearColor];
    self.wkWebView.opaque = NO;
    self.wkWebView.navigationDelegate = self;
    self.wkWebView.UIDelegate = self;
    self.wkWebView.scrollView.showsVerticalScrollIndicator   = NO;
    self.wkWebView.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.wkWebView];
    

    
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
   CGRect  rect = CGRectZero;
   rect.size.width = [[UIScreen mainScreen] bounds].size.width;
   rect.size.height = 2;
   self.progressView = [[UIProgressView alloc] initWithFrame:rect];
   self.progressView.progressTintColor = [UIColor colorWithHexStr:@"#C6924C"];
   [self.progressView setProgressViewStyle:UIProgressViewStyleDefault];
   [self.view addSubview:_progressView];
    
    [self.wkWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    
    self.wkWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;

    
}
-(void)backButtonClick{
    

}
#pragma mark -
#pragma mark - 没网的检测
- (void)notificationWhenNetworkingConnectFailed{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    
    [self.wkWebView.configuration.userContentController addScriptMessageHandler:self name:@"getToken"];
    [self.wkWebView.configuration.userContentController addScriptMessageHandler:self name:@"exitUser"];
//    [self.wkWebView.configuration.userContentController addScriptMessageHandler:self name:@"getVersion"];
//    [self.wkWebView.configuration.userContentController addScriptMessageHandler:self name:@"goPath"];
//    [self.wkWebView.configuration.userContentController addScriptMessageHandler:self name:@"toHomePage"];
//    [self.wkWebView.configuration.userContentController addScriptMessageHandler:self name:@"finishPage"];
//    [self.wkWebView.configuration.userContentController addScriptMessageHandler:self name:@"toClassicCoursePage"];
//    [self.wkWebView.configuration.userContentController addScriptMessageHandler:self name:@"finishClassicCourse"];
//    [self.wkWebView.configuration.userContentController addScriptMessageHandler:self name:@"toSixLawsModelPage"];
//    [self.wkWebView.configuration.userContentController addScriptMessageHandler:self name:@"teacherQuotations"];
//    [self.wkWebView.configuration.userContentController addScriptMessageHandler:self name:@"userStatePopup"];
//    [self.wkWebView.configuration.userContentController addScriptMessageHandler:self name:@"saveInfoImg"];


   
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
        [self.wkWebView changeHeight:SCREEN_HEIGHT - kNAVBAR_HEIGHT];
    
    if (_isHideNaviBar) {
        if ( isMoreThan_IPHONE_X) {
            [self.wkWebView changeHeight:SCREEN_HEIGHT];
        }else{
            [self.wkWebView changeHeight:SCREEN_HEIGHT];
        }
        self.navigationController.navigationBar.hidden = _isHideNaviBar;
    } else {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"getToken"];
    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"exitUser"];
//    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"getVersion"];
//    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"goPath"];
//    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"iosModel"];
//    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"toHomePage"];
//    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"finishPage"];
//    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"toClassicCoursePage"];
//    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"finishClassicCourse"];
//    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"toSixLawsModelPage"];
//    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"teacherQuotations"];
//    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"userStatePopup"];
//    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"saveInfoImg"];
//
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    
}





/** 设置进度条*/
#pragma mark - KVC and KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([@"estimatedProgress" isEqualToString:keyPath]) {
        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:YES];
    }
    
    if (self.progressView.progress == 0) {
        self.progressView.hidden = NO;
    } else if (self.progressView.progress == 1) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.progressView.progress == 1) {
                self.progressView.progress = 0;
                self.progressView.hidden = YES;
            }
        });
    }
    
    if (self.dynamicGetH5Title) {
        if ([keyPath isEqualToString:@"title"]) {
            if (object == self.wkWebView)
            {
                self.navigationItem.title = self.wkWebView.title;
            }
            else {
                [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
            }
        }
    }
}
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    [_wkWebView reload];
}
//WKScriptMessageHandler协议方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    //当传过值来就说明加载了
#pragma mark - 代表已经加载好了 隐藏视图 显示返回按钮
    self.hasData = YES;
    if (!self.isHideNaviBar) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(0, 0, 40, 40);
        [backBtn setImage:[UIImage imageNamed:@"new_btn_back"] forState:UIControlStateNormal];
        [backBtn setContentEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
        [backBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
        [backBtn addTarget:self action:@selector(backButtonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
    
    // message.body 即为JS向OC传的值
    id body = message.body;
    DGLog(@"JS向OC传的值=== %@", message.name);
    if ([message.name isEqualToString:@"goPath"]) {
        
        NSMutableDictionary *dict = (NSMutableDictionary *)body;
        if (!kDictIsEmpty(dict)) {
            NSString *type = dict[@"type"];
        }
        //
    }else if([message.name isEqualToString:@"getToken"]){
        [self getToken];
    }else if([message.name isEqualToString:@"exitUser"]){
        //退出登录
        DGUserInfo *userInfo = [DGUserInfoManager unarchive];
        userInfo.token = @"";
        [DGUserInfoManager archiveToFileWith:userInfo];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@""]];
        [self.wkWebView loadRequest:request];
        //弹出登录页
        [DGTools checkLoginWithIsOnlyNoramal:kIsNoramlLogin];
    }
}
- (void)getToken
{
    DGUserInfo *userInfo = [DGUserInfoManager unarchive];
    NSMutableDictionary *finalDict = @{
        @"token":userInfo.token ? userInfo.token : @"",
    }.mutableCopy;
    
    NSString *jsonStr = [finalDict mj_JSONString];
    NSString *jsStr = [NSString stringWithFormat:@"getToken('%@')",jsonStr];
    [self.wkWebView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        DGLog(@"%@---js调用oc方法getToken----%@",result, error);
    }];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    DGLog(@"web视图加载内容时发生错误:%@", error);
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    DGLog(@"开始加载网页内容,URL:%@", webView.URL);
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler

{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
