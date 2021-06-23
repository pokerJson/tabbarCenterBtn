//
//  UIImage+expand.h
//  JianYa
//
//  Created by mxd_iOS on 2017/3/16.
//  Copyright © 2017年 Xudong.ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (expand)


/**
 根据颜色转换为image

 @param color 颜色
 @return image
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)placeHolderImgBgColor:(UIColor *)bgColor
                              rect:(CGRect)rect
                           showMsg:(NSString *)showMsg;

+ (__kindof UIImage *)getImageFromView:(UIView *)view;

//使用该方法不会模糊，根据屏幕密度计算
+ (UIImage *)convertViewToImage:(UIView *)view;
/**
 根据网络Url返回image

 @param imageUrl 图片网络url
 @return image
 */
+ (UIImage *)returnImgByImgUrl:(NSString *)imageUrl;

/**
 *  显示圆形图像
 */
+ (UIImage *)circleImageWithname:(NSString *)name
                     borderWidth:(CGFloat)borderWidth
                     borderColor:(UIColor *)borderColor;

/**
 *  保持宽高比设置图片在多大区域显示
 */
- (UIImage *)sourceImage:(UIImage *)sourceImage
              targetSize:(CGSize)targetSize;

/**
 *  指定宽度按比例缩放
 */
- (UIImage *)sourceImage:(UIImage *)sourceImage
             targetWidth:(CGFloat)targetWidth;

/**
 *  等比例缩放
 */
- (UIImage *)sourceImage:(UIImage *)sourceImage
                   scale:(CGFloat)scale;


+ (UIImage *)resizableImageWithImageName:(NSString *)imageName;


/** 压缩图片到指定的物理大小*/
- (NSData *)compressImageDataWithMaxLimit:(CGFloat)maxLimit;

- (UIImage *)compressImageWithMaxLimit:(CGFloat)maxLimit;


// 生成二维码
+ (UIImage *)generateQRCode:(NSString *)code size:(CGSize)size;
// 生成二维码2
+ (UIImage *)createCoreImage:(NSString *)codeStr centerImage:(UIImage *)centerImg;

@end
