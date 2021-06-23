//
//  UIButton+Init.m
//  iWater
//
//  Created by Xudong.ma on 16/5/16.
//  Copyright © 2016年 Xudong.ma. All rights reserved.
//

#import "UIButton+Init.h"
#import <objc/runtime.h>

static NSString * const topNameKey    = @"kTopNameKey";
static NSString * const leftNameKey   = @"kLeftNameKey";
static NSString * const rightNameKey  = @"kRightNameKey";
static NSString * const bottomNameKey = @"kBottomNameKey";


static NSString * const keyWithMethod = @"kKeyWithMethod";
static NSString *keyWithBlock = @"keyWithBlock";

@implementation UIButton (Init)

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
                   borderColor:(CGColorRef)borderColor
{
    UIButton *button = [UIButton buttonWithType:type];
    button.frame              = frame;
    button.titleLabel.font    = font;
    button.backgroundColor    = backgroundColor;
    [button setTitle:title forState:state];
    [button setTitleColor:tintColor forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:events];
    button.layer.cornerRadius = cornerRadius;
    button.layer.borderWidth  = borderWidth;
    button.layer.borderColor  = borderColor;
    if (cornerRadius > 0) {
        button.layer.masksToBounds = YES;
    }
    
    return button;
}

- (void)verticalImageAndTitle:(CGFloat)spacing
{
    self.titleLabel.backgroundColor = [UIColor clearColor];
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
}


+ (CGSize)sizeOfLabelWithCustomMaxWidth:(CGFloat)width
                         systemFontSize:(CGFloat)fontSize
                    andFilledTextString:(NSString *)str
{
    //    创建一个label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    //    label 的文字
    label.text = str;
    //    label 的行数
    label.numberOfLines = 0;
    //    label的字体大小
    label.font = [UIFont systemFontOfSize:fontSize];
    //    让label通过文字设置size
    [label sizeToFit];
    //    获取label 的size
    CGSize size = label.frame.size;
    //    返回出去
    return size;
}

- (void)setEnlargeEdgeWithTop:(CGFloat)top
                        right:(CGFloat)right
                       bottom:(CGFloat)bottom
                         left:(CGFloat)left
{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}


/**
 返回增加范围后的结果
 
 @return return value description
 */
- (CGRect) enlargedRect
{
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge)
    {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }
    else
    {
        return self.bounds;
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent*) event
{
    CGRect rect = [self enlargedRect];//获得了获得新范围的CGRect
    
    if (CGRectEqualToRect(rect, self.bounds))  //如果没有增加点击范围就调用super 看看点击范围是不是在父控件上
    {
        return [super hitTest:point withEvent:event];
    }
    //如果触摸点为在增加后的范围内就返回此view为触摸点
    return CGRectContainsPoint(rect, point) ? self : nil;
}

//给uibutton添加block
- (void)addTapHadnle:(BtnCLickBlock)block{
    [self addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject(self, &keyWithMethod, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)setClickBlock:(BtnCLickBlock)clickBlock{
    objc_setAssociatedObject(self, &keyWithBlock, clickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC );
}
- (BtnCLickBlock)clickBlock{
    return objc_getAssociatedObject(self ,&keyWithBlock);
}



- (void)click{
    void (^tapBlock)() = objc_getAssociatedObject(self, &keyWithMethod);
    
    if (tapBlock) {
        tapBlock();
    }
}
@end
