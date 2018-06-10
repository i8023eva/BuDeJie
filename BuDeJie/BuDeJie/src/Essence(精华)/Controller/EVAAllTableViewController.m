//
//  EVAAllTableViewController.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/8.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVAAllTableViewController.h"

@interface EVAAllTableViewController ()

@property (nonatomic, assign) NSInteger valueCount;
@property (nonatomic, weak) UILabel *footerLabel;
@property (nonatomic, weak) UILabel *headerLabel;
@property (nonatomic, weak) UIView *topView;
@property (nonatomic, assign, getter=isFooterRefreshing) BOOL footerRefreshing;
@property (nonatomic, assign, getter=isHeaderRefreshing) BOOL headerRefreshing;
@end

@implementation EVAAllTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.valueCount = 10;
    self.tableView.backgroundColor = eva_RandomColor;
    
    [self setupInitContent];
//    在 subView 之前
    
    [self setupNotification];
    
    [self setupTopViewToRefresh];
    
    [self setupHeadViewToAD];
    
    [self setupFooterViewToRefresh];
}

- (void)setupTopViewToRefresh {
    UIView *topView = [[UIView alloc] init];
    topView.frame = CGRectMake(0, -50, self.tableView.eva_width, 50);
    [self.tableView addSubview:topView];
    self.topView = topView;
    
    UILabel *headerLabel = ({
        headerLabel = [[UILabel alloc] init];
        headerLabel.frame = topView.bounds;
        headerLabel.backgroundColor = [UIColor redColor];
        headerLabel.text = @"下拉刷新";
        headerLabel.textColor = [UIColor whiteColor];
        headerLabel.textAlignment = NSTextAlignmentCenter;
        [topView addSubview:headerLabel];
        self.headerLabel = headerLabel;
        headerLabel;
    });
}

- (void)setupHeadViewToAD {
    UILabel *label = ({
        label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, 0, 44);
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"广告";
        label.textAlignment = NSTextAlignmentCenter;
        self.tableView.tableHeaderView = label;
        label;
    });
}

/**
 上拉刷新 - 数据为0还显示 - numberOfRowsInSection
 */
- (void)setupFooterViewToRefresh {
    UIView *footerView = [[UIView alloc] init];
    footerView.frame = CGRectMake(0, 0, self.tableView.eva_width, 35);
    self.tableView.tableFooterView = footerView;
    
    UILabel *footerLabel = ({
        footerLabel = [[UILabel alloc] init];
        footerLabel.frame = footerView.bounds;
        footerLabel.backgroundColor = [UIColor lightGrayColor];
        footerLabel.text = @"上拉加载";
        footerLabel.textColor = [UIColor whiteColor];
        footerLabel.textAlignment = NSTextAlignmentCenter;
        [footerView addSubview:footerLabel];
        self.footerLabel = footerLabel;
        footerLabel;
    });
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    NSLog(@"%f", self.tableView.contentSize.height);
//    NSLog(@"%f",self.tableView.contentOffset.y);
//    NSLog(@"%@", NSStringFromUIEdgeInsets (self.tableView.adjustedContentInset));
//    NSLog(@"%@", NSStringFromUIEdgeInsets (self.tableView.contentInset));
//    NSLog(@"%@", NSStringFromUIEdgeInsets (self.tableView.safeAreaInsets));
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //    headView 完全显示
    CGFloat offsetY = - (self.tableView.contentInset.top + self.headerLabel.eva_height);
    if (self.tableView.contentOffset.y <= offsetY) {
        // 进入下拉刷新状态
        self.headerLabel.text = @"正在刷新...";
        self.headerLabel.backgroundColor = [UIColor blueColor];
        self.headerRefreshing = YES;
        
        // 增加内边距
        [UIView animateWithDuration:0.25 animations:^{
            UIEdgeInsets inset = self.tableView.contentInset;
            inset.top += self.topView.eva_height;
            self.tableView.contentInset = inset;
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 刷新数据
            self.valueCount = 20;
            [self.tableView reloadData];
            // 结束刷新
            self.headerRefreshing = NO;
            // 减小内边距
            [UIView animateWithDuration:0.25 animations:^{
                UIEdgeInsets inset = self.tableView.contentInset;
                inset.top -= self.topView.eva_height;
                self.tableView.contentInset = inset;
            }];
        });
    }
}

/**
 加载中就会调用 - 初次 contentSize.height = 0
 > IOS11 TableView contentSize异常 - 预估值
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //    NSLog(@"%f", self.tableView.contentSize.height);//
    if (self.tableView.contentSize.height == 0) return;//
    
    [self headerRefresh];
    
    [self footerRefresh];
}

- (void)headerRefresh {
    if (self.isHeaderRefreshing) return;
//    headView 完全显示
    CGFloat offsetY = - (self.tableView.contentInset.top + self.headerLabel.eva_height);
    if (self.tableView.contentOffset.y <= offsetY) {
        self.headerLabel.text = @"松开刷新";
        self.headerLabel.backgroundColor = [UIColor grayColor];
    } else {
        self.headerLabel.text = @"下拉刷新";
        self.headerLabel.backgroundColor = [UIColor redColor];
    }
}


- (void)footerRefresh {
    //    如果正在刷新，直接返回
    if (self.isFooterRefreshing) return;
    
    //    footerView已经完全出现
    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.adjustedContentInset.bottom - self.tableView.eva_height;
    //    NSLog(@"%f - %f", offsetY, self.tableView.contentOffset.y);
//    数据不满屏下拉也刷新 - 下拉时偏移量会越来越小 - 反之,上划就是大于
    if (self.tableView.contentOffset.y >= offsetY && self.tableView.contentOffset.y > - (self.tableView.contentInset.top)) {
        self.footerRefreshing = YES;
        self.footerLabel.text = @"正在加载更多数据...";
        self.footerLabel.backgroundColor = [UIColor blueColor];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 加载数据
            self.valueCount += 5;
            [self.tableView reloadData];//
            
            // 结束刷新
            self.footerRefreshing = NO;
            self.footerLabel.text = @"上拉加载";
            self.footerLabel.backgroundColor = [UIColor redColor];
        });
    }
}

#pragma mark - Notification
- (void)setupNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonRepeatClick) name:EVATabBarButtonRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(essenceTitleButtonRepeatClick) name:EVAEssenceTitleButtonRepeatClickNotification object:nil];
}

- (void)essenceTitleButtonRepeatClick {
    [self tabBarButtonRepeatClick];
}

- (void)tabBarButtonRepeatClick {
//    精华按钮才响应 -
    if (self.view.window == nil) {
        return;
    }
//    选中视频点精华也打印 - 控制在这个 tableview
    if (self.tableView.scrollsToTop == NO) {
        return;
    }
    NSLog(@"%s", __func__);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.tableView.tableFooterView.hidden = (self.valueCount == 0);
    return self.valueCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%zd", self.class, indexPath.row];
    return cell;
}

#pragma mark - iOS 11
- (void)setupInitContent {
    self.tableView.estimatedRowHeight = 0;
    if (@available(iOS 11.0, *)) {
        //当有heightForHeader delegate时设置
        self.tableView.estimatedSectionHeaderHeight = 0;
        //当有heightForFooter delegate时设置
        self.tableView.estimatedSectionFooterHeight = 0;
    }
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.tableView.contentInset = UIEdgeInsetsMake(eva_StatusBarHeight + eva_NavigationBarHeight + 35, 0, eva_TabBarHeight, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
