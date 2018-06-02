//
//  EVAEssenceViewController.m
//  BuDeJie
//
//  Created by 李元华 on 2018/5/31.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVAEssenceViewController.h"

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
    

}

- (void)setupNavigation {
    
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
