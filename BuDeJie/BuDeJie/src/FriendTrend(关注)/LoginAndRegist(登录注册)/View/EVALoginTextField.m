//
//  EVALoginTextField.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/6.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVALoginTextField.h"
#import "UITextField+EVA.h"

@implementation EVALoginTextField

/*
 光标颜色 - 改一次
 占位文字颜色改变 - 开始编辑 - 1.代理 2.通知 3.target
        > 结束编辑变回颜色
 */
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tintColor = [UIColor whiteColor];
    
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    
//    UITextField *text;
    /*
     UITextFieldLabel - 断点获取 - _placeholderLabel
     */
    self.placeholderColor = [UIColor lightGrayColor];
    
//    NSDictionary *attrs = @{
//                            NSForegroundColorAttributeName : [UIColor lightGrayColor]
//                            };
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
}

- (void)textBegin
{
    self.placeholderColor = [UIColor whiteColor];
//    NSDictionary *attrs = @{
//                                   NSForegroundColorAttributeName : [UIColor whiteColor]
//                                   };
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
}

- (void)textEnd
{
    self.placeholderColor = [UIColor lightGrayColor];
//    NSDictionary *attrs = @{
//                            NSForegroundColorAttributeName : [UIColor lightGrayColor]
//                                   };
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x+5, bounds.origin.y, bounds.size.width, bounds.size.height);
}

@end
