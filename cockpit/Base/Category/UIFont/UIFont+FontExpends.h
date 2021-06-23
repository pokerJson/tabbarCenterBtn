//
//  UIFont+FontExpends.h
//  iWater
//
//  Created by Xudong.ma on 16/6/22.
//  Copyright © 2016年 Xudong.ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (FontExpends)

#pragma mark - Added font.

+ (UIFont *)tpe_systemFontOfSize:(CGFloat)fontSize;
+ (UIFont *)tpe_boldSystemFontOfSize:(CGFloat)fontSize;

/**
 *  HYQiHei-BEJF font (added by plist).
 *
 *  @param size Font's size.
 *
 *  @return Font.
 */
+ (UIFont *)HYQiHeiWithFontSize:(CGFloat)size;

#pragma mark - System font.

/**
 *  AppleSDGothicNeo-Thin font.
 *
 *  @param size Font's size.
 *
 *  @return Font.
 */
+ (UIFont *)AppleSDGothicNeoThinWithFontSize:(CGFloat)size;

/**
 *  Avenir font.
 *
 *  @param size Font's size.
 *
 *  @return Font.
 */
+ (UIFont *)AvenirWithFontSize:(CGFloat)size;

/**
 *  Avenir-Light font.
 *
 *  @param size Font's size.
 *
 *  @return Font.
 */
+ (UIFont *)AvenirLightWithFontSize:(CGFloat)size;

/**
 *  Heiti SC font.
 *
 *  @param size Font's size.
 *
 *  @return Font.
 */
+ (UIFont *)HeitiSCWithFontSize:(CGFloat)size;

/**
 *  HelveticaNeue font.
 *
 *  @param size Font's size.
 *
 *  @return Font.
 */
+ (UIFont *)HelveticaNeueFontSize:(CGFloat)size;

/**
 *  HelveticaNeue-Bold font.
 *
 *  @param size Font's size.
 *
 *  @return Font.
 */
+ (UIFont *)HelveticaNeueBoldFontSize:(CGFloat)size;

/**
 *  GillSans-Italic font.
 *
 *  @param size Font's size.
 *
 *  @return Font.
 */
+ (UIFont *)GillSansItalicFontSize:(CGFloat)size;

// 字体变大系数
+ (CGFloat)normalScale;
+ (CGFloat)middleScale;
+ (CGFloat)largeScale;

@end
