//
//  EVAEssenceViewController.m
//  BuDeJie
//
//  Created by 李元华 on 2018/5/31.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVAEssenceViewController.h"
#import "UIBarButtonItem+EVA.h"

@interface EVAEssenceViewController ()

@end

@implementation EVAEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 10.0, *)) {
        self.view.backgroundColor = eva_RandomColor;
    } else {
        // Fallback on earlier versions
    }
    [self setupNavigationItem];
}

- (BOOL)prefersHomeIndicatorAutoHidden {
    return YES;
}

- (void)gameClick:(UIButton *)button {
    NSLog(@"%s", __func__);
}

- (void)setupNavigationItem {
    /*
     系统不能设置高亮状态图片
     把UIButton包装成UIBarButtonItem.不会导致按钮点击区域扩大
     */
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"]
                                                          highlightedImage:[UIImage imageNamed:@"nav_item_game_click_icon"]
                                                                    target:self
                                                                    action:@selector(gameClick:)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"]
                                                           highlightedImage:[UIImage imageNamed:@"navigationButtonRandomClick"]
                                                                     target:nil
                                                                     action:nil];
    
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
