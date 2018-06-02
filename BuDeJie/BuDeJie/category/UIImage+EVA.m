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
@end
