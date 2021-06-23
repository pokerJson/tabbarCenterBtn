//
//  CPPhoneInputView.m
//  cockpit
//
//  Created by dzc on 2021/5/19.
//

#import "CPPhoneInputView.h"

@interface CPPhoneInputView()


@end
@implementation CPPhoneInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 20;
        self.backgroundColor = RGBA(255, 255, 255, 0.25);
        [self addView];
        [_phoneTf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(28);
            make.top.bottom.mas_equalTo(self);
            make.right.mas_equalTo(self).mas_offset(-10);
        }];
    }
    return self;
}
- (void)addView{
    _phoneTf = [[UITextField alloc]init];
    _phoneTf.textColor = [UIColor whiteColor];
    [self addSubview:_phoneTf];
}
- (void)setIsPhoneLogin:(BOOL)isPhoneLogin{
    [_phoneTf setPlaceholder:isPhoneLogin ? @"请输入手机号码" : @"请输入账号" WithColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:15]];

}
@end
