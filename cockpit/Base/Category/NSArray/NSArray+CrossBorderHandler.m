//
//  NSArray+CrossBorderHandler.m
//  ThreePersonEducation
//
//  Created by maxudong on 2019/12/2.
//  Copyright © 2019 maxudong. All rights reserved.
//

#import "NSArray+CrossBorderHandler.h"
#import <objc/runtime.h>

@implementation NSArray (CrossBorderHandler)

+ (void)load
{
    [super load];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //替换空数组方法
//        [self class:objc_getClass("__NSArray0") exchangeImplementation:@selector(objectAtIndex:) withMethod:@selector(emptyObjectIndex:)];
//        
//        [self class:objc_getClass("__NSSingleObjectArrayI") exchangeImplementation:@selector(objectAtIndex:) withMethod:@selector(singleObjectIndex:)];
//        
//        //替换不可变数组方法
//        [self class:objc_getClass("__NSArrayI") exchangeImplementation:@selector(objectAtIndex:) withMethod:@selector(objectAtSafeIndex:)];
//        [self class:objc_getClass("__NSArrayI") exchangeImplementation:@selector(objectAtIndexedSubscript:) withMethod:@selector(objectAtSafeIndexSubscript:)];
//
//        //替换可变数组方法
//        [self class:objc_getClass("__NSArrayM") exchangeImplementation:@selector(objectAtIndex:) withMethod:@selector(mutableObjectAtSafeIndex:)];
//        [self class:objc_getClass("__NSArrayM") exchangeImplementation:@selector(objectAtIndexedSubscript:) withMethod:@selector(mutableObjectAtSafeIndexSubscript:)];
        
        
        
    });
    
}

+ (void)class:(Class)class exchangeImplementation:(SEL)oldSEL withMethod:(SEL)newSEL
{
    Method oldMethod = class_getInstanceMethod(class, oldSEL);
    Method newMethod = class_getInstanceMethod(class, newSEL);
    method_exchangeImplementations(oldMethod, newMethod);
}

- (id)emptyObjectIndex:(NSUInteger)index
{
    NSLog(@"__NSArray0 取一个空数组 objectAtIndex , 崩溃") ;
    return nil;
}

- (id)singleObjectIndex:(NSInteger)index {
    
    if (index >= self.count || !self.count) {
        
        NSLog(@"__NSSingleObjectArrayI 取一个不可变单元素数组时越界 objectAtIndex , 崩溃") ;
        return nil;
        
    }
    
    return [self singleObjectIndex:index];
}


- (id)objectAtSafeIndex:(NSUInteger)index
{
    if (index > self.count - 1 || !self.count) {
        @try {
            return [self objectAtSafeIndex:index];
        }
        @catch (NSException *exception) {
            NSLog(@"exception: %@", exception.reason);
            return nil;
        }
        
    }else {
        return [self objectAtSafeIndex:index];
    }
}

- (id)objectAtSafeIndexSubscript:(NSUInteger)index
{
    if (index > self.count - 1 || !self.count) {
        @try {
            return [self objectAtSafeIndexSubscript:index];
        }
        @catch (NSException *exception) {
            NSLog(@"exception: %@", exception.reason);
            return nil;
        }
        
    }else {
        return [self objectAtSafeIndexSubscript:index];
    }
}

- (id)mutableObjectAtSafeIndex:(NSUInteger)index
{
    if (index > self.count - 1 || !self.count) {
        @try {
            return [self mutableObjectAtSafeIndex:index];
        }
        @catch (NSException *exception) {
            NSLog(@"exception: %@", exception.reason);
            return nil;
        }
        
    }else {
        return [self mutableObjectAtSafeIndex:index];
    }
}

- (id)mutableObjectAtSafeIndexSubscript:(NSUInteger)index
{
    if (index > self.count - 1 || !self.count) {
        @try {
            return [self mutableObjectAtSafeIndexSubscript:index];
        }
        @catch (NSException *exception) {
            NSLog(@"exception: %@", exception.reason);
            return nil;
        }
        
    }else {
        return [self mutableObjectAtSafeIndexSubscript:index];
    }
}

@end
