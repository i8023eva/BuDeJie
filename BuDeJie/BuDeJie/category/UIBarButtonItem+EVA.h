//
//  UIBarButtonItem+EVA.h
//  BuDeJie
//
//  Created by 李元华 on 2018/6/2.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (EVA)

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image
                  highlightedImage:(UIImage *)highlightedImage
                            target:(id)target
                            action:(SEL)action;

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image
                     selectedImage:(UIImage *)selectedImage
                            target:(id)target
                            action:(SEL)action;

+ (UIBarButtonItem *)backItemWithImage:(UIImage *)image
                         highlightedImage:(UIImage *)highlightedImage
                                target:(id)target
                                action:(SEL)action
                                 title:(NSString *)title;
@end
