//
//  EVAVideoTableViewController.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/8.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVAVideoTableViewController.h"

@interface EVAVideoTableViewController ()

@end

@implementation EVAVideoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = eva_RandomColor;
    
    [self setupFooterView];
}

- (void)setupFooterView {
    UIView *footerView = [[UIView alloc] init];
    footerView.frame = CGRectMake(0, 0, self.tableView.eva_width, 35);
    
    UILabel *footerLabel = ({
        footerLabel = [[UILabel alloc] init];
        footerLabel.frame = footerView.bounds;
        footerLabel.backgroundColor = [UIColor lightGrayColor];
        footerLabel.text = @"上拉可以加载更多";
        footerLabel.textColor = [UIColor whiteColor];
        footerLabel.textAlignment = NSTextAlignmentCenter;
        [footerView addSubview:footerLabel];
        footerLabel;
    });
    self.tableView.tableFooterView = footerView;
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
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
