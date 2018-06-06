//
//  EVAMeTableViewController.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/6.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVAMeTableViewController.h"
#import "EVASettingTableViewController.h"
#import "UIBarButtonItem+EVA.h"
#import "EVAMeCollectionViewCell.h"
#import "EVAMeModel.h"

#import <AFNetworking.h>
#import <MJExtension.h>

@interface EVAMeTableViewController () <UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *model_Arr;
@property (nonatomic, weak) UICollectionView *collectionView;

@end

/**
 静态 cell - storyboard
 */
@implementation EVAMeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationItem];
    
    [self setupFooterView];
    
    [self loadDate];
}

/**
 http://s.budejie.com/op/square2/budejie-android-7.0.0/360zhushou/0-100.json
 square_list: []
 */
- (void)loadDate {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"http://s.budejie.com/op/square2/budejie-android-7.0.0/360zhushou/0-100.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *square_list = responseObject[@"square_list"];
        self.model_Arr = [EVAMeModel mj_objectArrayWithKeyValuesArray:square_list];
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

/**
 collectionView
 */
- (void)setupFooterView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    NSInteger cols = 4;
    CGFloat margin = 1;
    CGFloat itemWH = (eva_screenW - (cols - 1) * margin) / cols;
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumLineSpacing = margin;
    layout.minimumInteritemSpacing = margin;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    collectionView.backgroundColor = self.tableView.backgroundColor;
    self.tableView.tableFooterView = collectionView;
    self.collectionView = collectionView;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([EVAMeCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([self class])];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model_Arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EVAMeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
    
    EVAMeModel *model = self.model_Arr[indexPath.item];
    
    cell.model = model;
    
    return cell;
}

#pragma mark -


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

- (void)settingClick:(UIButton *)button {
    EVASettingTableViewController *vc = [[EVASettingTableViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    // 修改tabBra的frame  - 没有上移问题
    //    CGRect frame = self.tabBarController.tabBar.frame;
    //    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    //    self.tabBarController.tabBar.frame = frame;
}

- (void)nightClick:(UIButton *)button {
    button.selected = !button.isSelected;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
