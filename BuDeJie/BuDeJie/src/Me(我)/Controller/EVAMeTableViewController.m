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

#import <SafariServices/SafariServices.h>


static NSInteger const cols = 4;
static CGFloat const margin = 1;
#define itemWH (eva_screenW - (cols - 1) * margin) / cols
@interface EVAMeTableViewController () <UICollectionViewDataSource, UICollectionViewDelegate, SFSafariViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *model_Arr;
@property (nonatomic, weak) UICollectionView *collectionView;

@end

/**
 静态 cell - storyboard
    > cell 之间的距离
 */
@implementation EVAMeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationItem];
    
    [self setupFooterView];
    
    [self loadDate];
    
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    
#warning scrollview pop回来会下移20
    self.tableView.contentInset = UIEdgeInsetsMake(eva_StatusBarHeight + 20, 0, eva_TabBarHeight, 0);
//    滚动条的内边距
//    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 49, 0);
//    self.extendedLayoutIncludesOpaqueBars = YES; //bar 是透明的, 不是自定义,还不用设
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

// 打印celly值
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //    {{0, 35}, {375, 44}}
//    NSLog(@"%@",NSStringFromCGRect(cell.frame));
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    {0, 0, 0, 0}
//    NSLog(@"%@",NSStringFromUIEdgeInsets(self.tableView.contentInset));
}

/**
 http://s.budejie.com/op/square2/budejie-android-7.0.0/360zhushou/0-100.json
 square_list: []
 */
- (void)loadDate {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"http://s.budejie.com/op/square2/budejie-android-7.0.0/360zhushou/0-100.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSArray *square_list = responseObject[@"square_list"];
            self.model_Arr = [EVAMeModel mj_objectArrayWithKeyValuesArray:square_list];
            
            [self resloveData];
            
            /*
             rows * itemWH -
             > rows = (count - 1) / cols + 1  固定公式
             */
            NSInteger count = self.model_Arr.count;
            NSInteger rows = (count - 1) / cols + 1;
            self.collectionView.eva_height = rows * itemWH;
            
            //        tableView的滚动范围 系统计算
            //        self.tableView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.collectionView.frame));//push
            self.tableView.tableFooterView = self.collectionView;
            [self.collectionView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

/**
 补全数据, 添加空模型
 */
- (void)resloveData {
    NSInteger count = self.model_Arr.count;
    NSInteger exter = count % cols;
    
    if (exter) {
        exter = cols - exter;
        for (int i = 0; i < exter; i++) {
            EVAMeModel *model = [[EVAMeModel alloc] init];
            [self.model_Arr addObject:model];
        }
    }
}

/**
 collectionView - 需要自适应高度 - 数据加载完计算
    > 不需要滚动
 */
- (void)setupFooterView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumLineSpacing = margin;
    layout.minimumInteritemSpacing = margin;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = self.tableView.backgroundColor;
    collectionView.scrollEnabled = NO;
    self.tableView.tableFooterView = collectionView;
    self.collectionView = collectionView;
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([EVAMeCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([self class])];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    EVAMeModel *model = self.model_Arr[indexPath.item];
    if (![model.url containsString:@"http"]) {
        return;
    }
    //处理带空格的 URL
    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:[model.url stringByReplacingOccurrencesOfString:@" " withString:@""]]];
    [self presentViewController:safariVC animated:YES completion:nil];
//    [self.navigationController pushViewController:safariVC animated:YES];
//    safariVC.navigationItem.leftBarButtonItem 不行
    safariVC.dismissButtonStyle = SFSafariViewControllerDismissButtonStyleClose;
    safariVC.preferredBarTintColor = [UIColor whiteColor];
    safariVC.preferredControlTintColor = [UIColor blackColor];
    safariVC.delegate = self;
}

#pragma mark - SFSafariViewControllerDelegate
- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
//    系统推荐 modal
    [self dismissViewControllerAnimated:YES completion:nil];
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
