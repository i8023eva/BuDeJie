//
//  EVAEssenceViewController.m
//  BuDeJie
//
//  Created by 李元华 on 2018/5/31.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVAEssenceViewController.h"
#import "EVAAllTableViewController.h"
#import "EVAVideoTableViewController.h"
#import "EVAVoiceTableViewController.h"
#import "EVAPictureTableViewController.h"
#import "EVAWordTableViewController.h"

#import "UIBarButtonItem+EVA.h"
#import "EVAEssenceButton.h"

@interface EVAEssenceViewController ()

@property (nonatomic, weak) EVAEssenceButton *selectedButton;

@property (nonatomic, weak) UIView *underView;
@end

@implementation EVAEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationItem];
    
    [self setupChildVC];
    
    [self setupScrollView];
    
    [self setupTitleView];
    
}

- (void)setupChildVC {
    [self addChildViewController:[[EVAAllTableViewController alloc] init]];
    [self addChildViewController:[[EVAVideoTableViewController alloc] init]];
    [self addChildViewController:[[EVAVoiceTableViewController alloc] init]];
    [self addChildViewController:[[EVAPictureTableViewController alloc] init]];
    [self addChildViewController:[[EVAWordTableViewController alloc] init]];
}

- (void)setupScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
//    不设置内边距,使 tableview 顶格 - navigation 的穿透效果
    scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    
    NSUInteger count = self.childViewControllers.count;
    for (NSUInteger i = 0; i < count; i++) {
        UITableView *view = (UITableView *)self.childViewControllers[i].view;
        view.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);
        view.frame = CGRectMake(i * scrollView.eva_width, 0, scrollView.eva_width, scrollView.eva_height);
        [scrollView addSubview:view];
    }
    scrollView.contentSize = CGSizeMake(count * scrollView.eva_width, 0);
}

- (void)setupTitleView {
    UIView *titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(0, eva_StatusBarHeight + 44, eva_screenW, 35);
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:titleView];
    
    NSArray *title_Arr = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSUInteger count = title_Arr.count;
    CGFloat buttonW = titleView.eva_width / count;
    for (NSUInteger i = 0; i < count; i++) {
        EVAEssenceButton *button = [EVAEssenceButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * buttonW, 0, buttonW, titleView.eva_height);
        [button setTitle:title_Arr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
    }
    
    EVAEssenceButton * firstButton = titleView.subviews.firstObject;
    UIView *underView = [[UIView alloc] init];
    underView.eva_height = 2.f;
    underView.eva_y = titleView.eva_height - underView.eva_height;
    underView.backgroundColor = [firstButton titleColorForState:UIControlStateSelected];
    [titleView addSubview:underView];
    self.underView = underView;
    
//    [self titleButtonClick:button]; 不行
    firstButton.selected = YES;
    self.selectedButton = firstButton;
//    NSLog(@"%f", button.titleLabel.eva_width); 0.000000 - sizetofit
    [firstButton.titleLabel sizeToFit];
    underView.eva_width = firstButton.titleLabel.eva_width + 10;
    underView.eva_centerX = firstButton.eva_centerX;
}

- (void)titleButtonClick:(EVAEssenceButton *)button {
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    [UIView animateWithDuration:0.3 animations:^{
       self.underView.eva_width = button.titleLabel.eva_width + 10;
       self.underView.eva_centerX = button.eva_centerX;
    }];
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

- (void)gameClick:(UIButton *)button {
    NSLog(@"%s", __func__);
}

/**
 响应父控制器

 @return <#return value description#>
 */
- (BOOL)prefersHomeIndicatorAutoHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
