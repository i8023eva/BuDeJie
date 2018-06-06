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
#import "UITextField+EVA.h"

@interface EVAFriendTrendViewController ()
@property (weak, nonatomic) IBOutlet UITextField *bugTextField;

@end

@implementation EVAFriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationItem];
    /*
     _placeholderLabel : <nil>
        > 没设置占位文字nil - 颜色没变 - 要做到设置顺序无所谓 - 在 placeholder时设置颜色 - 保存颜色 - runtime 交换方法
     */
    self.bugTextField.placeholderColor = [UIColor greenColor];
    
    self.bugTextField.placeholder = @"碧油鸡 测试";
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
