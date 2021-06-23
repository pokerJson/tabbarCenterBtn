//
//  UITextField+PHPlaceholder.m
//  BSCPurse
//
//  Created by liuyang on 2019/4/2.
//  Copyright © 2019 yangjiatong. All rights reserved.
//

#import "UITextField+PHPlaceholder.h"

@implementation UITextField (PHPlaceholder)
- (void)setPlaceholderColor:(UIColor *)color {
//    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
}
//此方法已经失效
- (void)setplaceholderFont:(UIFont *)font {
    [self setValue:font forKeyPath:@"_placeholderLabel.font"];
}
//推荐使用这个方法
- (void)setPlaceholder:(NSString *)placeHolder WithColor:(UIColor *)color Font:(UIFont *)font  {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (color) [dict setObject:color forKey:NSForegroundColorAttributeName];
    if (font) [dict setObject:font forKey:NSFontAttributeName];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolder attributes:dict];
}

@end
