//
//  CPShowUpdateView.m
//  cockpit
//
//  Created by dzc on 2021/5/20.
//

#import "CPShowUpdateView.h"
@interface CPShowUpdateView()

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIButton *gotoBtn;


@end

@implementation CPShowUpdateView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.gotoBtn];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).mas_offset(40);
            make.left.right.mas_equalTo(self);
            make.height.mas_equalTo(25);
        }];
        [self.gotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self).mas_offset(-12);
            make.left.right.mas_equalTo(self);
            make.height.mas_equalTo(25);
        }];
    }
    return self;
}

+ (void)showUpdateViewWith:(UIView *)vv call:(UpdateBlock)callBack{
    UIView *contentView = [[UIView alloc]initWithFrame:vv.bounds];
    contentView.backgroundColor = RGBA(0, 0, 0, 0.5);
    [vv addSubview:contentView];
    CPShowUpdateView *sho = [[CPShowUpdateView alloc]initWithFrame:CGRectMake(80, 100, kScreenWidth - 160, 130)];
    sho.centerX = contentView.centerX;
    sho.centerY = contentView.centerY;
    [contentView addSubview:sho];
    [UIView animateWithDuration:0.35 animations:^{
        sho.alpha = 1;
    } completion:^(BOOL finished) {}];
    sho.updateBlock = callBack;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor colorWithHexStr:@"#224188"];
        _titleLabel.font = CPBoldFont(15);
        _titleLabel.text = @"发现新版本";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return  _titleLabel;
}
- (UIButton *)gotoBtn{
    WeakSelf(weakSelf);
    if (!_gotoBtn) {
        _gotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_gotoBtn setTitle:@"立即更新" forState:UIControlStateNormal];
        _gotoBtn.titleLabel.font = CPFont(15);
        [_gotoBtn setTitleColor:[UIColor colorWithHexStr:@"#00A0D3"] forState:UIControlStateNormal];
        [_gotoBtn addTapHadnle:^{
            weakSelf.updateBlock();
        }];
    }
    return  _gotoBtn;
}
@end
