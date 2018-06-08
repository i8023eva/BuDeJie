//
//  EVABaseSettingTableViewController.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/8.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVABaseSettingTableViewController.h"
#import "EVAFileManager.h"

@interface EVABaseSettingTableViewController ()

@property (nonatomic, assign) NSUInteger fileSize;

@end

static NSString * const ID = @"cell";

@implementation EVABaseSettingTableViewController

- (NSMutableArray<EVASettingGroupModel *> *)groupModel_Arr {
    if (_groupModel_Arr == nil) {
        _groupModel_Arr = [NSMutableArray array];
    }
    return _groupModel_Arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [EVAFileManager getCacheSizeCompletion:^(NSUInteger size) {
        self.fileSize = size;
        [self.tableView reloadData];
    }];
}

- (instancetype)init {
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groupModel_Arr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groupModel_Arr[section].cellModelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EVASettingTableViewCell *cell = [EVASettingTableViewCell cellWithTableView:tableView Identifier:ID];
    
    EVASettingGroupModel *groupModel = self.groupModel_Arr[indexPath.section];
    EVASettingCellModel *cellModel = groupModel.cellModelArr[indexPath.row];
    
    if ([cellModel isKindOfClass:[EVASettingCacheCellModel class]]) {
        cellModel.subTitle = [NSString stringWithFormat:@"%ld", self.fileSize];
    }
    
    cell.cellModel = cellModel;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.groupModel_Arr[section].headTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return self.groupModel_Arr[section].footTitle;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    EVASettingGroupModel *groupModel = self.groupModel_Arr[indexPath.section];
    EVASettingCellModel *cellModel = groupModel.cellModelArr[indexPath.row];
    
    if ([cellModel isKindOfClass:[EVASettingCacheCellModel class]]) {
        [EVAFileManager clearDisk];
        self.fileSize = 0;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
