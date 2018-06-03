//
//  EVAADViewController.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/3.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVAADViewController.h"

@interface EVAADViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *launchImage;


@end

@implementation EVAADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (eva_iPhoneX) {
        self.launchImage.image = [UIImage imageNamed:@"Default-Portrait-2436h@3x.png"];
    } else if (eva_iPhone6P) {
        self.launchImage.image = [UIImage imageNamed:@"Default-Portrait-736h@3x.png"];
    } else if (eva_iPhone6) {
        self.launchImage.image = [UIImage imageNamed:@"Default-667h@2x.png"];
    } else if (eva_iPhone5) {
        self.launchImage.image = [UIImage imageNamed:@"Default-568h@2x.png"];
    } else if (eva_iPhone4) {
        self.launchImage.image = [UIImage imageNamed:@"Default@2x.png"];
    }
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
