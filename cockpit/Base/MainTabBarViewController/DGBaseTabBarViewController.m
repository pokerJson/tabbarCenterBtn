//
//  DGBaseTabBarViewController.m
//  DiscipleGroup
//
//  Created by maxudong on 2019/11/18.
//  Copyright © 2019 maxudong. All rights reserved.
//

#import "DGBaseTabBarViewController.h"
#import "MainTabBar.h"
//#import "DGLoginTools.h"
#import "DGtab.h"

@interface DGBaseTabBarViewController () <MainTabBarDelegate>
@property(nonatomic,strong)DGtab *dgTab;
@end

@implementation DGBaseTabBarViewController

#pragma mark -
#pragma mark - LazyLoading

#pragma mark -
#pragma mark - Set_Method

#pragma mark -
#pragma mark - ViewLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self SetupMainTabBar];
    [self buildSubViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - SystemMethod

- (void)dealloc
{
    
}

#pragma mark -
#pragma mark - InitializeMethod

- (void)SetupMainTabBar
{
    if (!self.mainTabBar) {
        self.mainTabBar = [[MainTabBar alloc] init];
        self.mainTabBar.frame       = self.tabBar.bounds;
        self.mainTabBar.delegate    = (id<MainTabBarDelegate>)self;
        self.dgTab = [[DGtab alloc]init];
        [self setValue:self.dgTab forKey:@"tabBar"];
        [self.dgTab addSubview:self.mainTabBar];

        self.mainTabBar.tag = 980;
    }
}

/**
 *  初始化视图控制器
 */
- (void)buildSubViews
{
    self.dgTab.translucent = NO;
    
    self.delegate = (id<UITabBarControllerDelegate>)self;
    //普通学员
    [self addChildVc:[DGSingleManager singleInstance].homePageVC
               title:@"互评"
               image:@"Tab_Huping"
       selectedImage:@"Tab_Huping_Star"];
    
    [self addChildVc:[DGSingleManager singleInstance].schoolVC
               title:@"答疑"
               image:@"Tab_Dayi"
       selectedImage:@"Tab_Dayi_Folder"];
    
    [self addChildVc:[DGSingleManager singleInstance].studyPageVC
               title:@"数据"
               image:nil
       selectedImage:nil];
    
    [self addChildVc:[DGSingleManager singleInstance].qaVC
               title:@"排行榜"
               image:@"Tab_Rank"
       selectedImage:@"Tab_Rank_Chart"];
    
    [self addChildVc:[DGSingleManager singleInstance].mineVC
               title:@"个人中心"
               image:@"Tab_Mine"
       selectedImage:@"Tab_Mine_Profile"];
    
    
    
}

#pragma mark -
#pragma mark - PersonalMethod

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc
             title:(NSString *)title
             image:(NSString *)image
     selectedImage:(NSString *)selectedImage
{
    /** 设置子控制器的文字*/
    childVc.title = title;// 同时设置tabbar和navigationBar的文字
    childVc.navigationItem.title = title;
    
    /** 设置子控制器的图片*/
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    /** 设置文字的样式*/
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexStr:@"#B7B7B7"];
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexStr:@"#CEAC7F"];
    [[UITabBarItem appearance] setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];

    /** 把子控制器加入根导航栏里*/
    [DGSingleManager singleInstance].mainNaviVC = [[DGNavigationController alloc] initWithRootViewController:childVc];


    [[DGSingleManager singleInstance].mainNaviVC addChildViewController:childVc];

    [self.mainTabBar addTabBarButtonWithTabBarItem:childVc.tabBarItem];

    /** 添加为子控制器*/
    [self addChildViewController:[DGSingleManager singleInstance].mainNaviVC];
}

- (void)selecedItemIndex:(NSInteger)index {
    [_mainTabBar selecedItemIndex:index];
}
- (void)itemIndex:(NSInteger)index badgeCount:(NSString *)count {
    [_mainTabBar itemIndex:index badgeCount:count];
}

#pragma mark -
#pragma mark - ButtonClickMethod

#pragma mark -
#pragma mark - NotificationMethod

#pragma mark -
#pragma mark - ...Delegate/DataSourceMethod

#pragma mark - mainTabBar delegate
#pragma mark - 处理tabBar点击方法
- (void)tabBar:(MainTabBar *)tabBar didSelectedButtonFrom:(long)fromBtnTag to:(long)toBtnTag
{
    self.selectedIndex = toBtnTag;
    
}
- (BOOL)tabBarShouldSelectedButtonFrom:(long)fromBtnTag to:(long)toBtnTag
{
    DGUserInfo *userInfo = [DGUserInfoManager unarchive];
    if (kStringIsEmpty(userInfo.token)) {
//        if (toBtnTag != 0) {
//            [DGTools checkLogin];
//            return NO;
//        }
        [DGTools checkLoginWithIsOnlyNoramal:kIsNoramlLogin];
        return NO;

        return YES;
    } else {
        return YES;
    }
    
    return  YES;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
      if (viewController == [tabBarController.viewControllers lastObject])
      {
          return YES;
      } else {
          return YES;
      }
}

- (NSArray *)barFrameInMainTabar
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:5];
    for (UIView *barView in self.mainTabBar.subviews) {
        [array addObject:[NSValue valueWithCGRect:[self.mainTabBar convertRect:barView.frame toView:[UIApplication sharedApplication].keyWindow]]];
    }
    return array;
}
#pragma mark -
#pragma mark - NetworkHandlerMethod

#pragma mark -
#pragma mark - 屏幕旋转 盟主直播的用到
-(BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}

-(NSUInteger)supportedInterfaceOrientations {
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}

@end
