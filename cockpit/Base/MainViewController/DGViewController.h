//
//  DGViewController.h
//  DiscipleGroup
//
//  Created by maxudong on 2019/11/18.
//  Copyright © 2019 maxudong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DGWebViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DGViewController : UIViewController



- (void)setBaseLeftBarButtonItem;

- (void)backButtonClickedAction:(UIBarButtonItem *)buttonItem;

@property(nonatomic, assign)BOOL        scrollEnabled;
@property(nonatomic, weak)UITableView * kTableView;
- (void)kSubVCViewWillAppear;

@property (nonatomic, assign, readwrite) BOOL isClose;//返回键为叉

@end

NS_ASSUME_NONNULL_END
