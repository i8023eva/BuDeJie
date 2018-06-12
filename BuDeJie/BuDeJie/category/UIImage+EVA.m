//
//  UIImage+EVA.m
//  彩票 Demo
//
//  Created by 李元华 on 2018/4/22.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "UIImage+EVA.h"

@implementation UIImage (EVA)

- (UIImage *)eva_renderOriginalName {
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (UIImage *)eva_stretchableImage {
    return [self stretchableImageWithLeftCapWidth:self.size.width * 0.5 topCapHeight:self.size.width * 0.5];
}

+ (UIImage *)eva_launchImage {
    /*
     一次性的放在 bundle 中加载
     */
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LaunchImage" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    
    if (eva_iPhoneX) {
        NSString *file = [bundle pathForResource:@"Default-Portrait-2436h@3x" ofType:@"png"];
        return [UIImage imageWithContentsOfFile:file];
    } else if (eva_iPhone6P) {
        NSString *file = [bundle pathForResource:@"Default-Portrait-736h@3x" ofType:@"png"];
        return [UIImage imageWithContentsOfFile:file];
    } else if (eva_iPhone6) {
        NSString *file = [bundle pathForResource:@"Default-667h@2x" ofType:@"png"];
        return [UIImage imageWithContentsOfFile:file];
    } else if (eva_iPhone5) {
        NSString *file = [bundle pathForResource:@"Default-568h@2x" ofType:@"png"];
        return [UIImage imageWithContentsOfFile:file];
    } else if (eva_iPhone4) {
        NSString *file = [bundle pathForResource:@"Default@2x" ofType:@"png"];
        return [UIImage imageWithContentsOfFile:file];
    }
    return nil;
}

- (UIImage *)circleImageWithContext {
    // 1.开启图形上下文
    // 比例因素:当前点与像素比例
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    // 2.描述裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    // 3.设置裁剪区域;
    [path addClip];
    // 4.画图片
    [self drawAtPoint:CGPointZero];
    // 5.取出图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 6.关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}
@end
