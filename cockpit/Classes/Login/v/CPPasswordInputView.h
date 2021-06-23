//
//  CPPasswordInputView.h
//  cockpit
//
//  Created by dzc on 2021/5/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CPPasswordInputView : UIView

@property (nonatomic,assign) BOOL isSendCode;


@property (nonatomic,strong) UITextField *codeTf;
@property (nonatomic,strong) UIButton *sendCodeBtn;

@end

NS_ASSUME_NONNULL_END
