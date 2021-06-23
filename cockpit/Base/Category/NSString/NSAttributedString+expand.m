//
//  NSAttributedString+expand.m
//  JianYa
//
//  Created by mxd_iOS on 2017/3/16.
//  Copyright © 2017年 Xudong.ma. All rights reserved.
//

#import "NSAttributedString+expand.h"
#import <CoreText/CoreText.h>

#define kFont(size) [UIFont systemFontOfSize:size]
#define kLineHeight (1 / [UIScreen mainScreen].scale)

#define kCommonHighLightRedColor [UIColor colorWithRed:1.00f green:0.49f blue:0.65f alpha:1.00f]
#define kCommonBlackColor    [UIColor colorWithRed:0.17f green:0.23f blue:0.28f alpha:1.00f]

@implementation NSAttributedString (expand)

// 公共富文本
+ (NSAttributedString *)attStringWithString:(NSString *)string keyWord:(NSString *)keyWord
{
    return [self attStringWithString:string keyWord:keyWord font:kFont(16) highlightedColor:kCommonHighLightRedColor textColor:kCommonBlackColor];
}

+ (NSAttributedString *)attStringWithString:(NSString *)string
                                    keyWord:(NSString *)keyWord
                                       font:(UIFont *)font
                           highlightedColor:(UIColor *)highlightedcolor
                                  textColor:(UIColor *)textColor {
    return [self attStringWithString:string keyWord:keyWord font:font highlightedColor:highlightedcolor textColor:textColor lineSpace:2.0];
}

+ (NSAttributedString *)attStringWithString:(NSString *)string
                                    keyWord:(NSString *)keyWord
                                       font:(UIFont *)font
                           highlightedColor:(UIColor *)highlightedcolor
                                  textColor:(UIColor *)textColor
                                  lineSpace:(CGFloat)lineSpace
{
    if (string.length) {
        
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:string];
        if (!keyWord || keyWord.length == 0) {
            NSRange allRange = NSMakeRange(0, string.length);
            [attStr addAttribute:NSFontAttributeName value:font range:allRange];
            [attStr addAttribute:NSForegroundColorAttributeName value:textColor range:allRange];
            
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            style.lineSpacing = lineSpace;
            [attStr addAttribute:NSParagraphStyleAttributeName value:style range:allRange];
            return attStr;
        }
        NSRange range = [string rangeOfString:keyWord options:NSCaseInsensitiveSearch];
        
        // 找到了关键字
        if (range.location != NSNotFound) {
            NSRange allRange = NSMakeRange(0, string.length);
            [attStr addAttribute:NSFontAttributeName value:font range:allRange];
            [attStr addAttribute:NSForegroundColorAttributeName value:textColor range:allRange];
            [attStr addAttribute:NSForegroundColorAttributeName value:highlightedcolor range:range];
            
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            style.lineSpacing = lineSpace;
            [attStr addAttribute:NSParagraphStyleAttributeName value:style range:allRange];
        } else {
            NSRange allRange = NSMakeRange(0, string.length);
            [attStr addAttribute:NSFontAttributeName value:font range:allRange];
            [attStr addAttribute:NSForegroundColorAttributeName value:textColor range:allRange];
            
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            style.lineSpacing = lineSpace;
            [attStr addAttribute:NSParagraphStyleAttributeName value:style range:allRange];
            return attStr;
        }
        return attStr.copy;
    }
    return [[NSAttributedString alloc] init];
}

- (CGFloat)boundingWidthForHeight:(CGFloat)inHeight
{
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFMutableAttributedStringRef) self);
    CGSize suggestedSize         = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0),NULL, CGSizeMake(CGFLOAT_MAX, inHeight), NULL);
    CFRelease(framesetter);
    return suggestedSize.width;
}

- (CGFloat)heightWithConstrainedWidth:(CGFloat)width
{
    if (self == nil || ![self isKindOfClass:[NSAttributedString class]]) {return 0;}
    return [self boundingWidthForHeight:width];
}

+ (NSMutableAttributedString *)richText:(NSString *)str color:(UIColor *)color font:(UIFont *)font lineSpace:(float)lineSpace {
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color}];
    NSRange allRange = NSMakeRange(0, string.length);
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpace;
    [string addAttribute:NSParagraphStyleAttributeName value:style range:allRange];
    return string;
}

+ (CGFloat)heightWithString:(NSString *)string lineSpacing:(CGFloat)lineSpacing font:(UIFont*)font width:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = lineSpacing;
    NSDictionary *dic = @{ NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle };
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return  ceilf(size.height);
}
+ (CGFloat)WidthWithString:(NSString *)string lineSpacing:(CGFloat)lineSpacing font:(UIFont*)font height:(CGFloat)height {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = lineSpacing;
    NSDictionary *dic = @{ NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle };
    CGSize size = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return  ceilf(size.width);
}
@end
