//
//  EVASettingCellModel.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/8.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVASettingCellModel.h"

@implementation EVASettingCellModel

+ (instancetype)settingCellModelWithtitle:(NSString *)title {
    return [self settingCellModelIcon:nil title:title];
}

+ (instancetype)settingCellModelIcon:(UIImage *)icon title:(NSString *)title {
    EVASettingCellModel *model = [[self alloc] init];
    model.icon = icon;
    model.title = title;
    return model;
}



@end
