//
//  NSObject+Swizzle.h
//  ControlExtensionLib
//
//  Created by FANTEXIX on 2017/2/12.
//  Copyright © 2017年 FANTEXIX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzle)

+ (void)swizzleSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector;
@end
