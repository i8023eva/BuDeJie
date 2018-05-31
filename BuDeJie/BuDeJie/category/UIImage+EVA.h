//
//  UIImage+EVA.h
//  彩票 Demo
//
//  Created by 李元华 on 2018/4/22.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (EVA)
/**返回不渲染的图片*/
- (UIImage *)renderOriginalName;
/**返回拉伸图片*/
- (UIImage *)stretchableImage;

@end
