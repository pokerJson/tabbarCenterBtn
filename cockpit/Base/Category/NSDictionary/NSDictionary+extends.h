//
//  NSDictionary+extends.h
//  iWater
//
//  Created by Xudong.ma on 16/8/26.
//  Copyright © 2016年 Xudong.ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (extends)

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
