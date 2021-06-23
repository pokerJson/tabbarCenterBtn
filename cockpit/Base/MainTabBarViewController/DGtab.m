// Copyright © 2021 Peogoo. All rights reserved.

#import "DGtab.h"

@interface DGtab()

@end

@implementation DGtab

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return  self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (!self.hidden) {
        UIButton *bb = [self viewWithTag:1021];
        UIView *vv = [self viewWithTag:980];
        CGPoint pp = [vv convertPoint:point toView:bb];
        if ([bb pointInside:pp withEvent:event]) {
            return bb;
        }
    }
    return [super hitTest:point withEvent:event];
}
@end
