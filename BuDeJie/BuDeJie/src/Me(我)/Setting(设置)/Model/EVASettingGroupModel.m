//
//  EVASettingGroupModel.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/8.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVASettingGroupModel.h"

@implementation EVASettingGroupModel

+ (instancetype)settingGroupWithCellModelArr:(NSArray *)arr {
    EVASettingGroupModel *model = [[self alloc] init];
    model.cellModelArr = arr;
    return model;
}
@end
