//
//  CPLoginViewController.m
//  cockpit
//
//  Created by dzc on 2021/5/14.
//

#import "CPLoginViewController.h"
#import "CPPhoneInputView.h"
#import "CPPasswordInputView.h"


@interface CPLoginViewController ()
@property (nonatomic,strong) UIImageView *bgImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) CPPhoneInputView *phoneInputV;
@property (nonatomic,strong) CPPasswordInputView *passwordInputV;
@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) UIButton *otherLoginBtn;
@property (nonatomic,strong) UILabel *bottomLabel;
//@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation CPLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.bgImageView];

//
//    //返回键
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(12, kSTATUSBAR_HEIGHT, 40, 40);
//    [backBtn setImage:[UIImage imageNamed:@"new_btn_back"] forState:UIControlStateNormal];
//    [backBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
//    [backBtn addTarget:self action:@selector(backButtonClickedAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.bgImageView addSubview:backBtn];
       
    //标题
    [self.bgImageView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgImageView).mas_offset(15);
        make.right.mas_equalTo(self.bgImageView).mas_offset(-15);
        make.top.mas_equalTo(self.bgImageView).mas_offset(158);
        make.height.mas_equalTo(30);
    }];
    
    //手机号
    [self.bgImageView addSubview:self.phoneInputV];
    self.phoneInputV.isPhoneLogin = NO;
    [self.phoneInputV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgImageView).mas_offset(15);
        make.right.mas_equalTo(self.bgImageView).mas_offset(-15);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(38);
        make.height.mas_equalTo(47);
    }];
    
    //密码
    [self.bgImageView addSubview:self.passwordInputV];
    self.passwordInputV.isSendCode = NO;
    [self.passwordInputV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgImageView).mas_offset(15);
        make.right.mas_equalTo(self.bgImageView).mas_offset(-15);
        make.top.mas_equalTo(self.phoneInputV.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(47);
    }];
    
    //登录
    [self.bgImageView addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgImageView).mas_offset(22);
        make.right.mas_equalTo(self.bgImageView).mas_offset(-22);
        make.top.mas_equalTo(self.passwordInputV.mas_bottom).mas_offset(36);
        make.height.mas_equalTo(47);
    }];
    
    //其他登录
    [self.bgImageView addSubview:self.otherLoginBtn];
    self.otherLoginBtn.hidden = YES;
    [self.otherLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgImageView).mas_offset(50);
        make.right.mas_equalTo(self.bgImageView).mas_offset(-50);
        make.top.mas_equalTo(self.loginBtn.mas_bottom).mas_offset(22);
        make.height.mas_equalTo(30);
    }];
    
    //最下面
    [self.bgImageView addSubview:self.bottomLabel];
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgImageView).mas_offset(50);
        make.right.mas_equalTo(self.bgImageView).mas_offset(-50);
        make.bottom.mas_equalTo(self.bgImageView).mas_offset(-42);
        make.height.mas_equalTo(40);
    }];
}
#pragma mark -
#pragma mark - 点击返回 这里强制登录 后期自己改
- (void)backButtonClickedAction{
    [self dismissViewControllerAnimated:YES completion:^{
        [DGTools checkLoginWithIsOnlyNoramal:YES];
    }];
}
- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [UIImageView new];
        _bgImageView.frame = self.view.bounds;
        _bgImageView.image = [UIImage imageNamed:@"loginBG"];
        _bgImageView.userInteractionEnabled = YES;
    }
    return  _bgImageView;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"欢迎来到启智链";
        _titleLabel.font = [UIFont boldSystemFontOfSize:21];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return  _titleLabel;;
}
- (CPPhoneInputView *)phoneInputV{
    if (!_phoneInputV) {
        _phoneInputV = [[CPPhoneInputView alloc]init];
    }
    return  _phoneInputV;
}
- (CPPasswordInputView *)passwordInputV{
    if (!_passwordInputV) {
        _passwordInputV = [[CPPasswordInputView alloc]init];
    }
    return  _passwordInputV;
}
- (UIButton *)loginBtn{
    WeakSelf(weakSelf);
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.layer.cornerRadius = 20;
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor colorWithHexStr:@"#224188"] forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = CPFont(14);
        [_loginBtn addTapHadnle:^{
            DGLog(@"登录点击");
            NSDictionary *para = @{@"loginType":@3,
                                   @"username":weakSelf.phoneInputV.phoneTf.text,
                                   @"password":weakSelf.passwordInputV.codeTf.text,
                                   @"source":@3};
            [[RequestAPIClient APIClientInstance] sendJsonRequestPath:kLoginUrl params:para method:Post_Method success:^(id  _Nonnull responseObject) {
                DGLog(@"%@",responseObject);
                if ([responseObject[@"code"] intValue] == 200) {
                    [DGTools showInfo:@"登录成功"];
                    DGUserInfo *user = [DGUserInfoManager unarchive];
                    user.token = responseObject[@"token"];
                    [DGUserInfoManager archiveToFileWith:user];
                    [weakSelf popOrDismissSelfWithAnimated:YES completed:^{
//                        [UIApplication sharedApplication].keyWindow.rootViewController = [DGSingleManager singleInstance].mainNav;

                        [[RequestAPIClient APIClientInstance] sendJsonRequestPath:kCheckState params:@{} method:Get_Method success:^(id  _Nonnull responseObject) {
                            DGLog(@"==%@",responseObject);
                            if ([responseObject[@"code"] intValue] == 200) {
                                NSArray *arr = responseObject[@"data"];
                                BOOL isHide = [arr.firstObject[@"dictValue"] intValue] == 1;//2-未审核，1-审核中
                                if (isHide) {
                                    [UIApplication sharedApplication].keyWindow.rootViewController = [DGSingleManager singleInstance].baseTabBarVC;
                                }else{
                                    [UIApplication sharedApplication].keyWindow.rootViewController = [DGSingleManager singleInstance].mainNav;
                                }
                            }else{
                            }
                        } failure:^(id  _Nonnull responseObject) {
                        }];
                    }];
                }else{
                    [DGTools showInfo:responseObject[@"msg"]];
                }
            } failure:^(id  _Nonnull responseObject) {
                
            }];
                    
        }];
        _loginBtn.backgroundColor = [UIColor whiteColor];
    }
    return  _loginBtn;
}
- (UIButton *)otherLoginBtn{
    if (!_otherLoginBtn) {
        _otherLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_otherLoginBtn setTitle:@"其他登录方式" forState:UIControlStateNormal];
        [_otherLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _otherLoginBtn.titleLabel.font = CPFont(14);
        _otherLoginBtn.backgroundColor = [UIColor clearColor];
    }
    return  _otherLoginBtn;
}
- (UILabel *)bottomLabel{
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc]init];
        _bottomLabel.numberOfLines = 0;
        _bottomLabel.font = [UIFont boldSystemFontOfSize:13];
        _bottomLabel.textColor = [UIColor whiteColor];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"Copyright © 2018 2014-2021\n普华商业集团有限公司" attributes: @{NSFontAttributeName: [UIFont boldSystemFontOfSize:13],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];

        _bottomLabel.attributedText = string;
    }
    return  _bottomLabel;;
}
@end
