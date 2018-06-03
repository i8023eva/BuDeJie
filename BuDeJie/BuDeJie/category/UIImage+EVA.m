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
    if (eva_iPhoneX) {
        return [UIImage imageNamed:@"Default-Portrait-2436h@3x.png"];
    } else if (eva_iPhone6P) {
        return [UIImage imageNamed:@"Default-Portrait-736h@3x.png"];
    } else if (eva_iPhone6) {
        return [UIImage imageNamed:@"Default-667h@2x.png"];
    } else if (eva_iPhone5) {
        return [UIImage imageNamed:@"Default-568h@2x.png"];
    } else if (eva_iPhone4) {
        return [UIImage imageNamed:@"Default@2x.png"];
    }
    return nil;
}
@end
