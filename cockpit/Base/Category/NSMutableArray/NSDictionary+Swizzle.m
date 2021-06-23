//
//  NSDictionary+Swizzle.m
//  ControlExtensionLib
//
//  Created by FANTEXIX on 2017/2/12.
//  Copyright © 2017年 FANTEXIX. All rights reserved.
//

#import "NSDictionary+Swizzle.h"
#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

@implementation NSDictionary (Swizzle)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [objc_getClass("__NSPlaceholderDictionary") swizzleSelector:@selector(initWithObjects:forKeys:count:)
                                                       withSelector:@selector(fan_initWithObjects:forKeys:count:)];
    });
}

- (instancetype)fan_initWithObjects:(const id _Nonnull [_Nullable])objects forKeys:(const id <NSCopying> _Nonnull [_Nullable])keys count:(NSUInteger)cnt {
    
    BOOL nilObject = NO;
    for (NSUInteger i = 0; i < cnt; i++) {
        
        if (objects[i] == nil) {
            nilObject = YES;
            NSLog(@"\n**************************************************\n*\n*\n*\t initWithObjects:forKeys:count:  Obj[@\"%@\"] Is Nil \n*\n*\n**************************************************",keys[i]);
        }
    }

    if (nilObject) {
        return nil;
    }
    return [self fan_initWithObjects:objects forKeys:keys count:cnt];
}
@end
