//
//  EVAFriendTrendViewController.m
//  BuDeJie
//
//  Created by 李元华 on 2018/5/31.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVAFriendTrendViewController.h"
#import "EVALoginRegisterViewController.h"
#import "UIBarButtonItem+EVA.h"

@interface EVAFriendTrendViewController ()

@end

@implementation EVAFriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationItem];
}

- (IBAction)loginAndRegister:(UIButton *)sender {
    EVALoginRegisterViewController *vc = [[EVALoginRegisterViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)friendsRecommentClick:(UIButton *)button {
    NSLog(@"%s", __func__);
}

- (void)setupNavigationItem {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"]
                                                          highlightedImage:[UIImage imageNamed:@"friendsRecommentIcon-click"]
                                                                    target:self
                                                                    action:@selector(friendsRecommentClick:)];
    self.navigationItem.title = @"我的关注";
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
