//
//  EVARootTabBarController.m
//  BuDeJie
//
//  Created by 李元华 on 2018/5/31.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVARootTabBarController.h"

#import "EVAEssenceViewController.h"
#import "EVANewViewController.h"
#import "EVAFriendTrendViewController.h"
#import "EVAMeViewController.h"
#import "EVAPublishViewController.h"

#import "UIImage+EVA.h"

#import "EVARootTabBar.h"

#import <objc/message.h>

@interface EVARootTabBarController ()

@end

/**
 图片被渲染 v
 标题文字颜色和大小 v
 发布按钮被渲染，位置不对
    > tabbarButton 没有高亮状态图片 - 用 UIButton
    > EVAPublishViewController 不需要作子控制器
    > 占位控制器不行，UISwitch无法点击
    > 自定义 tabbar
        > 在系统之前添加自定义 tabbar
 */
@implementation EVARootTabBarController

+ (void)initialize {
    if (self == [EVARootTabBarController class]) {
        UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
        NSDictionary<NSAttributedStringKey,id> *textNormalAttrDict = @{
                                       NSFontAttributeName: [UIFont systemFontOfSize:12]
                                       };
        NSDictionary<NSAttributedStringKey,id> *textSelectedAttrDict = @{
                                                                         NSForegroundColorAttributeName : [UIColor blackColor]
                                                                       };
        // 设置字体尺寸:只有设置正常状态下,才会有效果
        [item setTitleTextAttributes:textNormalAttrDict forState:UIControlStateNormal];
        [item setTitleTextAttributes:textSelectedAttrDict forState:UIControlStateSelected];
    }
}

/**
 若无交互事件响应时，延迟2秒左右会回调此方法
 返回的子控制器实现prefersHomeIndicatorAutoHidden YES
 
 @return 如果非nil，将使用视图控制器的主指示器自动隐藏。
 */
- (UIViewController *)childViewControllerForHomeIndicatorAutoHidden {
    return self.childViewControllers[0];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.view.bounds.size.height - eva_TabBarHeight, self.tabBar.frame.size.width, eva_TabBarHeight);
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addChildViewControllers];
    
//    NSLog(@"%@", self.tabBar.subviews); 空
    
//    UISwitch *swic = [UISwitch new];
//    swic.center = CGPointMake(self.tabBar.bounds.size.width * 0.5, self.tabBar.bounds.size.height * 0.5);
//    [self.tabBar addSubview:swic];

    EVARootTabBar *tabBar = [[EVARootTabBar alloc] init];
    [self setValue:tabBar forKeyPath:@"_tabBar"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    NSLog(@"%@", self.tabBar.subviews); 有值
//    NSLog(@"%@", self.tabBar); 替换成功
}

#pragma mark - 添加子控制器
- (void)addChildViewControllers {
    EVAEssenceViewController *EssenceVC = [[EVAEssenceViewController alloc] init];
    EVANewViewController *NewVC = [[EVANewViewController alloc] init];
    //    UIViewController *PublishVC = [[UIViewController alloc] init];
    EVAFriendTrendViewController *FriendTrendVC = [[EVAFriendTrendViewController alloc] init];
    EVAMeViewController *MeVC = [[EVAMeViewController alloc] init];
    
    NSArray<UIViewController *> *controller_Arr = @[EssenceVC, NewVC, FriendTrendVC, MeVC];
    NSArray<NSString *> *image_Arr = @[@"tabBar_essence_icon",
                                       @"tabBar_new_icon",//@"",
                                       //@"tabBar_publish_icon",
                                       @"tabBar_friendTrends_icon",
                                       @"tabBar_me_icon"];
    NSArray<NSString *> *selectedImage_Arr = @[@"tabBar_essence_click_icon",
                                               @"tabBar_new_click_icon",//@"",
                                               //@"tabBar_publish_click_icon",
                                               @"tabBar_friendTrends_click_icon",
                                               @"tabBar_me_click_icon"];
    NSArray<NSString *> *title_Arr = @[@"精华", @"新帖", @"关注", @"我"];
    
    for (int i = 0; i < controller_Arr.count; i++) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller_Arr[i]];
        nav.tabBarItem.title = title_Arr[i];
        //        if (i == 2) {
        //            nav.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        //        }
        nav.tabBarItem.image = [UIImage imageNamed:image_Arr[i]].eva_renderOriginalName;
        nav.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage_Arr[i]].eva_renderOriginalName;
        [self addChildViewController:nav];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
