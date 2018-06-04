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

#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@interface EVAADViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *launchImage;
@property (weak, nonatomic) IBOutlet UIView *ADContainView;
@property (weak, nonatomic) IBOutlet UIButton *timeButton;

@property (nonatomic, weak) UIImageView *ADImage;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, strong) EVAADModel *model;

@end

@implementation EVAADViewController

- (UIImageView *)ADImage {
    if (_ADImage == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        //       不设图片尺寸也能显示图片,宽高设置其一,内容模式必须设置如下;
//        > UIViewContentModeScaleAspectFit - 需要明确的视图大小 X
//        > UIViewContentModeScaleAspectFill - 根据宽度(高度)自动填充 V - 多余部分 clipsToBounds
//        因为图片需要点击,视图高度还是要设置一下
        CGFloat imageH = eva_screenW / self.model.w * self.model.h;
        imageView.bounds = CGRectMake(0, 0, eva_screenW, imageH);
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
    NSURL *URL = [NSURL URLWithString:self.model.ori_curl];
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
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *parameters = @{
                                 @"code2" : code2
                                 };
    [manager GET:@"http://mobads.baidu.com/cpro/ui/mads.php"
      parameters:parameters
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             [EVAADInfoModel mj_setupObjectClassInArray:^NSDictionary *{
                 return @{@"ad" : [EVAADModel class]};
             }];
             EVAADInfoModel *infoModel = [EVAADInfoModel mj_objectWithKeyValues:responseObject];
             self.model = infoModel.ad[0];
             [self.ADImage sd_setImageWithURL:[NSURL URLWithString:self.model.w_picurl]];
//             [responseObject writeToFile:@"/Users/lyh/Desktop/from/ad2.plist" atomically:YES];
//             如果有值为 null,writeToFile 不行
             //             BOOL isFile = [NSKeyedArchiver archiveRootObject:responseObject toFile:@"/Users/lyh/Desktop/from/ad.plist"];
             //             NSLog(@"%d", isFile);
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             /*
              error.serialization.response content-type: text/html
              */
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
