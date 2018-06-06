//
//  UIView+EVA.h
//  彩票 Demo
//
//  Created by 李元华 on 2018/4/22.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (EVA)

// 在分类中 @property 只会生成get, set方法,并不会生成下划线的成员属性
@property (nonatomic, assign) CGFloat eva_x;
@property (nonatomic, assign) CGFloat eva_y;
@property (nonatomic, assign) CGFloat eva_width;
@property (nonatomic, assign) CGFloat eva_height;
@property CGFloat eva_centerX;
@property CGFloat eva_centerY;
@end
