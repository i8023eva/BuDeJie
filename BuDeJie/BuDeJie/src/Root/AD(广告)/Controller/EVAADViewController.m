//
//  EVAADViewController.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/3.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVAADViewController.h"
#import "EVARootTabBarController.h"
#import "UIImage+EVA.h"

#import <AFNetworking.h>
#import <MJExtension.h>
#import <UIImageView+WebCache.h>

#import "EVAADInfoModel.h"


@interface EVAADViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *launchImage;
@property (weak, nonatomic) IBOutlet UIView *ADContainView;
@property (weak, nonatomic) IBOutlet UIButton *timeButton;

@property (nonatomic, weak) UIImageView *ADImage;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, strong) EVAADInfoModel *model;

@end

@implementation EVAADViewController

- (UIImageView *)ADImage {
    if (_ADImage == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
//       接口没有图片尺寸
        imageView.bounds = CGRectMake(0, 0, eva_screenW, 200);
        imageView.center = self.view.center;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.ADContainView addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage)];
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
        _ADImage = imageView;
    }
    return _ADImage;
}

/**
 点击图片跳转网址safari   self.model.ads[0].backgroud_pic
 */
- (void)tapImage {
    NSURL *URL = [NSURL URLWithString:self.model.ads[0].backgroud_pic];
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:URL]) {
        [app openURL:URL options:@{UIApplicationOpenURLOptionUniversalLinksOnly : @NO} completionHandler:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.launchImage.image = [UIImage eva_launchImage];
    [self setupAD];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}

- (void)timeChange {
    static int i = 3;
    if (i == 0) {
        [self timeClick:nil];
    }
    i--;
    [self.timeButton setTitle:[NSString stringWithFormat:@"跳过 (%d)", i] forState:UIControlStateNormal];
}

- (IBAction)timeClick:(UIButton *)sender {
    EVARootTabBarController *vc = [[EVARootTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
    
    [self.timer invalidate];
}

- (void)setupAD {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"http://s.budejie.com/op/adplace2/budejie-android-7.0.0/360zhushou/0/0-100.json"
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             [EVAADInfoModel mj_setupObjectClassInArray:^NSDictionary *{
                 return @{@"ads" : [EVAADModel class]};
             }];
             self.model = [EVAADInfoModel mj_objectWithKeyValues:responseObject];
             [self.ADImage sd_setImageWithURL:[NSURL URLWithString:self.model.ads[0].backgroud_pic]];
             //             BOOL isFile = [NSKeyedArchiver archiveRootObject:responseObject toFile:@"/Users/lyh/Desktop/from/ad.plist"];
             //             NSLog(@"%d", isFile);
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//             NSLog(@"%@", error);
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
