//
//  UIButton+Init.h
//  iWater
//
//  Created by Xudong.ma on 16/5/16.
//  Copyright © 2016年 Xudong.ma. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BtnCLickBlock)(void);

@interface UIButton (Init)

/**
 *  UIButton便利构造器
 *
 *  @param type            type
 *  @param frame           frame
 *  @param backgroundColor 背景色
 *  @param title           标题
 *  @param state           state
 *  @param tintColor       字体颜色
 *  @param target          self
 *  @param action          调用方法
 *  @param events          事件
 *  @param cornerRadius    圆角
 *  @param borderWidth     边宽
 *  @param borderColor     边颜色
 *
 *  @return UIButton
 */
+ (instancetype)buttonWithType:(UIButtonType)type
                         frame:(CGRect)frame
                          font:(UIFont *)font
               backgroundColor:(UIColor *)backgroundColor
                      setTitle:(NSString *)title
                     ForState :(UIControlState)state
                  setTintColor:(UIColor *)tintColor
                        target:(id)target
                        action:(SEL)action
               forcontrolEvent:(UIControlEvents)events
                  cornerRadius:(CGFloat)cornerRadius
                   borderWidth:(CGFloat)borderWidth
                   borderColor:(CGColorRef)borderColor;

- (void)verticalImageAndTitle:(CGFloat)spacing;

+ (CGSize)sizeOfLabelWithCustomMaxWidth:(CGFloat)width
                         systemFontSize:(CGFloat)fontSize
                    andFilledTextString:(NSString *)str;

- (void)setEnlargeEdgeWithTop:(CGFloat)top
                        right:(CGFloat)right
                       bottom:(CGFloat)bottom
                         left:(CGFloat)left;

//给uibutton添加block
@property (nonatomic,copy)BtnCLickBlock clickBlock;
- (void)addTapHadnle:(BtnCLickBlock)block;

@end
