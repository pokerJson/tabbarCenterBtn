//
//  UITextField+PHPlaceholder.h
//  BSCPurse
//
//  Created by liuyang on 2019/4/2.
//  Copyright © 2019 yangjiatong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (PHPlaceholder)
- (void)setPlaceholderColor:(UIColor *)color ;
//此方法已经失效
- (void)setplaceholderFont:(UIFont *)font;
//推荐使用这个方法
- (void)setPlaceholder:(NSString *)placeHolder WithColor:(UIColor *)color Font:(UIFont *)font;
@end

NS_ASSUME_NONNULL_END
