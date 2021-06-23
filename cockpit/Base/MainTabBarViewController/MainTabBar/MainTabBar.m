//
//  MainTabBar.m
//  ThreePersonEducation
//
//  Created by maxudong on 2019/4/8.
//  Copyright © 2019 maxudong. All rights reserved.
//

#import "MainTabBar.h"
#import "MainTabBarButton.h"

@interface MainTabBar ()

@property (nonatomic, strong) NSMutableArray   *tabbarBtnArray;
@property (nonatomic, weak)   MainTabBarButton *selectedButton;
@property (nonatomic, strong)   UIButton *centerBtn;
@end

@implementation MainTabBar

- (NSMutableArray *)tabbarBtnArray {
    if (!_tabbarBtnArray) {
        _tabbarBtnArray = [NSMutableArray array];
    }
    return  _tabbarBtnArray;
}

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}
- (void)xxx{
    UIButton *bb = [self viewWithTag:2];
    [self ClickTabBarButton:bb];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat btnY = 0;
    CGFloat btnW = self.frame.size.width / (self.subviews.count);
    CGFloat btnH = self.frame.size.height;
    
    for (int nIndex = 0; nIndex < self.tabbarBtnArray.count; nIndex++) {
        CGFloat btnX = btnW * nIndex;
        MainTabBarButton *tabBarBtn = self.tabbarBtnArray[nIndex];
        tabBarBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        tabBarBtn.tag = nIndex;
    }
    self.centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.centerBtn.frame = CGRectMake(SCREEN_WIDTH/2 - 25, -28, 62, 55);
    [self.centerBtn setImage:[UIImage imageNamed:@"Tab_Center"] forState:UIControlStateNormal];
    [self.centerBtn addTarget:self action:@selector(xxx) forControlEvents:UIControlEventTouchDown];
    [self bringSubviewToFront:self.centerBtn];
    self.centerBtn.tag = 1021;
    [self addSubview:self.centerBtn];
}

- (void)addTabBarButtonWithTabBarItem:(UITabBarItem *)tabBarItem
{
    
    MainTabBarButton *tabBarBtn = [[MainTabBarButton alloc] init];
    tabBarBtn.tabBarItem = tabBarItem;
    [tabBarBtn addTarget:self action:@selector(ClickTabBarButton:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:tabBarBtn];
    [self.tabbarBtnArray addObject:tabBarBtn];
    
    //default selected first one
    if (self.tabbarBtnArray.count == 1) {
        [self ClickTabBarButton:tabBarBtn];
    }
}

- (void)selecedItemIndex:(NSInteger)index {
    MainTabBarButton *tabbarBtn = _tabbarBtnArray[index];
    [self ClickTabBarButton:tabbarBtn];
}
- (void)itemIndex:(NSInteger)index badgeCount:(NSString *)count {
    MainTabBarButton *tabbarBtn = _tabbarBtnArray[index];
    tabbarBtn.badgeCount = [NSString stringWithFormat:@"%@",count];
}

- (void)ClickTabBarButton:(MainTabBarButton *)tabBarBtn {
    
    if ([self.delegate respondsToSelector:@selector(tabBarShouldSelectedButtonFrom:to:)]) {
       BOOL isSelected = [self.delegate tabBarShouldSelectedButtonFrom:self.selectedButton.tag to:tabBarBtn.tag];
        if (!isSelected) {
            return;
        }
    }
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)])
    {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedButton.tag to:tabBarBtn.tag];
    }
    
    self.selectedButton.selected = NO;
    tabBarBtn.selected  = YES;
    self.selectedButton = tabBarBtn;
//    [self startAnimationBy:self.selectedButton];
}

- (void)ClickWriteButton {
    if ([self.delegate respondsToSelector:@selector(tabBarClickWriteButton:)]) {
        [self.delegate tabBarClickWriteButton:self];
    }
}

- (void)startAnimationBy:(MainTabBarButton *)button
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath  = @"transform.scale";
    animation.values   = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 0.5;
    animation.calculationMode = kCAAnimationCubic;
    [button.layer addAnimation:animation forKey:nil];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
