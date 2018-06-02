//
//  EVANewViewController.m
//  BuDeJie
//
//  Created by 李元华 on 2018/5/31.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVANewViewController.h"
#import "UIBarButtonItem+EVA.h"

@interface EVANewViewController ()

@end

@implementation EVANewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = eva_RandomColor;
    [self setupNavigationItem];
}

- (void)mainTagClick:(UIButton *)button {
    NSLog(@"%s", __func__);
}

- (void)setupNavigationItem {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"]
                                                          highlightedImage:[UIImage imageNamed:@"MainTagSubIconClick"]
                                                                    target:self
                                                                    action:@selector(mainTagClick:)];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
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
