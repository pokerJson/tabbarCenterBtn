//
//  CPPasswordInputView.m
//  cockpit
//
//  Created by dzc on 2021/5/19.
//

#import "CPPasswordInputView.h"


@interface CPPasswordInputView()


@end
@implementation CPPasswordInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 20;
        self.backgroundColor = RGBA(255, 255, 255, 0.25);
        [self addView];
        [_codeTf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(28);
            make.top.bottom.mas_equalTo(self);
            make.right.mas_equalTo(self).mas_offset(-10);
        }];
        [_sendCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self);
            make.right.mas_equalTo(self).mas_offset(-22);
            make.width.mas_equalTo(80);
        }];
    }
    return self;
}
- (void)addView{
    _codeTf = [[UITextField alloc]init];
    _codeTf.textColor = [UIColor whiteColor];
    [self addSubview:_codeTf];
    
    _sendCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [_sendCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sendCodeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_sendCodeBtn];
    
}
- (void)setIsSendCode:(BOOL)isSendCode{
    [_codeTf setPlaceholder:isSendCode ? @"请输入验证码" : @"请输入密码" WithColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:15]];
    _sendCodeBtn.hidden = !isSendCode;
    _codeTf.secureTextEntry = isSendCode ? NO : YES;
}
@end
