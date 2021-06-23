//
//  DGWebViewController.h
//  DiscipleGroup
//
//  Created by maxudong on 2019/12/16.
//  Copyright © 2019 maxudong. All rights reserved.
//

#import "DGViewController.h"


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SourceControllerType) {
    SourceControllerTypeMessage        = 1, //资讯
    SourceControllerTypeLookAnswer ,         //查看问题
    SourceControllerTypeLevel
};



@interface DGWebViewController : UIViewController

@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) NSString *titleName;
@property (nonatomic, assign) BOOL dynamicGetH5Title;//是否动态获取h5标题
@property (nonatomic, assign) BOOL isHideNaviBar;//是否隐藏导航栏
@property (nonatomic, assign) BOOL isShutBackBtn;//返回按钮的图片改为X


@end

NS_ASSUME_NONNULL_END
