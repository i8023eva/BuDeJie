//
//  EVALoginRegisterView.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/5.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVALoginRegisterView.h"

@implementation EVALoginRegisterView

+ (instancetype)loginView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

+ (instancetype)registerView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}

@end
