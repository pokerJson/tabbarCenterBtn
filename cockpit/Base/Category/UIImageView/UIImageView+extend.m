//
//  UIImageView+extend.m
//  YouFenXiao
//
//  Created by mxd_iOS on 2017/3/23.
//  Copyright © 2017年 Xudong.ma. All rights reserved.
//

#import "UIImageView+extend.h"
#import "UIImage+expand.h"
#import "UIFont+FontExpends.h"

@implementation UIImageView (extend)

+ (UIImage *)placeHolderImgBgColor:(UIColor *)bgColor
                              rect:(CGRect)rect
                           showMsg:(NSString *)showMsg
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.image = [UIImage imageWithColor:bgColor];
    UILabel *label  = [[UILabel alloc] init];
    label.frame     = imageView.frame;
    label.textColor = [UIColor lightGrayColor];
    label.text      = showMsg;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont AvenirWithFontSize:20.f];
    [imageView addSubview:label];
    return imageView.image;
}

@end
