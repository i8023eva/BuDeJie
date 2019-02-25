//
//  EVATapPictureViewController.m
//  BuDeJie
//
//  Created by 李元华 on 2019/2/25.
//  Copyright © 2019年 李元华. All rights reserved.
//

#import "EVATapPictureViewController.h"
#import "EVAEssenceModel.h"

#import <UIImageView+WebCache.h>

@interface EVATapPictureViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation EVATapPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
//    scrollView.frame = self.view.bounds;  //还是xib中的样式
//    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    scrollView.frame = [UIScreen mainScreen].bounds;
    scrollView.backgroundColor = [UIColor greenColor];
    [scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back:)]];
    [self.view insertSubview:scrollView atIndex:0];
    self.scrollView = scrollView;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.image1] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!image) return;
        self.saveBtn.enabled = YES;
    }];
    imageView.eva_width = eva_screenW;
    imageView.eva_height = imageView.eva_width / self.model.width * self.model.height;
    imageView.eva_x = 0;
    if (imageView.eva_height > eva_screenH) {
        imageView.eva_y = 0;
        scrollView.contentSize = CGSizeMake(0, imageView.eva_height);
    } else {
        imageView.eva_centerY = eva_screenH * 0.5;
    }
    [scrollView addSubview:imageView];
    self.imageView = imageView;
    
    //缩放
    CGFloat maxScale = self.model.width / imageView.eva_width;
    if (maxScale > 1) {
        scrollView.maximumZoomScale = maxScale;
        scrollView.delegate = self;
    }
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
}

@end
