//
//  CPPhoneInputView.h
//  cockpit
//
//  Created by dzc on 2021/5/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CPPhoneInputView : UIView

//是否是手机号登录
@property (nonatomic,assign) BOOL isPhoneLogin;


@property (nonatomic,strong) UITextField *phoneTf;

@end

NS_ASSUME_NONNULL_END
