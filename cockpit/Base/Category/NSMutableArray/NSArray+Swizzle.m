//
//  NSArray+Swizzle.m
//  ControlExtensionLib
//
//  Created by FANTEXIX on 2017/2/12.
//  Copyright © 2017年 FANTEXIX. All rights reserved.
//

#import "NSArray+Swizzle.h"
#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

@implementation NSArray (Swizzle)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        
        [objc_getClass("__NSArrayI") swizzleSelector:@selector(objectAtIndex:)
                                        withSelector:@selector(fan_objectAtIndex:)];
        
        [objc_getClass("__NSFrozenArrayM") swizzleSelector:@selector(objectAtIndexedSubscript:)
                                              withSelector:@selector(fan_objectAtIndexedSubscript:)];
        
        [objc_getClass("__NSPlaceholderArray") swizzleSelector:@selector(initWithObjects:count:) withSelector:@selector(fan_initWithObjects:count:)];
    
    });
}

- (instancetype)fan_initWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {
    
    BOOL nilObject = NO;
    
    for (NSUInteger i = 0; i < cnt; i++) {
        if (objects[i] == nil) {
            nilObject = YES;
            NSLog(@"\n**************************************************\n*\n*\n*\t -initWithObjects:count:  Object[%lu] Is Nil \n*\n*\n**************************************************",(unsigned long)i);
        }
    }
    
    if (nilObject) {
        id newObjects[cnt];
        NSUInteger index = 0;
        for (NSUInteger i = 0; i < cnt; i++) {
            if (objects[i] != nil) {
                newObjects[index++] = objects[i];
            }
        }
        return [self fan_initWithObjects:newObjects count:index];
    }
    return [self fan_initWithObjects:objects count:cnt];
}


- (id)fan_objectAtIndexedSubscript:(NSUInteger)index {
    if (self.count == 0) {
        NSLog(@"\n**************************************************\n*\n*\n*\t -objectAtIndexedSubscript:  Is Empty Array \n*\n*\n**************************************************");
        return nil;
    }
    
    if (index > self.count-1) {
        NSLog(@"\n**************************************************\n*\n*\n*\t -objectAtIndexedSubscript:  Index Out Bounds \n*\n*\n**************************************************");
        return nil;
    }
    
    return [self fan_objectAtIndexedSubscript:index];
}


- (id)fan_objectAtIndex:(NSUInteger)index {
    if (self.count == 0) {
        NSLog(@"\n**************************************************\n*\n*\n*\t -objectAtIndex:  Is Empty Array \n*\n*\n**************************************************");
        return nil;
    }
    
    if (index > self.count-1) {
        NSLog(@"\n**************************************************\n*\n*\n*\t -objectAtIndex:  Index Out Bounds \n*\n*\n**************************************************");
        return nil;
    }
    
    return [self fan_objectAtIndex:index];
}

@end
