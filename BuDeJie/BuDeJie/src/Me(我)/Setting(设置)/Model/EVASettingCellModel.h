//
//  EVASettingCellModel.h
//  BuDeJie
//
//  Created by 李元华 on 2018/6/8.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EVASettingCellModel : NSObject

@property (nonatomic, strong) UIImage *icon;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subTitle;

+ (instancetype)settingCellModelWithtitle:(NSString *)title;
+ (instancetype)settingCellModelIcon:(UIImage *)icon title:(NSString *)title;
@end
