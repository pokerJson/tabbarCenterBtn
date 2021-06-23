//
//  UIFont+FontExpends.m
//  iWater
//
//  Created by Xudong.ma on 16/6/22.
//  Copyright © 2016年 Xudong.ma. All rights reserved.
//

#import "UIFont+FontExpends.h"

@implementation UIFont (FontExpends)

+ (UIFont *)tpe_systemFontOfSize:(CGFloat)fontSize
{
    UIFont *newFont = nil;
    newFont = [UIFont systemFontOfSize:Set_WidthScale(fontSize)];
    return newFont;
}

+ (UIFont *)tpe_boldSystemFontOfSize:(CGFloat)fontSize
{
    UIFont *newFont = nil;
    newFont = [UIFont boldSystemFontOfSize:Set_WidthScale(fontSize)];
    return newFont;
}

#pragma mark - Added font.

+ (UIFont *)HYQiHeiWithFontSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"HYQiHei-BEJF" size:size];
}

#pragma mark - System font.

+ (UIFont *)AppleSDGothicNeoThinWithFontSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"AppleSDGothicNeo-Thin" size:size];
}

+ (UIFont *)AvenirWithFontSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"Avenir" size:size];
}

+ (UIFont *)AvenirLightWithFontSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"Avenir-Light" size:size];
}

+ (UIFont *)HeitiSCWithFontSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"Heiti SC" size:size];
}

+ (UIFont *)HelveticaNeueFontSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"HelveticaNeue" size:size];
}

+ (UIFont *)HelveticaNeueBoldFontSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:size];
}

+ (UIFont *)GillSansItalicFontSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"GillSans-Italic" size:size];
}

// 字体变大系数
+ (CGFloat)normalScale { return 1.0; }
+ (CGFloat)middleScale { return 1.5; }
+ (CGFloat)largeScale { return 2.0; }

@end
