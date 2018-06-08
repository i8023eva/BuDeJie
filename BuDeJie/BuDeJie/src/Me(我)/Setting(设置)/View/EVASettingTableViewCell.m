//
//  EVASettingTableViewCell.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/8.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVASettingTableViewCell.h"

@implementation EVASettingTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView Identifier:(NSString *)identifier {
    return [self cellWithTableView:tableView identifier:identifier cellStyle:UITableViewCellStyleValue1];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier cellStyle:(UITableViewCellStyle)cellStyle {
    EVASettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[EVASettingTableViewCell alloc] initWithStyle:cellStyle reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setCellModel:(EVASettingCellModel *)cellModel {
    _cellModel = cellModel;
    
    self.textLabel.text = cellModel.title;
    self.imageView.image = cellModel.icon;
    self.detailTextLabel.text = cellModel.subTitle;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

//    NSLog(@"%s", __func__);多次
//    if ([_cellModel isKindOfClass:[EVASettingCacheCellModel class]]) {
//    这个方法会保留上次cell , 不行
//        NSLog(@"%@", _cellModel);
//    }
}

@end
