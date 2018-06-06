//
//  EVAFastLoginButton.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/6.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVAFastLoginButton.h"

@implementation EVAFastLoginButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    图片居中
//    self.imageView.eva_y = 0;
    self.imageView.eva_centerX = self.eva_width * 0.5;
    
//    标题在图片下面
    self.titleLabel.eva_y = self.eva_height - self.titleLabel.eva_height;
    [self.titleLabel sizeToFit];//label 会移动 - 内部会改变 center, 放在上面
    self.titleLabel.eva_centerX = self.eva_width * 0.5;
}

@end
