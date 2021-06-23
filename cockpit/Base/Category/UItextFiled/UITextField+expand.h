//
//  UITextField+expand.h
//  YouFenXiao
//
//  Created by mxd_iOS on 2017/3/27.
//  Copyright © 2017年 Xudong.ma. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LimitBlock)(NSString *);

@interface UITextField (expand)

+ (instancetype)desplayWithPlaceholder:(NSString *)placeholder
                                  rect:(CGRect)rect
                          keyboardType:(UIKeyboardType)keyboardType
                       clearButtonMode:(UITextFieldViewMode)clearButtonMode
                       secureTextEntry:(BOOL)secureTextEntry;

+ (BOOL)isStringContainsEmoji:(UITextField *)textField;

//是否含有表情
+ (BOOL)stringContainsEmoji:(NSString *)string;

//textfield限制只能输入数字和字母
+ (BOOL)validatePwdStr:(NSString *)pwdStr;

//textfield限制只能输入数字
+ (BOOL)validateNumber:(NSString*)number;

@property (nonatomic , copy)LimitBlock limitBlock;
@property (nonatomic, assign) NSInteger maxTextLength;

- (void)lengthLimit:(void (^)(NSString *))limit;

@end
