//
//  UIColor+hexColor.m
//  iWater
//
//  Created by Xudong.ma on 16/5/16.
//  Copyright © 2016年 Xudong.ma. All rights reserved.
//

#import "UIColor+hexColor.h"

@implementation UIColor (hexColor)

/**
 *  hex值转换颜色
 *
 *  @param hexStr hex value
 *
 *  @return UIColor
 */
+ (__kindof UIColor *)colorWithHexStr:(NSString *)hexStr
{
    //去掉空格和换行符 并换成大写
    NSString *cString = [[hexStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6)
        return [UIColor whiteColor];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

/**
 *  UIColor转换hex值
 *
 *  @param color UIColor
 *
 *  @return hexStr
 */
+ (__kindof NSString *)hexFromUIColor:(UIColor *)color
{
    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[0]
                                green:components[0]
                                 blue:components[0]
                                alpha:components[1]];
    }
    
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    
    return [NSString stringWithFormat:@"#%x%x%x", (int)((CGColorGetComponents(color.CGColor))[0]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[1]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[2]*255.0)];
}

/**
 *  渐变色
 *
 *  @param selfView 当前View
 */
+ (void)dealBackgroundViewBySelfView:(UIView *)selfView
                             colorUp:(UIColor *)colorUp
                           colorDown:(UIColor *)colorDown
{
    CGPoint inputPoint0 = CGPointMake(0, 0);
    CGPoint inputPoint1 = CGPointMake(0, 0.9);
    
    CAGradientLayer *layer = [CAGradientLayer new];
    layer.colors = @[(__bridge id)colorUp.CGColor, (__bridge id)colorDown.CGColor];
    layer.startPoint = inputPoint0;
    layer.endPoint   = inputPoint1;
    layer.frame      = selfView.bounds;
    [selfView.layer addSublayer:layer];
}

@end
