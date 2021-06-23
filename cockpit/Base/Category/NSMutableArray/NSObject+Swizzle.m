//
//  NSObject+Swizzle.m
//  ControlExtensionLib
//
//  Created by FANTEXIX on 2017/2/12.
//  Copyright © 2017年 FANTEXIX. All rights reserved.
//

#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzle)

// 全面
+ (void)swizzleSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector {
    
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    // 若已经存在，则添加会失败
    BOOL didAddMethod = class_addMethod(class,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    
    // 若原来的方法并不存在，则添加即可
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}



+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originalSelector = @selector(doesNotRecognizeSelector:);
        SEL swizzledSelector = @selector(sw_doesNotRecognizeSelector:);
        
        Method originalMethod = class_getClassMethod(self, originalSelector);
        Method swizzledMethod = class_getClassMethod(self, swizzledSelector);
        
        if(class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))){
            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }else{
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
#if TARGET_IPHONE_SIMULATOR
       if(@available(iOS 13.0, *)){
            Method origin = class_getClassMethod([UIDevice class], NSSelectorFromString(@"getUniqueStrByUUID"));
            //    IMP originImp = method_getImplementation(origin);
            
            Method swizz = class_getClassMethod([self class], @selector(swizz_getUniqueStrByUUID));
            //交换方法实现
            method_exchangeImplementations(origin, swizz);
        }
#endif
        
    });

    
}





+ (void)sw_doesNotRecognizeSelector:(SEL)aSelector{
    //处理 _LSDefaults 崩溃问题
    if([[self description] isEqualToString:@"_LSDefaults"] && (aSelector == @selector(sharedInstance))){
        //冷处理...
        return;
    }
    [self sw_doesNotRecognizeSelector:aSelector];
}

#pragma mark - 获取唯一标识 新浪
+ (NSString *)swizz_getUniqueStrByUUID{
    CFUUIDRef  uuidObj = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    NSString    *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return uuidString ;
}


@end
