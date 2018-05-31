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

@interface EVARootTabBarController ()

@end

/**
 图片被渲染 v
 标题文字颜色和大小 v
 发布按钮
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    EVAEssenceViewController *EssenceVC = [[EVAEssenceViewController alloc] init];
    EVANewViewController *NewVC = [[EVANewViewController alloc] init];
    EVAPublishViewController *PublishVC = [[EVAPublishViewController alloc] init];
    EVAFriendTrendViewController *FriendTrendVC = [[EVAFriendTrendViewController alloc] init];
    EVAMeViewController *MeVC = [[EVAMeViewController alloc] init];
    
    NSArray<UIViewController *> *controller_Arr = @[EssenceVC, NewVC, PublishVC, FriendTrendVC, MeVC];
    NSArray<NSString *> *image_Arr = @[@"tabBar_essence_icon", @"tabBar_new_icon", @"tabBar_publish_icon", @"tabBar_friendTrends_icon", @"tabBar_me_icon"];
    NSArray<NSString *> *selectedImage_Arr = @[@"tabBar_essence_click_icon", @"tabBar_new_click_icon", @"tabBar_publish_click_icon", @"tabBar_friendTrends_click_icon", @"tabBar_me_click_icon"];
    NSArray<NSString *> *title_Arr = @[@"精华", @"新帖", @"", @"关注", @"我"];
    
    for (int i = 0; i < controller_Arr.count; i++) {
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller_Arr[i]];
        nav.tabBarItem.title = title_Arr[i];
        nav.tabBarItem.image = [UIImage imageNamed:image_Arr[i]];
        nav.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage_Arr[i]].renderOriginalName;
        [self addChildViewController:nav];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
