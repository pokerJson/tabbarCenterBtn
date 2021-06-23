//
//  UIView+ChangeView.h
//  iWater
//
//  Created by Xudong.ma on 16/5/16.
//  Copyright © 2016年 Xudong.ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ChangeView)

- (void)changeFrameX:(CGFloat)x;
- (void)changeFrameY:(CGFloat)y;
- (void)changeWidth:(CGFloat)width;
- (void)changeHeight:(CGFloat)height;

- (CGFloat)frameX;
- (CGFloat)frameY;
- (CGFloat)width;
- (CGFloat)height;

@property (nonatomic, assign) CGFloat centerx;
@property (nonatomic, assign) CGFloat centery;

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

/**中心点x坐标*/
@property (nonatomic, assign) CGFloat centerX;
/**中心点y坐标*/
@property (nonatomic, assign) CGFloat centerY;

@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;

/**
 *  获取下一个响应者(确保为ViewController)
 *
 *  @return UIViewController
 */
- (UIViewController *)isViewController;

@end
