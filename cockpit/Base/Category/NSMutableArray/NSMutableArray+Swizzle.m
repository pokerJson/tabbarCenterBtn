//
//  NSMutableArray+Swizzle.m
//  ControlExtensionLib
//
//  Created by FANTEXIX on 2017/2/12.
//  Copyright © 2017年 FANTEXIX. All rights reserved.
//

#import "NSMutableArray+Swizzle.h"
#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

@implementation NSMutableArray (Swizzle)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        
        [self swizzleSelector:@selector(removeObject:)
                 withSelector:@selector(fanM_removeObject:)];
        
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(removeObjectAtIndex:)
                                        withSelector:@selector(fanM_removeObjectAtIndex:)];
        
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(objectAtIndex:)
                                        withSelector:@selector(fanM_objectAtIndex:)];
        
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(addObject:)
                                withSelector:@selector(fanM_addObject:)];
        
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(insertObject:atIndex:)
                                withSelector:@selector(fanM_insertObject:atIndex:)];
        
        [objc_getClass("__NSPlaceholderArray") swizzleSelector:@selector(initWithObjects:count:)
                                                  withSelector:@selector(fanM_initWithObjects:count:)];
        
    });
}


- (instancetype)fanM_initWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {
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
        return [self fanM_initWithObjects:newObjects count:index];
    }
    return [self fanM_initWithObjects:objects count:cnt];

}



- (void)fanM_addObject:(id)obj {
    if (obj == nil) {
        NSLog(@"\n**************************************************\n*\n*\n*\t -addObject:  Can't Add Nil \n*\n*\n**************************************************");
    } else {
        [self fanM_addObject:obj];
    }
}



- (void)fanM_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject == nil) {
        NSLog(@"\n**************************************************\n*\n*\n*\t -insertObject:atIndex:  Can't Insert Nil \n*\n*\n**************************************************");
    } else if (index > self.count) {
        NSLog(@"\n**************************************************\n*\n*\n*\t -insertObject:atIndex:  Index Is Invalid \n*\n*\n**************************************************");
    } else {
        [self fanM_insertObject:anObject atIndex:index];
    }
}

- (id)fanM_objectAtIndex:(NSUInteger)index {
    if (self.count == 0) {
        NSLog(@"\n**************************************************\n*\n*\n*\t -objectAtIndex:  Is Empty Array \n*\n*\n**************************************************");
        return nil;
    }
    
    if (index > self.count-1) {
        NSLog(@"\n**************************************************\n*\n*\n*\t -objectAtIndex:  Index Out Bounds \n*\n*\n**************************************************");
        return nil;
    }
    
    return [self fanM_objectAtIndex:index];
}

- (void)fanM_removeObjectAtIndex:(NSUInteger)index {
    if (self.count == 0) {
        NSLog(@"\n**************************************************\n*\n*\n*\t -removeObjectAtIndex:  Is Empty Array \n*\n*\n**************************************************");
        return;
    }
    
    if (index > self.count-1) {
        NSLog(@"\n**************************************************\n*\n*\n*\t -removeObjectAtIndex:  Index Out Bounds \n*\n*\n**************************************************");
        return;
    }
    
    [self fanM_removeObjectAtIndex:index];
}

- (void)fanM_removeObject:(id)obj {
    if (obj == nil) {
        NSLog(@"\n**************************************************\n*\n*\n*\t -removeObject:  Obj Is Nil \n*\n*\n**************************************************");
        return;
    }
    [self fanM_removeObject:obj];
}
@end
