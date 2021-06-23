//
//  UILabel+Expend.h
//  iWater
//
//  Created by Xudong.ma on 16/7/8.
//  Copyright © 2016年 Xudong.ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Expend)

/**
 *  获取label款高
 *
 *  @param label 传入Label
 *
 *  @return CGRect
 */
+ (CGRect)getLabelRectByLabel:(UILabel *)label
                     maxWidth:(CGFloat)maxWidth;

- (CGSize)boundingRectWithSize:(CGSize)size;

- (CGRect)returnAttributeStrRext:(NSMutableParagraphStyle *)style
                            text:(NSString *)text
                            font:(UIFont *)font
                        maxWidth:(CGFloat)maxWidth;

//设置不同字体颜色
- (void)fuwenbenLabel:(UILabel *)labell
           FontNumber:(id)font
             AndRange:(NSRange)range
             AndColor:(UIColor *)vaColor;
//设置不同字体颜色 背景颜色
- (void)fuwenbenLabel:(UILabel *)labell
            backColor:(UIColor *)bgColor
           FontNumber:(id)font
             AndRange:(NSRange)range
             AndColor:(UIColor *)vaColor;

/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/** 设置行间距以及字体颜色*/
- (CGFloat)settingLabel:(UILabel *)label
             fontNumber:(UIFont *)font
               andRange:(NSRange)range
               andColor:(UIColor *)vaColor
                  space:(float)space
               maxWidth:(CGFloat)maxWidth;

/** 设置行间距以及字体颜色*/
- (CGFloat)settingLabel2:(UILabel *)label
             fontNumber:(UIFont *)font
               andShowColorText:(NSString *)colorText
               andColor:(UIColor *)vaColor
                  space:(float)space
                maxWidth:(CGFloat)maxWidth;

/** 设置行间距以及字体颜色*/
- (CGSize)resettingLabel:(UILabel *)label
              fontNumber:(UIFont *)font
                andRange:(NSRange)range
                andColor:(UIColor *)vaColor
                   space:(float)space
                maxWidth:(CGFloat)maxWidth;

/** 设置行间距以及字体颜色*/
- (CGFloat)onlySettingLabel:(UILabel *)label
                 fontNumber:(UIFont *)font
                  andRange1:(NSRange)range1
                  andRange2:(NSRange)range2
                  andRange3:(NSRange)range3
                   andColor:(UIColor *)vaColor
                      space:(float)space
                   maxWidth:(CGFloat)maxWidth;

/** 设置行间距以及字体颜色*/
- (CGSize)newResettingLabel:(UILabel *)label
                 fontNumber:(UIFont *)font
                  andRange1:(NSRange)range1
                  andRange2:(NSRange)range2
                   andColor:(UIColor *)vaColor
                      space:(float)space
                   maxWidth:(CGFloat)maxWidth;

/** 设置行间距以及字体颜色*/
- (CGSize)lastResettingLabel:(UILabel *)label
                  fontNumber:(UIFont *)font
                 fontNumber2:(UIFont *)font2
                   andRange1:(NSRange)range1
                   andRange2:(NSRange)range2
                    andColor:(UIColor *)vaColor
                   andColor2:(UIColor *)vaColor2
                       space:(float)space
                    maxWidth:(CGFloat)maxWidth;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

- (void)addLineOnLabel:(UILabel *)label;

- (void)setLabelAttribute:(UILabel *)labell
               fontNumber:(id)font
                 adnRange:(NSRange)range
                 andColor:(UIColor *)vaColor
                    scale:(CGFloat)scale;

/**
 *  计算富文本字体高度
 *
 *  @param lineSpeace 行高
 *  @param font       字体
 *  @param width      字体所占宽度
 *
 *  @return 富文本高度
 */
- (CGFloat)getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace
                                withFont:(UIFont *)font
                               withWidth:(CGFloat)width
                               labelText:(NSString *)labelText;

- (NSAttributedString *)dealHtmlStyleBy:(NSString *)analyseWord;

@end

