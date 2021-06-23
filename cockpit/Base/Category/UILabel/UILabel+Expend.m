//
//  UILabel+Expend.m
//  iWater
//
//  Created by Xudong.ma on 16/7/8.
//  Copyright © 2016年 Xudong.ma. All rights reserved.
//

#import "UILabel+Expend.h"

@implementation UILabel (Expend)

/**
 *  获取label款高
 *
 *  @param label 传入Label
 *
 *  @return CGRect
 */
+ (CGRect)getLabelRectByLabel:(UILabel *)label
                     maxWidth:(CGFloat)maxWidth
{
    CGRect rect = [label.text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:label.font} context:nil];
    
    return rect;
}

- (CGSize)boundingRectWithSize:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName: self.font};
    CGSize retSize = [self.text boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    return retSize;
}

- (CGRect)returnAttributeStrRext:(NSMutableParagraphStyle *)style
                            text:(NSString *)text
                            font:(UIFont *)font
                        maxWidth:(CGFloat)maxWidth

{
    
    NSDictionary *attributes = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:style};
    
    return [text boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
}


+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    if (label.text.length > 0) {
        NSString *labelText = label.text;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:space];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
        label.attributedText = attributedString;
    }
    //[label sizeToFit];
}

+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}

+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}

- (void)addLineOnLabel:(UILabel *)label
{
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(- Set_WidthScale(-2), label.height / 2 + 1, label.width - 2, 1)];
    lineLabel.backgroundColor = label.textColor;
    [label addSubview:lineLabel];
}

//设置不同字体颜色
- (void)fuwenbenLabel:(UILabel *)labell
           FontNumber:(id)font
             AndRange:(NSRange)range
             AndColor:(UIColor *)vaColor
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:labell.text];
    
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    
    labell.attributedText = str;
}
- (void)fuwenbenLabel:(UILabel *)labell backColor:(UIColor *)bgColor FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:labell.text];
    
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    //背景颜色
    [str addAttribute:NSBackgroundColorAttributeName value:bgColor range:range];
    
    labell.attributedText = str;
}
/** 设置行间距以及字体颜色*/
- (CGFloat)settingLabel:(UILabel *)label
             fontNumber:(UIFont *)font
               andRange:(NSRange)range
               andColor:(UIColor *)vaColor
                  space:(float)space
               maxWidth:(CGFloat)maxWidth
{
    if (kStringIsEmpty(label.text)) {
        return 15.;
    }
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    
    //设置字号
    [attributedString addAttribute:NSFontAttributeName value:font range:range];
    
    //设置文字颜色
    [attributedString addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    
    label.attributedText = attributedString;
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle, NSKernAttributeName:@0
                          };
    
    CGSize size = [labelText boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size.height;
}

/// 重设文本根据关键字显示关键字的颜色
/// @param label 传进来的label
/// @param font 大小
/// @param colorText 关键字
/// @param vaColor 关键字颜色
/// @param space 间距
/// @param maxWidth 最大宽度
- (CGFloat)settingLabel2:(UILabel *)label
             fontNumber:(UIFont *)font
               andShowColorText:(NSString *)colorText
               andColor:(UIColor *)vaColor
                  space:(float)space
               maxWidth:(CGFloat)maxWidth
{
    if (kStringIsEmpty(label.text)) {
        return 15.;
    }
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    
    //设置字号
//    [attributedString addAttribute:NSFontAttributeName value:font range:range];
    
    //设置文字颜色
//    [attributedString addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    
    //查找关键字
    NSArray *array=[labelText componentsSeparatedByString:colorText];
    NSMutableArray *arrayOfLocation=[NSMutableArray new];
    int d=0;
    for (int i=0; i<array.count-1; i++) {
        NSString *string=array[i];
        int loc = d+=string.length;
        NSNumber *number=[NSNumber numberWithInt:loc];
        //设置文字颜色
        [attributedString addAttribute:NSForegroundColorAttributeName value:vaColor range:NSMakeRange(loc, colorText.length)];
        d+=colorText.length;
        [arrayOfLocation addObject:number];//暂时没用到这个数组
    }

    label.attributedText = attributedString;
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle, NSKernAttributeName:@0
                          };
    
    CGSize size = [labelText boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size.height;
}
/** 设置行间距以及字体颜色*/
- (CGSize)resettingLabel:(UILabel *)label
              fontNumber:(UIFont *)font
                andRange:(NSRange)range
                andColor:(UIColor *)vaColor
                   space:(float)space
                maxWidth:(CGFloat)maxWidth
{
    
    NSString *labelText = label.text;
    if (kStringIsEmpty(labelText)) { return CGSizeZero; }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    
    //设置字号
    [attributedString addAttribute:NSFontAttributeName value:font range:range];
    
    //设置文字颜色
    [attributedString addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    
    label.attributedText = attributedString;
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle, NSKernAttributeName:@0
                          };
    
    CGSize size = [labelText boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size;
}


/** 设置行间距以及字体颜色*/
- (CGSize)newResettingLabel:(UILabel *)label
                 fontNumber:(UIFont *)font
                  andRange1:(NSRange)range1
                  andRange2:(NSRange)range2
                   andColor:(UIColor *)vaColor
                      space:(float)space
                   maxWidth:(CGFloat)maxWidth
{
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    
    //设置字号
    [attributedString addAttribute:NSFontAttributeName value:font range:range1];
    [attributedString addAttribute:NSFontAttributeName value:font range:range2];
    
    //设置文字颜色
    [attributedString addAttribute:NSForegroundColorAttributeName value:vaColor range:range1];
    [attributedString addAttribute:NSForegroundColorAttributeName value:vaColor range:range2];
    
    label.attributedText = attributedString;
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle, NSKernAttributeName:@0
                          };
    
    CGSize size = [labelText boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size;
}


/** 设置行间距以及字体颜色*/
- (CGSize)lastResettingLabel:(UILabel *)label
                  fontNumber:(UIFont *)font
                 fontNumber2:(UIFont *)font2
                   andRange1:(NSRange)range1
                   andRange2:(NSRange)range2
                    andColor:(UIColor *)vaColor
                   andColor2:(UIColor *)vaColor2
                       space:(float)space
                    maxWidth:(CGFloat)maxWidth
{
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    
    //设置字号
    [attributedString addAttribute:NSFontAttributeName value:font range:range1];
    [attributedString addAttribute:NSFontAttributeName value:font2 range:range2];
    
    //设置文字颜色
    [attributedString addAttribute:NSForegroundColorAttributeName value:vaColor range:range1];
    [attributedString addAttribute:NSForegroundColorAttributeName value:vaColor2 range:range2];
    
    label.attributedText = attributedString;
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle, NSKernAttributeName:@0
                          };
    
    CGSize size = [labelText boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size;
}

/** 设置行间距以及字体颜色*/
- (CGFloat)onlySettingLabel:(UILabel *)label
             fontNumber:(UIFont *)font
              andRange1:(NSRange)range1
              andRange2:(NSRange)range2
              andRange3:(NSRange)range3
               andColor:(UIColor *)vaColor
                  space:(float)space
               maxWidth:(CGFloat)maxWidth
{
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    
    //设置字号
    [attributedString addAttribute:NSFontAttributeName value:font range:range1];
    
    //设置文字颜色
    [attributedString addAttribute:NSForegroundColorAttributeName value:vaColor range:range1];
    [attributedString addAttribute:NSForegroundColorAttributeName value:vaColor range:range2];
    [attributedString addAttribute:NSForegroundColorAttributeName value:vaColor range:range3];
    
    label.attributedText = attributedString;
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle, NSKernAttributeName:@0
                          };
    
    CGSize size = [labelText boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size.height;
}

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
                               labelText:(NSString *)labelText
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    /** 行高 */
    paraStyle.lineSpacing = lineSpeace;
    // NSKernAttributeName字体间距
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.0
                          };
    CGSize size = [labelText boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

- (void)setLabelAttribute:(UILabel *)labell
               fontNumber:(id)font
                 adnRange:(NSRange)range
                 andColor:(UIColor *)vaColor
                    scale:(CGFloat)scale
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:labell.text];
    
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:scale];
    [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labell.text length])];
    
    labell.attributedText = str;
}

- (NSAttributedString *)dealHtmlStyleBy:(NSString *)analyseWord
{
    //返回的HTML文本
    NSString *htmlStr = analyseWord;
    //富文本，两种都可以
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    NSData *data = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
    
    //设置富文本
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
    //设置段落格式
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.lineSpacing = 7;
    para.paragraphSpacing = 10;
    //设置字号
    [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.] range:NSMakeRange(0, attStr.length)];
    [attStr addAttribute:NSParagraphStyleAttributeName value:para range:NSMakeRange(0, attStr.length)];
    
    return attStr;
}

@end

