//
//  EVASettingGroupModel.h
//  BuDeJie
//
//  Created by 李元华 on 2018/6/8.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EVASettingGroupModel : NSObject

@property (nonatomic, copy) NSString *headTitle;

@property (nonatomic, copy) NSString *footTitle;

@property (nonatomic, strong) NSArray *cellModelArr;

+ (instancetype)settingGroupWithCellModelArr:(NSArray *)arr;
@end
