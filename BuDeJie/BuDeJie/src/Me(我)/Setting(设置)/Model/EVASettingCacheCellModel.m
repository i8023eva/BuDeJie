//
//  EVASettingCacheCellModel.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/8.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVASettingCacheCellModel.h"
#import "EVAFileManager.h"

@implementation EVASettingCacheCellModel

@synthesize subTitle = _subTitle;
//
//+ (instancetype)settingCellModelIcon:(UIImage *)icon title:(NSString *)title {
//    EVASettingCacheCellModel *model = [[self alloc] init];
//    model.icon = icon;
//    model.title = title;
//
//    model.subTitle = [NSString stringWithFormat:@"%ld", [EVAFileManager getSize]];
////    [EVAFileManager getCacheSizeCompletion:^(NSString *size) {
////        model.subTitle = size;
////    }];
//    return model;
//}

- (void)setSubTitle:(NSString *)subTitle {
    NSUInteger totalSize = subTitle.integerValue;
    if (totalSize > 1000 * 1000) {
        // MB
        CGFloat sizeF = totalSize / 1000.0 / 1000.0;
        _subTitle = [NSString stringWithFormat:@"%.1fMB",sizeF];
    } else if (totalSize > 1000) {
        // KB
        CGFloat sizeF = totalSize / 1000.0;
        _subTitle = [NSString stringWithFormat:@"%.1fKB",sizeF];
    } else {
        // B
        _subTitle = [NSString stringWithFormat:@"%0ldB",totalSize];
    }
}

@end
