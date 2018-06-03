//
//  EVAMeViewController.m
//  BuDeJie
//
//  Created by 李元华 on 2018/5/31.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVAMeViewController.h"
#import "UIBarButtonItem+EVA.h"
#import "EVASettingTableViewController.h"

@interface EVAMeViewController ()

@end

@implementation EVAMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = eva_RandomColor;

    [self setupNavigationItem];
}

- (void)settingClick:(UIButton *)button {
    EVASettingTableViewController *vc = [[EVASettingTableViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    // 修改tabBra的frame
//    CGRect frame = self.tabBarController.tabBar.frame;
//    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
//    self.tabBarController.tabBar.frame = frame;
}

- (void)nightClick:(UIButton *)button {
    button.selected = !button.isSelected;
}

- (void)setupNavigationItem {
    // 设置
    UIBarButtonItem *settingItem =  [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"]
                                                  highlightedImage:[UIImage imageNamed:@"mine-setting-icon-click"]
                                                            target:self
                                                            action:@selector(settingClick:)];
    // 夜间
    UIBarButtonItem *nightItem =  [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"]
                                                   selectedImage:[UIImage imageNamed:@"mine-moon-icon-click"]
                                                          target:self
                                                          action:@selector(nightClick:)];
    self.navigationItem.rightBarButtonItems = @[settingItem, nightItem];
    self.navigationItem.title = @"我的";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
