//
//  EVARootNavigationController.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/2.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVARootNavigationController.h"
#import "UIBarButtonItem+EVA.h"

@interface EVARootNavigationController () <UIGestureRecognizerDelegate>

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
//    <_UINavigationInteractiveTransition: 0x7fbb53b329c0>
//    NSLog(@"delegate - %@", self.interactivePopGestureRecognizer.delegate);
    //    假死状态:程序还在运行,但是界面死了.  -  非根控制器才需要触发手势
//    self.interactivePopGestureRecognizer.delegate = self;  边缘滑动
    [self setupGesture];
}

#pragma mark - UIGestureRecognizerDelegate

/**
 <#Description#>

 @return 是否触发手势
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(nonnull UITouch *)touch {
    return self.childViewControllers.count > 1;
}

/**
 全屏滑动
 */
- (void)setupGesture {
    SEL action = sel_registerName("handleNavigationTransition:");
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate
                                                                          action:action];
    [self.view addGestureRecognizer:pan];
    pan.delegate = self;
//    禁用系统手势
    self.interactivePopGestureRecognizer.enabled = NO;
}
#pragma mark -

- (void)backClick {
    [self popViewControllerAnimated:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    非根控制器
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithImage:[UIImage imageNamed:@"navigationButtonReturn"]
                                                                            highlightedImage:[UIImage imageNamed:@"navigationButtonReturnClick"]
                                                                                      target:self
                                                                                      action:@selector(backClick)
                                                                                       title:@"返回"];
    }
    [super pushViewController:viewController animated:animated];
    /*
     <UIScreenEdgePanGestureRecognizer: 0x7fc7db540cd0; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7fc7db52fef0>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fc7db540710>)>>
     */
//    NSLog(@"Gesture - %@", self.interactivePopGestureRecognizer);
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
