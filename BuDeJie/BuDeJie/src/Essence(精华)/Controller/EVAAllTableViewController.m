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
@property (nonatomic, assign, getter=isFooterRefreshing) BOOL footerRefreshing;
@end

@implementation EVAAllTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.valueCount = 10;
    self.tableView.estimatedRowHeight = 0;
    if (@available(iOS 11.0, *)) {
        //当有heightForHeader delegate时设置
        self.tableView.estimatedSectionHeaderHeight = 0;
        //当有heightForFooter delegate时设置
        self.tableView.estimatedSectionFooterHeight = 0;
    }
    self.tableView.backgroundColor = eva_RandomColor;
    
    [self setupNotification];
    
    [self setupFooterView];
}

/**
 上拉刷新 - 数据为0还显示 - numberOfRowsInSection
 */
- (void)setupFooterView {
    UIView *footerView = [[UIView alloc] init];
    footerView.frame = CGRectMake(0, 0, self.tableView.eva_width, 35);
    self.tableView.tableFooterView = footerView;
    UILabel *footerLabel = ({
        footerLabel = [[UILabel alloc] init];
        footerLabel.frame = footerView.bounds;
        footerLabel.backgroundColor = [UIColor lightGrayColor];
        footerLabel.text = @"上拉可以加载更多";
        footerLabel.textColor = [UIColor whiteColor];
        footerLabel.textAlignment = NSTextAlignmentCenter;
        [footerView addSubview:footerLabel];
        self.footerLabel = footerLabel;
        footerLabel;
    });
}

#pragma mark - scrollViewDelegate

/**
 加载中就会调用3次 - 就算 footerView 隐藏了 高度也算在self.tableView.contentSize.height里 - 内容为空时 H = 35
 > IOS11 TableView contentSize异常 - 预估值
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"%f", self.tableView.contentSize.height);
//    if (self.tableView.contentSize.height <= (eva_screenH - 123 - 83)) return;
    
//    如果正在刷新，直接返回
    if (self.isFooterRefreshing) return;
    
//    NSLog(@"%@", NSStringFromUIEdgeInsets (self.tableView.adjustedContentInset));
//    NSLog(@"%@", NSStringFromUIEdgeInsets (self.tableView.contentInset));
    
//    footerView已经完全出现
    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.adjustedContentInset.bottom - self.tableView.eva_height;
    NSLog(@"%f - %f", offsetY, self.tableView.contentOffset.y);
    
    if (self.tableView.contentOffset.y >= offsetY) {
        self.footerRefreshing = YES;
        self.footerLabel.text = @"正在加载更多数据...";
        self.footerLabel.backgroundColor = [UIColor blueColor];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 加载数据
            self.valueCount += 5;
            [self.tableView reloadData];
            
            // 结束刷新
            self.footerRefreshing = NO;
            self.footerLabel.text = @"上拉可以加载更多";
            self.footerLabel.backgroundColor = [UIColor redColor];
        });
    }
}

#pragma mark - setupNotification
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
