//
//  DGTools.m
//  DiscipleGroup
//
//  Created by maxudong on 2019/12/12.
//  Copyright © 2019 maxudong. All rights reserved.
//

#import "DGTools.h"
#import "UIDevice+DGDeviceInfo.h"

@interface DGTools ()

@end

@implementation DGTools

+ (__kindof DGTools *)instance
{
    static DGTools *tools = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        tools = [[DGTools alloc] init];
    });
    
    return tools;
}

+ (void)checkLoginWithIsOnlyNoramal:(BOOL)noraml {
    if (kStringIsEmpty([DGUserInfo instance].token)) {
        //未登录
        UIViewController *vc = [UIViewController currentViewController];
        if (noraml) {
            //普通登录
            [vc showSignInVC];
            return;
        }else{
            //一键登录加普通登录
            if (vc && ![vc isKindOfClass:[CPLoginViewController class]] && ![vc isKindOfClass:NSClassFromString(@"JVTelecomViewController")]) {
//                BOOL isVerifyEnabled = JVERIFICATIONService.checkVerifyEnable;
//                if (!isVerifyEnabled) {
//                    [vc showSignInVC];
//                    return;
//                }
//                [JVERIFICATIONService getAuthorizationWithController:vc hide:YES animated:YES timeout: 15 * 10000 completion:^(NSDictionary *result) {
//                    NSLog(@"%@", result);
//                    if ([result[@"code"] intValue] == 2016 || [result[@"code"] intValue] == 2006 || [result[@"code"] intValue] == 4033 || [result[@"code"] intValue] == 6001 || [result[@"code"] intValue] == 2005) {
//                        [vc showSignInVC];
//                        return;
//                    }
//                    if ([result[@"code"] intValue] == 6004) {
//                        [JVERIFICATIONService dismissLoginControllerAnimated:NO completion:^{
//                            [DGTools checkLoginWithIsOnlyNoramal:noraml];
//                        }];
//                    }
//                    if ([result[@"code"] intValue] == 6002) {
//                        // 点击取消
//                        return;
//                    }
//                    if (!kStringIsEmpty(result[@"loginToken"])) {
//                        [DGTools quickLoginWith:result[@"loginToken"]];
//                    }
//                } actionBlock:^(NSInteger type, NSString *content) {
//                    NSLog(@"%@", content);
//                }];
            }
        }
    }
    
}
+ (void)quickLoginWith:(NSString *)token{
    NSDictionary *parameters = @{@"loginToken":token,
                                 @"source":@3};
    [[RequestAPIClient APIClientInstance] sendJsonRequestPath:kLoginUrl params:parameters method:Post_Method success:^(id  _Nonnull responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 0) {
            NSDictionary *data = responseObject[@"data"];
            if (!kDictIsEmpty(data)) {
                DGUserInfo *userInfo = [DGUserInfoManager unarchive];
                userInfo.token = [NSString stringWithFormat:@"%@",data[@"token"]];
                userInfo.userHaveAgreedTime =  [data[@"userHaveAgreedTime"] integerValue];
                userInfo.identity = [data[@"identity"] integerValue];
                userInfo.phone = [NSString stringWithFormat:@"%@",data[@"phone"]];
                [DGUserInfoManager archiveToFileWith:userInfo];
                
                [[UIViewController currentViewController] dismissViewControllerAnimated:YES completion:^{
                }];
            }
        } else {
            [DGTools showInfo:responseObject[@"msg"]];
        }
    } failure:^(id  _Nonnull responseObject) {
        
    }];
}

/** 设置默认token（暂时写死）*/
- (void)dealLocalToken
{
//    NSString *tokenFirst  = @"MTc3NDQ1OTQyODIyNzA4";
//    NSString *tokenSecond = @"MTc3NDQ1OTQyODI5MjUx";
//    NSString *tokenThird  = @"MTc3MTg0NDI5NzkxMDE3";
//    
//    DGLog(@"tokenFirst==>%@ tokenSecond==>%@ tokenThird==>%@", tokenFirst, tokenSecond, tokenThird);
//    DGUserInfo *userInfo = [DGUserInfoManager unarchive];
//    userInfo.token = tokenFirst;
//    [DGUserInfoManager archiveToFileWith:userInfo];
    NSString *tokenFirst  = @"MTM2NjEwNTg0MDUyMzQ1";
    NSString *tokenSecond = @"MTc3NDQ1OTQyODI5MjUx";
    NSString *tokenThird  = @"MTc3MTg0NDI5NzkxMDE3";
    
    DGLog(@"tokenFirst==>%@ tokenSecond==>%@ tokenThird==>%@", tokenFirst, tokenSecond, tokenThird);
    DGUserInfo *userInfo = [DGUserInfoManager unarchive];
    userInfo.token = tokenFirst;
    [DGUserInfoManager archiveToFileWith:userInfo];
}

+ (void)showInfo:(NSString *)info {
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD showImage:[UIImage imageNamed:@"123"] status:info];
    [SVProgressHUD dismissWithDelay:1.5];
}
+ (void)showInfo:(NSString *)info delyTime:(float)time{
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD showImage:[UIImage imageNamed:@"123"] status:info];
    [SVProgressHUD dismissWithDelay:time];
}

/**
 *过滤HTML标签
 */
+ (NSAttributedString *)filterHtmlTags:(NSString *)content {
    return [[NSAttributedString alloc] initWithData:[content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
}

//去除标签的方法
+(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
        //去除空格 &nbsp;
        html = [html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    }
    return html;
}
+ (NSString *)filterHTMLLabel:(NSString *)string {
    NSRegularExpression * regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n" options:0 error:nil];
    string = [regularExpretion stringByReplacingMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length) withTemplate:@""];
    return string;
}

+ (NSMutableAttributedString *)richText:(NSString *)str color:(UIColor *)color font:(UIFont *)font clickStr:(NSString *)clickStr clickColor:(UIColor *)clickColor clickBlock:(void(^)(void))clickBlock{
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color}];
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:clickStr attributes:@{NSFontAttributeName:font}];
    [attriString appendAttributedString:string];
    NSRange allRange = NSMakeRange(0, attriString.length);
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 5;
    [attriString addAttribute:NSParagraphStyleAttributeName value:style range:allRange];
    [attriString setTextHighlightRange:NSMakeRange(str.length + 1, 3) color:clickColor backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        if (clickBlock) {
            clickBlock();
        }
    }];
    return attriString;
}

+ (NSMutableAttributedString *)foldingAndPasteboardRichText:(NSString *)str color:(UIColor *)color font:(UIFont *)font clickStr:(NSString *)clickStr clickColor:(UIColor *)clickColor pasteboardClickBlock:(void(^)(void))pasteboardClickBlock foldingClickBlock:(void(^)(void))foldingClickBlock {
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color}];
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:clickStr attributes:@{NSFontAttributeName:font}];
    [attriString appendAttributedString:string];
    
    NSRange allRange = NSMakeRange(0, attriString.length);
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 5;
    [attriString addAttribute:NSParagraphStyleAttributeName value:style range:allRange];
 
    //复制
    NSRange contentRange = NSMakeRange(0, str.length);
    [attriString setTextHighlightRange:contentRange color:color backgroundColor:[UIColor whiteColor] userInfo:@{} tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        if (pasteboardClickBlock) {
            UIPasteboard *pboard = [UIPasteboard generalPasteboard];
            pboard.string = str;
            pasteboardClickBlock();
        }
    } longPressAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        if (pasteboardClickBlock) {
            UIPasteboard *pboard = [UIPasteboard generalPasteboard];
            pboard.string = str;
            pasteboardClickBlock();
        }
    }];
    //折叠点击
    [attriString setTextHighlightRange:NSMakeRange(str.length + 1, 3) color:clickColor backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        if (foldingClickBlock) {
            foldingClickBlock();
        }
    }];
    return attriString;
}

+ (NSMutableAttributedString *)pasteboardRichText:(NSString *)str color:(UIColor *)color font:(UIFont *)font lineSpace:(float)lineSpace clickBlock:(void(^)(void))clickBlock{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color}];
    NSRange allRange = NSMakeRange(0, string.length);
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpace;
    [string addAttribute:NSParagraphStyleAttributeName value:style range:allRange];
    [string setTextHighlightRange:allRange color:color backgroundColor:[UIColor whiteColor] userInfo:@{} tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        if (clickBlock) {
            UIPasteboard *pboard = [UIPasteboard generalPasteboard];
            pboard.string = str;
            clickBlock();
        }
    } longPressAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        if (clickBlock) {
            UIPasteboard *pboard = [UIPasteboard generalPasteboard];
            pboard.string = str;
            clickBlock();
        }
    }];
    return string;
}

+ (NSMutableAttributedString *)richText:(NSString *)str color:(UIColor *)color font:(UIFont *)font {
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color}];
    NSRange allRange = NSMakeRange(0, attriString.length);
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 5;
    [attriString addAttribute:NSParagraphStyleAttributeName value:style range:allRange];
    return attriString;
}

+ (BOOL)checkHtmlContainsImg:(NSString *)html {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<(img|IMG)(.*?)(/>|></img>|>)" options:NSRegularExpressionAllowCommentsAndWhitespace error:nil];
    NSArray *result = [regex matchesInString:html options:NSMatchingReportCompletion range:NSMakeRange(0, html.length)];
    if (result.count > 0) {
        return YES;
    } else {
        return NO;
    }
}

+ (void)showHUDWithText:(NSString *)text
{
    //显示加载标题
    [SVProgressHUD showWithStatus:text];
    //设置样式
    /*
     SVProgressHUDStyleLight,        // default style, white HUD with black text, HUD background will be blurred
     SVProgressHUDStyleDark,         // black HUD and white text, HUD background will be blurred
     SVProgressHUDStyleCustom        // uses the fore- and background color properties
     */
    //设置HUD的Style
    [SVProgressHUD setDefaultStyle:(SVProgressHUDStyleLight)];
    //设置HUD和文本的颜色
    [SVProgressHUD setForegroundColor:[UIColor colorWithHexStr:@"#CCCCCC"]];
    //设置HUD背景颜色
    [SVProgressHUD setBackgroundColor:[UIColor colorWithHexStr:@"#25262D"]];
    
    /**
     *  设置HUD背景图层的样式
     *
     *  SVProgressHUDMaskTypeNone：默认图层样式，当HUD显示的时候，允许用户交互。
     *
     *  SVProgressHUDMaskTypeClear：当HUD显示的时候，不允许用户交互。
     *
     *  SVProgressHUDMaskTypeBlack：当HUD显示的时候，不允许用户交互，且显示黑色背景图层。
     *
     *  SVProgressHUDMaskTypeGradient：当HUD显示的时候，不允许用户交互，且显示渐变的背景图层。
     *
     *  SVProgressHUDMaskTypeCustom：当HUD显示的时候，不允许用户交互，且显示背景图层自定义的颜色。
     */
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    /*
     SVProgressHUDAnimationTypeFlat,     // default animation type, custom flat animation (indefinite animated ring)
     SVProgressHUDAnimationTypeNative    // iOS native UIActivityIndicatorView
     */
    //动画效果
    [SVProgressHUD setDefaultAnimationType:(SVProgressHUDAnimationTypeNative)];
}

+ (void)bl_Dismiss
{
    [SVProgressHUD dismiss];
}







+ (void)DG_SVProgressHUD_Show {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD setForegroundColor:[UIColor blackColor]];
    [SVProgressHUD show];
}







+ (NSString *)getAge:(NSString *)birthday {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *birthDate=[formatter dateFromString:birthday];

    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger unitFlags = NSCalendarUnitYear;
    NSDateComponents *components = [gregorian components:unitFlags fromDate:birthDate toDate:[NSDate date] options:0];
    
    NSInteger age = [components year] + 1;
    NSString *ageS = [NSString stringWithFormat:@"%ld",(long)age];
    
    return ageS;
}
/// 修改行间距
/// @param text 标题
/// @param space 行间距大小
- (NSMutableAttributedString *)changeText:(NSString *)text LineSpace:(CGFloat)space
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];//你所要设置的行距
    //调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName
                                 value:paragraphStyle
                                 range:NSMakeRange(0, [text length])];
    return attributedString;
}


//+ (void)jgCustomView{
//    JVUIConfig *config = [[JVUIConfig alloc] init];
//    config.navCustom = NO;
//    config.shouldAutorotate = YES;
//    config.autoLayout = YES;
//    
//    config.navReturnHidden = NO;
//    config.privacyTextFontSize = 12;
//    config.navText = [[NSAttributedString alloc]initWithString:@"登录/注册" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:18]}];
//    config.navColor = [UIColor whiteColor];
//    config.navReturnImg = [UIImage imageNamed:@"webview_btn_close"];
//    config.navReturnImageEdgeInsets = UIEdgeInsetsMake(0, -24, 0, 0);
//
//    config.privacyTextAlignment = NSTextAlignmentLeft;
//    config.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//    
//    //logo
//    config.logoImg = [UIImage imageNamed:@"login-logo"];
//    CGFloat logoWidth = config.logoImg.size.width?:100;
//    CGFloat logoHeight = logoWidth;
//    JVLayoutConstraint *logoConstraintX = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemSuper attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
//    JVLayoutConstraint *logoConstraintY = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemSuper attribute:NSLayoutAttributeCenterY multiplier:1 constant:-90];
//    JVLayoutConstraint *logoConstraintW = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemNone attribute:NSLayoutAttributeWidth multiplier:1 constant:logoWidth];
//    JVLayoutConstraint *logoConstraintH = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemNone attribute:NSLayoutAttributeHeight multiplier:1 constant:logoHeight];
//    config.logoConstraints = @[logoConstraintX,logoConstraintY,logoConstraintW,logoConstraintH];
//    config.logoHorizontalConstraints = config.logoConstraints;
//    
//    
//    
//    //号码栏
//    JVLayoutConstraint *numberConstraintX = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemSuper attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
//    JVLayoutConstraint *numberConstraintY = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemSuper attribute:NSLayoutAttributeCenterY multiplier:1 constant:-55];
//    JVLayoutConstraint *numberConstraintW = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemNone attribute:NSLayoutAttributeWidth multiplier:1 constant:130];
//    JVLayoutConstraint *numberConstraintH = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemNone attribute:NSLayoutAttributeHeight multiplier:1 constant:25];
//    config.numberConstraints = @[numberConstraintX,numberConstraintY, numberConstraintW, numberConstraintH];
//    config.numberHorizontalConstraints = config.numberConstraints;
//    
//    //slogan展示
//    JVLayoutConstraint *sloganConstraintX = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemSuper attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
//    JVLayoutConstraint *sloganConstraintY = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemSuper attribute:NSLayoutAttributeCenterY multiplier:1 constant:-20];
//    JVLayoutConstraint *sloganConstraintW = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemNone attribute:NSLayoutAttributeWidth multiplier:1 constant:130];
//    JVLayoutConstraint *sloganConstraintH = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemNone attribute:NSLayoutAttributeHeight multiplier:1 constant:20];
//    config.sloganConstraints = @[sloganConstraintX,sloganConstraintY, sloganConstraintW, sloganConstraintH];
//    config.sloganHorizontalConstraints = config.sloganConstraints;
//    
//    //登录按钮
//    UIImage *login_nor_image = [UIImage imageNamed:@"login-button"];
//    UIImage *login_dis_image = [UIImage imageNamed:@"login-button"];
//    UIImage *login_hig_image = [UIImage imageNamed:@"login-button"];
//    if (login_nor_image && login_dis_image && login_hig_image) {
//        config.logBtnImgs = @[login_nor_image, login_dis_image, login_hig_image];
//    }
//    CGFloat loginButtonWidth = login_nor_image.size.width?:100;
//    CGFloat loginButtonHeight = login_nor_image.size.height?:100;
//    JVLayoutConstraint *loginConstraintX = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemSuper attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
//    JVLayoutConstraint *loginConstraintY = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemSuper attribute:NSLayoutAttributeCenterY multiplier:1 constant:30];
//    JVLayoutConstraint *loginConstraintW = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemNone attribute:NSLayoutAttributeWidth multiplier:1 constant:loginButtonWidth];
//    JVLayoutConstraint *loginConstraintH = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemNone attribute:NSLayoutAttributeHeight multiplier:1 constant:loginButtonHeight];
//    config.logBtnConstraints = @[loginConstraintX,loginConstraintY,loginConstraintW,loginConstraintH];
//    config.logBtnHorizontalConstraints = config.logBtnConstraints;
//    config.logBtnText = @"一键登录";
//    config.logBtnFont = [UIFont systemFontOfSize:17];
//
//    
//    //勾选框
//    UIImage * uncheckedImg = [UIImage imageNamed:@"webview_btn_close"];
//    UIImage * checkedImg = [UIImage imageNamed:@"webview_btn_close"];
//    CGFloat checkViewWidth = uncheckedImg.size.width;
//    CGFloat checkViewHeight = uncheckedImg.size.height;
//    config.uncheckedImg = uncheckedImg;
//    config.checkedImg = checkedImg;
//    JVLayoutConstraint *checkViewConstraintX = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemSuper attribute:NSLayoutAttributeLeft multiplier:1 constant:20];
//    JVLayoutConstraint *checkViewConstraintY = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemPrivacy attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
//    JVLayoutConstraint *checkViewConstraintW = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemNone attribute:NSLayoutAttributeWidth multiplier:1 constant:checkViewWidth];
//    JVLayoutConstraint *checkViewConstraintH = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemNone attribute:NSLayoutAttributeHeight multiplier:1 constant:checkViewHeight];
//    config.checkViewConstraints = @[checkViewConstraintX,checkViewConstraintY,checkViewConstraintW,checkViewConstraintH];
//    config.checkViewHorizontalConstraints = config.checkViewConstraints;
//    
//    
//    //隐私
//    CGFloat spacing = checkViewWidth + 20 + 5;
//    config.privacyState = YES;
//    config.privacyShowBookSymbol = YES;
//    config.privacyTextFontSize = 13;
//    config.privacyLineSpacing = 2;
//    config.privacyTextAlignment = NSTextAlignmentLeft;
//    config.privacyComponents = @[ @"使用手机号码一键登录即代表您已同意 ", @"、", @"和", @" " ];
//    config.appPrivacyOne = @[ @"BOOS驾驶舱用户协议", @"http://test-cockpit-h5.peogoo-inc.com/#/charts" ];
//    config.appPrivacyTwo = @[ @"BOSS驾驶舱隐私政策", @"http://test-cockpit-h5.peogoo-inc.com/#/charts" ];
//    config.appPrivacyColor = @[ [UIColor redColor], [UIColor redColor] ];
//
//    JVLayoutConstraint *privacyConstraintX = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemSuper attribute:NSLayoutAttributeLeft multiplier:1 constant:spacing];
//    JVLayoutConstraint *privacyConstraintX2 = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemSuper attribute:NSLayoutAttributeRight multiplier:1 constant:-spacing];
//    JVLayoutConstraint *privacyConstraintY = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemSuper attribute:NSLayoutAttributeBottom multiplier:1 constant:-10];
//    JVLayoutConstraint *privacyConstraintH = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemNone attribute:NSLayoutAttributeHeight multiplier:1 constant:50];
//    config.privacyConstraints = @[privacyConstraintX,privacyConstraintX2,privacyConstraintY,privacyConstraintH];
//    config.privacyHorizontalConstraints = config.privacyConstraints;
//    
//    
//    //loading
//    JVLayoutConstraint *loadingConstraintX = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemSuper attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
//    JVLayoutConstraint *loadingConstraintY = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemSuper attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
//    JVLayoutConstraint *loadingConstraintW = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemNone attribute:NSLayoutAttributeWidth multiplier:1 constant:30];
//    JVLayoutConstraint *loadingConstraintH = [JVLayoutConstraint constraintWithAttribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:JVLayoutItemNone attribute:NSLayoutAttributeHeight multiplier:1 constant:30];
//    config.loadingConstraints = @[loadingConstraintX,loadingConstraintY,loadingConstraintW,loadingConstraintH];
//    config.loadingHorizontalConstraints = config.loadingConstraints;
//    
//    // 协议页面
//    config.agreementNavBackgroundColor = [UIColor whiteColor];
//    config.agreementNavTextColor = [UIColor colorWithHexStr:@"#333333"];
//    config.agreementNavTextFont = [UIFont systemFontOfSize:18];
//    config.agreementNavReturnImage = [UIImage imageNamed:@"webview_btn_close"];
//    
//    /*
//     config.authPageBackgroundImage = [UIImage imageNamed:@"背景图"];
//     config.navColor = [UIColor redColor];
//     config.preferredStatusBarStyle = 0;
//     config.navText = [[NSAttributedString alloc] initWithString:@"自定义标题"];
//     config.navReturnImg = [UIImage imageNamed:@"自定义返回键"];
//     UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//     button.frame = CGRectMake(0, 0, 44, 44);
//     button.backgroundColor = [UIColor greenColor];
//     config.navControl = [[UIBarButtonItem alloc] initWithCustomView:button];
//     config.logoHidden = NO;
//     config.logBtnText = @"自定义登录按钮文字";
//     config.logBtnTextColor = [UIColor redColor];
//     config.numberColor = [UIColor blueColor];
//     config.appPrivacyOne = @[@"应用自定义服务条款1",@"https://www.jiguang.cn/about"];
//     config.appPrivacyTwo = @[@"应用自定义服务条款2",@"https://www.jiguang.cn/about"];
//     config.privacyComponents = @[@"文本1",@"文本2",@"文本3",@"文本4"];
//     config.appPrivacyColor = @[[UIColor redColor], [UIColor blueColor]];
//     config.sloganTextColor = [UIColor redColor];
//     config.navCustom = NO;
//     config.numberSize = 24;
//     config.privacyState = YES;
//     */
//    [JVERIFICATIONService customUIWithConfig:config customViews:^(UIView *customAreaView) {
//       
//        UIButton *temButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [temButton setTitle:@"其他登录方式" forState:UIControlStateNormal];
//        temButton.layer.cornerRadius = 22;
//        [temButton setTitleColor:[UIColor colorWithHexStr:@"#999999"] forState:UIControlStateNormal];
//        temButton.backgroundColor = [UIColor colorWithHexStr:@"#F9F9F9"];
//        UIWindow *window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//        if (@available(iOS 11.0, *)) {
//            temButton.frame = CGRectMake(38, 252+44+window.safeAreaInsets.top, kScreenWidth - 76, 44);
//        } else {
//            // Fallback on earlier versions
//        }
//        [customAreaView addSubview:temButton];
//        [temButton addTapHadnle:^{
//            DGLog(@"xxxx");
//        }];
//    }];
//
//    
//}

@end
