//
//  EVALoginRegisterViewController.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/5.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVALoginRegisterViewController.h"
#import "EVALoginRegisterView.h"

@interface EVALoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;


@end

@implementation EVALoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s", __func__);
    EVALoginRegisterView *loginView = [EVALoginRegisterView loginView];
    [self.middleView addSubview:loginView];
    
    EVALoginRegisterView *registerView = [EVALoginRegisterView registerView];
    [self.middleView addSubview:registerView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

/**
 布局子控件
 */
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"%s", __func__);
    
    /*
     屏幕适配 - view 通过 xib 加载,一定要设置尺寸, 本身并没有约束
     */
    EVALoginRegisterView *loginView = self.middleView.subviews.firstObject;
    NSLog(@"%@", NSStringFromCGRect(loginView.frame));
    loginView.frame = CGRectMake(0, 0, self.middleView.eva_width * 0.5, self.middleView.eva_height);
    
    EVALoginRegisterView *registerView = self.middleView.subviews.lastObject;
    registerView.frame = CGRectMake(self.middleView.eva_width * 0.5, 0, self.middleView.eva_width * 0.5, self.middleView.eva_height);
}

- (IBAction)closeClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)registerClick:(UIButton *)sender {
    sender.selected = !sender.isSelected;
//    设置了约束, 就要通过约束来移动
    /*
     - trailing 不要通过这个去改宽度
     
     */
    self.widthConstraint.constant = self.widthConstraint.constant == 0 ? -self.middleView.eva_width * 0.5 : 0;
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
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
