//
//  UITextField+EVA.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/6.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "UITextField+EVA.h"
#import <objc/message.h>

@implementation UITextField (EVA)

+ (void)initialize {
    if (self == [UITextField class]) {
        Method sys_method = class_getInstanceMethod(self, @selector(setPlaceholder:));
        Method eva_method = class_getInstanceMethod(self, @selector(setEVA_placeholder:));
        
        method_exchangeImplementations(sys_method, eva_method);
    }
}

- (void)setEVA_placeholder:(NSString *)placeholder {
    [self setEVA_placeholder:placeholder];
    
    self.placeholderColor = self.placeholderColor;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
//    变成成员属性
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UILabel *_placeholderLabel = [self valueForKeyPath:@"placeholderLabel"];
    _placeholderLabel.textColor = placeholderColor;
}

- (UIColor *)placeholderColor {
    return objc_getAssociatedObject(self, @"placeholderColor");
}
@end
