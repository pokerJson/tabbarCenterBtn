//
//  UIImageView+extend.h
//  YouFenXiao
//
//  Created by mxd_iOS on 2017/3/23.
//  Copyright © 2017年 Xudong.ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (extend)

+ (UIImage *)placeHolderImgBgColor:(UIColor *)bgColor
                              rect:(CGRect)rect
                           showMsg:(NSString *)showMsg;

@end
