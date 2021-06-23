//
//  NSAttributedString+expand.h
//  JianYa
//
//  Created by mxd_iOS on 2017/3/16.
//  Copyright © 2017年 Xudong.ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (expand)

/**
 *  根据约束的宽度来求NSAttributedString的高度
 */
- (CGFloat)heightWithConstrainedWidth:(CGFloat)width;

+ (NSAttributedString *)attStringWithString:(NSString *)string keyWord:(NSString *)keyWord;

+ (NSAttributedString *)attStringWithString:(NSString *)string
                                    keyWord:(NSString *)keyWord
                                       font:(UIFont *)font
                           highlightedColor:(UIColor *)highlightedcolor
                                  textColor:(UIColor *)textColor;

+ (NSAttributedString *)attStringWithString:(NSString *)string
                                    keyWord:(NSString *)keyWord
                                       font:(UIFont *)font
                           highlightedColor:(UIColor *)highlightedcolor
                                  textColor:(UIColor *)textColor
                                  lineSpace:(CGFloat)lineSpace;

+ (NSMutableAttributedString *)richText:(NSString *)str
                                  color:(UIColor *)color
                                   font:(UIFont *)font
                              lineSpace:(float)lineSpace;

+ (CGFloat)heightWithString:(NSString *)string
                lineSpacing:(CGFloat)lineSpacing
                       font:(UIFont*)font
                      width:(CGFloat)width;
+ (CGFloat)WidthWithString:(NSString *)string lineSpacing:(CGFloat)lineSpacing font:(UIFont*)font height:(CGFloat)height;

@end
