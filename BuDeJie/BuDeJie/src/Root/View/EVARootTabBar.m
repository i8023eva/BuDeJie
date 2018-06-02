//
//  EVARootTabBar.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/1.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVARootTabBar.h"

@interface EVARootTabBar ()

@property (nonatomic, weak) UIButton *publishBtn;
@end

@implementation EVARootTabBar

- (UIButton *)publishBtn {
    if (_publishBtn == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [button sizeToFit];
        [self addSubview:button];
        _publishBtn = button;
    }
    return _publishBtn;
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    宽度要等分
    NSInteger count = self.items.count;
    CGFloat btnW = self.eva_width / (count + 1);
    CGFloat btnH = 49;
    NSLog(@"eva_height - %f", self.eva_height);
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    int i = 0;
    for (UIView *objc in self.subviews) {
        if ([objc isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            空出中间
            if (i == 2) {
                i++;
            }
            btnX = i * btnW;
            objc.frame = CGRectMake(btnX, btnY, btnW, btnH);
            i++;
        }
    }
    self.publishBtn.center = CGPointMake(self.eva_width * 0.5, btnH * 0.5);
    
    
//    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - 10, self.frame.size.width, 49);
}


@end
