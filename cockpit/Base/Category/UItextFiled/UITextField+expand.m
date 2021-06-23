//
//  UITextField+expand.m
//  YouFenXiao
//
//  Created by mxd_iOS on 2017/3/27.
//  Copyright © 2017年 Xudong.ma. All rights reserved.
//

#import "UITextField+expand.h"
#import <objc/runtime.h>

@implementation UITextField (expand)

+ (instancetype)desplayWithPlaceholder:(NSString *)placeholder
                                  rect:(CGRect)rect
                          keyboardType:(UIKeyboardType)keyboardType
                       clearButtonMode:(UITextFieldViewMode)clearButtonMode
                       secureTextEntry:(BOOL)secureTextEntry
{
    UITextField *textField = [[UITextField alloc] initWithFrame:rect];
    textField.tintColor          = [UIColor colorWithHexStr:@"#999999"];
    textField.placeholder        = placeholder;
    textField.keyboardType       = keyboardType;
    textField.clearButtonMode    = clearButtonMode;
    textField.secureTextEntry    = secureTextEntry;
    textField.backgroundColor    = [UIColor clearColor];
    textField.font               = [UIFont systemFontOfSize:13.f];
    
    //kvc改图片
    UIButton *button = [textField valueForKey:@"_clearButton"];
    [button setImage:[UIImage imageNamed:@"D_delate"] forState:UIControlStateNormal];
    
    return textField;
}

+ (BOOL)isStringContainsEmoji:(UITextField *)textField
{
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:0 error:nil];
    
    NSString *noEmojiStr = [regularExpression stringByReplacingMatchesInString:textField.text options:0 range:NSMakeRange(0, textField.text.length) withTemplate:@""];
    
    if (![noEmojiStr isEqualToString:textField.text]) {
        
        textField.text = noEmojiStr;
        [SVProgressHUD showErrorWithStatus:@"昵称设置暂不支持输入表情"];
        
        return NO;
    }
    
    return YES;
}

//是否含有表情
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop)
     {
         const unichar hs = [substring characterAtIndex:0];
         
         
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
             
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
         } else {
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

//textfield限制只能输入数字和字母
+ (BOOL)validatePwdStr:(NSString *)pwdStr {
    NSUInteger lengthOfString = pwdStr.length;//lengthOfString的值始终为1
    
    for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
        
        unichar character = [pwdStr characterAtIndex:loopIndex];//将输入的值转化为ASCII值（即内部索引值），可以参考ASCII表
        
        // 48-57;{0,9};65-90;{A..Z};97-122:{a..z}
        
        if (character < 48) return NO; // 48 unichar for 0
        
        if (character > 57 && character < 65) return NO; //
        
        if (character > 90 && character < 97) return NO;
        
        if (character > 122) return NO;
    }
    
    return YES;
}

//textfield限制只能输入数字
+ (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}


static char limit;

- (void)setLimitBlock:(LimitBlock)limitBlock {
    objc_setAssociatedObject(self, &limit, limitBlock, OBJC_ASSOCIATION_COPY);
}

- (LimitBlock)limitBlock {
    return objc_getAssociatedObject(self, &limit);
}

- (void)setMaxTextLength:(NSInteger)maxTextLength{
    objc_setAssociatedObject(self, @selector(maxTextLength), [NSNumber numberWithInteger:maxTextLength], OBJC_ASSOCIATION_ASSIGN);
}
- (NSInteger)maxTextLength{
    return [objc_getAssociatedObject(self, @selector(maxTextLength)) integerValue];
}

- (void)lengthLimit:(void (^)(NSString *))limit {
    [self addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    self.limitBlock = limit;
}

- (void)textFieldEditChanged:(UITextField *)textField {
    NSString *toBeString = textField.text;
    //获取高亮部分
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position){
        if (toBeString.length > self.maxTextLength)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.maxTextLength];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:self.maxTextLength];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.maxTextLength)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
    if (self.limitBlock) {
        self.limitBlock(textField.text);
    }
}


@end
