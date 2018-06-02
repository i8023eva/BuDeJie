//
//  UIBarButtonItem+EVA.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/2.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "UIBarButtonItem+EVA.h"

@implementation UIBarButtonItem (EVA)

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image
                  highlightedImage:(UIImage *)highlightedImage
                            target:(id)target
                            action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlightedImage forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image
                  selectedImage:(UIImage *)selectedImage
                            target:(id)target
                            action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
