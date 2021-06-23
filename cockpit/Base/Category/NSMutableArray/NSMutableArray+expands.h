//
//  NSMutableArray+expands.h
//  ThreePersonEducation
//
//  Created by maxudong on 2019/4/8.
//  Copyright © 2019 maxudong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (expands)

+ (NSMutableArray *)getSortArrayByList:(NSMutableArray *)list;

- (NSString *)arrayToJSONString:(NSMutableArray *)array;

@end

NS_ASSUME_NONNULL_END
