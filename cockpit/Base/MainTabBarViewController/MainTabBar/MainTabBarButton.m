//
//  MainTabBarButton.m
//  ThreePersonEducation
//
//  Created by maxudong on 2019/4/8.
//  Copyright © 2019 maxudong. All rights reserved.
//

#import "MainTabBarButton.h"

/** image ratio*/
#define TabBarButtonImageRatio 0.6

@interface MainTabBarButton()

@property (nonatomic, strong) UILabel *badgeLabel;

@end

@implementation MainTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //只需要设置一次的放置在这里
        self.imageView.contentMode = UIViewContentModeBottom;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:10.f];
        [self setTitleColor:[UIColor colorWithHexStr:@"#B7B7B7"] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithHexStr:@"#30313B"] forState:UIControlStateSelected];

        [self addSubview:self.badgeLabel];
//        CGFloat badgeX = SCREEN_WIDTH / 8 + 8;
//        CGFloat badgeY = 4;
        CGFloat badgeX = -((SCREEN_WIDTH / 5) / 2.1);
        CGFloat badgeY = 3;
        CGFloat badgeWH = 12;
        _badgeLabel.frame = CGRectMake(badgeX, badgeY, badgeWH, badgeWH);
    }
    
    return self;
}


/** 重写该方法可以去除长按按钮时出现的高亮效果*/
- (void)setHighlighted:(BOOL)highlighted
{
    
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height*TabBarButtonImageRatio;
    return CGRectMake(0, 0, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height*TabBarButtonImageRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

- (void)setTabBarItem:(UITabBarItem *)tabBarItem
{
    _tabBarItem = tabBarItem;
    [self setTitle:self.tabBarItem.title forState:UIControlStateNormal];
    [self setImage:self.tabBarItem.image forState:UIControlStateNormal];
    [self setImage:self.tabBarItem.selectedImage forState:UIControlStateSelected];
}

- (void)setBadgeCount:(NSString *)badgeCount {
    _badgeCount = badgeCount;
    if (_badgeCount.integerValue > 9) {
        _badgeCount = @"9+";
    }
    if ([badgeCount isEqualToString:@""] || [badgeCount integerValue] == 0) {
        _badgeLabel.hidden = YES;
    }else {
        _badgeLabel.text = _badgeCount;
        _badgeLabel.hidden = NO;
    }
    
    if ([_badgeCount isEqualToString:@"9+"]) {
        CGRect rect = [UILabel getLabelRectByLabel:_badgeLabel maxWidth:MAXFLOAT];
        [_badgeLabel changeWidth:rect.size.width + 6];
    }
}

- (UILabel *)badgeLabel {
    if (!_badgeLabel) {
        _badgeLabel = [[UILabel alloc] init];
        _badgeLabel.textColor = [UIColor whiteColor];
        _badgeLabel.backgroundColor = RGBA(255, 93, 50, 1);
        _badgeLabel.font = [UIFont systemFontOfSize:8];
        _badgeLabel.layer.cornerRadius = 12 * 0.5;
        _badgeLabel.layer.masksToBounds = YES;
        _badgeLabel.hidden = YES;
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _badgeLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
