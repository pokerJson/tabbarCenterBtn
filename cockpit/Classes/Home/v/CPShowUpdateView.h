//
//  CPShowUpdateView.h
//  cockpit
//
//  Created by dzc on 2021/5/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^UpdateBlock)(void);

@interface CPShowUpdateView : UIView

@property(nonatomic,copy)UpdateBlock updateBlock;

+ (void)showUpdateViewWith:(UIView *)vv call:(UpdateBlock)callBack;

@end

NS_ASSUME_NONNULL_END
