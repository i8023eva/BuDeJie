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
@end
