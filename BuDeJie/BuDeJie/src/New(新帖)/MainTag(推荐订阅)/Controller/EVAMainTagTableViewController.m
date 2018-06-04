//
//  EVAMainTagTableViewController.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/4.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVAMainTagTableViewController.h"
#import "EVAMainTagModel.h"
#import "EVAMainTagTableViewCell.h"

#import <AFNetworking.h>
#import <MJExtension.h>

@interface EVAMainTagTableViewController ()

@property (nonatomic, strong) NSArray<EVAMainTagModel *> *model_Arr;
@end

@implementation EVAMainTagTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([EVAMainTagTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([self class])];
    
    self.title = @"推荐标签";
}

- (void)loadData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *parameters = @{
                                 @"a" : @"tag_recommend",
                                 @"action" : @"sub",
                                 @"c" : @"topic"
                                 };
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        
        [responseObject writeToFile:@"/Users/lyh/Desktop/from/tag.plist" atomically:YES];
        
        self.model_Arr = [EVAMainTagModel mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model_Arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EVAMainTagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
    
    EVAMainTagModel *model = self.model_Arr[indexPath.row];
    
    cell.model = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.f;
}

/**
 非常消耗性能

 @param tableView <#tableView description#>
 @param cell <#cell description#>
 @param indexPath <#indexPath description#>
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    static CGFloat distance = 375;
    distance -= arc4random_uniform(375);
    cell.transform = CGAffineTransformMakeTranslation(distance, 0);
    if (distance < 0) {
        distance = 375;
    }
    [UIView animateWithDuration:0.5f animations:^{
        cell.transform = CGAffineTransformIdentity;
    }];
}



@end
