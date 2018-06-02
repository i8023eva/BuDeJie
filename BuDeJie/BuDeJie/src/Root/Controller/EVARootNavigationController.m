//
//  EVARootNavigationController.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/2.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVARootNavigationController.h"

@interface EVARootNavigationController ()

@end

@implementation EVARootNavigationController


/**
 父类会在子类之前收到这个消息
 如果子类没有实现这个方法，那么父类的实现将会被执行数次
 如果子类实现了initialize方法，那么初始化时各自执行各自的initialize方法，如果子类没有实现initialize方法，那么就会自动调用父类的initialize方法。
 */
+ (void)initialize {
    if (self == [EVARootNavigationController class]) {
        UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
        NSDictionary *textAttributeDict = @{
                                       NSFontAttributeName: [UIFont boldSystemFontOfSize:20]
                                       };
        [bar setTitleTextAttributes:textAttributeDict];
        [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
