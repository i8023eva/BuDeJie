//
//  EVASettingTableViewController.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/2.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVASettingTableViewController.h"
#import "EVAFileManager.h"

#import <SDImageCache.h>

@interface EVASettingTableViewController ()

@end

@implementation EVASettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    [self setupGroup0];
    [self setupGroup1];
}

- (void)setupGroup0 {
    EVASettingCacheCellModel *cellModel = [EVASettingCacheCellModel settingCellModelWithtitle:@"清除缓存"];
    
    NSArray *cellModel_Arr = @[cellModel];
    EVASettingGroupModel *groupModel = [EVASettingGroupModel settingGroupWithCellModelArr:cellModel_Arr];
    groupModel.headTitle = @"清除缓存";
    [self.groupModel_Arr addObject:groupModel];
}

- (void)setupGroup1 {
    EVASettingCellModel *cellModel_0 = [EVASettingCellModel settingCellModelIcon:[UIImage imageNamed:@"mine-setting-icon"] title:@"设置"];
    EVASettingCellModel *cellModel_1 = [EVASettingCellModel settingCellModelIcon:[UIImage imageNamed:@"mine-setting-icon"] title:@"设置"];
    EVASettingCellModel *cellModel_2 = [EVASettingCellModel settingCellModelIcon:[UIImage imageNamed:@"mine-setting-icon"] title:@"设置"];
    EVASettingCellModel *cellModel_3 = [EVASettingCellModel settingCellModelIcon:[UIImage imageNamed:@"mine-setting-icon"] title:@"设置"];
    
    NSArray *cellModel_Arr = @[cellModel_0, cellModel_1, cellModel_2, cellModel_3];
    EVASettingGroupModel *groupModel = [EVASettingGroupModel settingGroupWithCellModelArr:cellModel_Arr];
    [self.groupModel_Arr addObject:groupModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
