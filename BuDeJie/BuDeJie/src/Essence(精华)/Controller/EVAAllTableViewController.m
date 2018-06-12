//
//  EVAAllTableViewController.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/8.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVAAllTableViewController.h"
#import "EVAEssenceTableViewCell.h"

#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>


@interface EVAAllTableViewController ()

@property (nonatomic, assign) NSInteger valueCount;
@property (nonatomic, weak) UILabel *footerLabel;
@property (nonatomic, weak) UILabel *headerLabel;
@property (nonatomic, weak) UIView *topView;
@property (nonatomic, assign, getter=isFooterRefreshing) BOOL footerRefreshing;
@property (nonatomic, assign, getter=isHeaderRefreshing) BOOL headerRefreshing;
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, strong) NSMutableArray<EVAEssenceModel *> *essenceModel_Arr;
//第一次加载帖子时候不需要传入此关键字，当需要加载下一页时：需要传入加载上一页时返回值字段“maxtime”中的内容。
@property (nonatomic, copy) NSString *maxtime;

@end

@implementation EVAAllTableViewController

- (AFHTTPSessionManager *)manager {
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 200;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([EVAEssenceTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([EVAEssenceTableViewCell class])];
    
    [self setupInitContent];
//    在 subView 之前
    
    [self setupNotification];
    
    [self setupTopViewToRefresh];
    
    [self setupHeadViewToAD];
    
    [self setupFooterViewToRefresh];
//    一加载就要进行下拉刷新
    [self headerRefreshBegin];
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
        label.backgroundColor = eva_RandomColor;
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
/**
 加载中就会调用 - 初次 contentSize.height = 0
 > IOS11 TableView contentSize异常 - 预估值
 > 上拉和下拉同时存在时,不知道谁会先返回 - [1]开始刷新()判断另一种是否正在刷新 &[2]直接取消之前的任务
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //    NSLog(@"%f", self.tableView.contentSize.height);//
    if (self.tableView.contentSize.height == 0) return;//
    
    [self headerRefresh];
    
    [self footerRefresh];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //    headView 完全显示
    CGFloat offsetY = - (self.tableView.contentInset.top + self.headerLabel.eva_height);
    if (self.tableView.contentOffset.y <= offsetY) {
        [self headerRefreshBegin];
    }
}

#pragma mark -
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

- (void)headerRefreshBegin {
//  上拉加载,返回
//    if (self.isFooterRefreshing) return;
    if (self.isHeaderRefreshing) return;
    
    // 进入下拉刷新状态
    self.headerLabel.text = @"正在刷新...";
    self.headerLabel.backgroundColor = [UIColor blueColor];
    self.headerRefreshing = YES;
    
    // 增加内边距
    [UIView animateWithDuration:0.3 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top += self.topView.eva_height;
        self.tableView.contentInset = inset;
        
//        设置偏移量使 view 移动
        self.tableView.contentOffset = CGPointMake(0, -inset.top);
    }];
    [self loadNewData];
}

- (void)loadNewData {
//    return;
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];

    NSDictionary *parameters = @{
                                 @"a" : @"list",
                                 @"c" : @"data",
                                 @"type" : @"1"
                                 };
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
//            保存这个值
            self.maxtime = responseObject[@"info"][@"maxtime"];
            self.essenceModel_Arr = [EVAEssenceModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            //          每次固定最上面的20条  覆盖之前的数据,   服务器没有 mintime 参数, 请求之后返回最新的几条
            
            //        NSMutableArray *newTopics = [EVAEssenceModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            //        if (self.essenceModel_Arr) {   没有用户数据
            //            [self.topics insertObjects:newTopics atIndexes:[NSIndexSet indexSetWithIndex:0]];
            //        } else {
            //            self.essenceModel_Arr = newTopics;
            //        }
            
            [self.tableView reloadData];
            [self headerRefreshEnd];
        } else {
            [SVProgressHUD showErrorWithStatus:@"请求失败"];
            [self headerRefreshEnd];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code != NSURLErrorCancelled) {//并不是所有都是网络问题,cancel时也会进入 block, 需要判断
            [SVProgressHUD showErrorWithStatus:@"网络繁忙!"];
        }
        [self headerRefreshEnd];
    }];
}

- (void)headerRefreshEnd {
    // 结束刷新
    self.headerRefreshing = NO;
    // 减小内边距
    [UIView animateWithDuration:0.3 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top -= self.topView.eva_height;
        self.tableView.contentInset = inset;
    }];
}

#pragma mark -
- (void)footerRefresh {
//    同时保证只有一个任务
//    if (self.isHeaderRefreshing) return;
    //    如果正在刷新，直接返回
    if (self.isFooterRefreshing) return;
    
    //    footerView已经完全出现
    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.adjustedContentInset.bottom - self.tableView.eva_height;
    //    NSLog(@"%f - %f", offsetY, self.tableView.contentOffset.y);
//    数据不满屏下拉也刷新 - 下拉时偏移量会越来越小 - 反之,上划就是大于
    if (self.tableView.contentOffset.y >= offsetY && self.tableView.contentOffset.y > - (self.tableView.contentInset.top)) {
        [self footerRefreshBegin];
    }
}

- (void)footerRefreshBegin {
    self.footerRefreshing = YES;
    self.footerLabel.text = @"正在加载更多数据...";
    self.footerLabel.backgroundColor = [UIColor blueColor];

    [self loadMoreData];
}

/**
 请求旧数据 - 数组不要覆盖
 */
- (void)loadMoreData {
//    return;
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];

    NSDictionary *parameters = @{
                                 @"a" : @"list",
                                 @"c" : @"data",
                                 @"type" : @"1",
                                 @"maxtime" : self.maxtime
                                 };
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
//            保证下下次请求的数据
            self.maxtime = responseObject[@"info"][@"maxtime"];
            
             NSArray *moreData_Arr = [EVAEssenceModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            
            [self.essenceModel_Arr addObjectsFromArray:moreData_Arr];
            
            [self.tableView reloadData];
            [self footerRefreshEnd];
        } else {
            [SVProgressHUD showErrorWithStatus:@"请求失败"];
            [self footerRefreshEnd];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code != NSURLErrorCancelled) {//并不是所有都是网络问题,cancel时也会进入 block, 需要判断
            [SVProgressHUD showErrorWithStatus:@"网络繁忙!"];
        }
        [self footerRefreshEnd];
    }];
}

- (void)footerRefreshEnd {
    // 结束刷新
    self.footerRefreshing = NO;
    self.footerLabel.text = @"上拉加载";
    self.footerLabel.backgroundColor = [UIColor redColor];
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
//    不会下移, 也不会自动回到顶部 -
    [self headerRefreshBegin];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.tableView.tableFooterView.hidden = (self.essenceModel_Arr.count == 0);
    return self.essenceModel_Arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EVAEssenceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EVAEssenceTableViewCell class]) forIndexPath:indexPath];
    EVAEssenceModel *model = self.essenceModel_Arr[indexPath.row];
    cell.essenceModel = model;
    
    return cell;
}

/**
 300 * 20 -> contentSize.height -> 滚动条长度 - 预估的长度不准确,滚动条会卡顿
 可以降低tableView:heightForRowAtIndexPath:方法的调用频率, 延迟执行
 
 */
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 300;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.essenceModel_Arr[indexPath.row].cellHeight;
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
    self.tableView.backgroundColor = [UIColor grayColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
