//
//  UIView+EVA.m
//  彩票 Demo
//
//  Created by 李元华 on 2018/4/22.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "UIView+EVA.h"

@implementation UIView (EVA)

- (CGFloat)eva_x {
    return self.frame.origin.x;
}

- (void)setEva_x:(CGFloat)eva_x {
    CGRect frame = self.frame;
    frame.origin.x = eva_x;
    self.frame = frame;
}

- (CGFloat)eva_y {
    return self.frame.origin.y;
}

- (void)setEva_y:(CGFloat)eva_y {
    CGRect rect = self.frame;
    rect.origin.y = eva_y;
    self.frame = rect;
}

- (CGFloat)eva_width {
    return self.frame.size.width;
}

- (void)setEva_width:(CGFloat)eva_width {
    CGRect rect = self.frame;
    rect.size.width = eva_width;
    self.frame = rect;
}

- (CGFloat)eva_height {
    return self.frame.size.height;
}

- (void)setEva_height:(CGFloat)eva_height {
    CGRect rect = self.frame;
    rect.size.height = eva_height;
    self.frame = rect;
}

- (void)setEva_centerX:(CGFloat)eva_centerX
{
    CGPoint center = self.center;
    center.x = eva_centerX;
    self.center = center;
}

- (CGFloat)Eva_centerX
{
    return self.center.x;
}

- (void)setEva_centerY:(CGFloat)eva_centerY
{
    CGPoint center = self.center;
    center.y = eva_centerY;
    self.center = center;
}

- (CGFloat)Eva_centerY
{
    return self.center.y;
}
@end
