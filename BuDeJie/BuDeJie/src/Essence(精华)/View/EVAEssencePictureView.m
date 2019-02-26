//
//  EVAEssencePictureView.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/14.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVAEssencePictureView.h"
#import "EVAEssenceModel.h"
#import "EVATapPictureViewController.h"

#import "UIImageView+EVA.h"

#import <FLAnimatedImageView+WebCache.h>

@interface EVAEssencePictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;
@property (weak, nonatomic) IBOutlet UIImageView *placeholderView;
@property (nonatomic, weak) FLAnimatedImageView *flaImageView;

@end

@implementation EVAEssencePictureView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPicture)]];
}

- (void)tapPicture {
    EVATapPictureViewController *vc = [[EVATapPictureViewController alloc] init];
    vc.model = self.model;
    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
}

- (void)setModel:(EVAEssenceModel *)model {
    _model = model;
#warning
    
/**
    //    GIF -- imageView 不能播放 gif
    if ([model.image1.lowercaseString hasSuffix:@"gif"]) {

        FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, model.typeFrame.size.width, model.typeFrame.size.height)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.image1]];
        [self addSubview:imageView];
        [self insertSubview:imageView belowSubview:self.gifView];
        self.flaImageView = imageView;

//        self.imageView.hidden = YES;
//        self.gifView.hidden = NO;
//        self.flaImageView.hidden = NO;
    } else {
//        self.imageView.hidden = NO;
//        self.gifView.hidden = YES;
//        self.flaImageView.hidden = YES;
**/
        
        self.placeholderView.hidden = NO;
        [self.imageView eva_setOriginImage:model.image1 thumbnailImage:model.image0 placeholder:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (!image) return;
            //控制占位图
            self.placeholderView.hidden = YES;
            
            //        图片比例
            if (model.isBigPicture) {
                CGFloat imageW = model.typeFrame.size.width;
                CGFloat imageH = imageW * model.height / model.width;
                
                UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
                [self.imageView.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
                self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
            }
        }];
    //}

//    长图
    if (model.isBigPicture) {
        self.seeBigPictureButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;//CGFloat scale = 1;  SD_
        self.imageView.clipsToBounds = YES;
//        图片比例  --这里图片可能没下载完毕
//        if (self.imageView.image) {
//            CGFloat imageW = model.typeFrame.size.width;
//            CGFloat imageH = imageW * model.height / model.width;
//
//            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
//            [self.imageView.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
//            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//            UIGraphicsEndImageContext();
//        }
    } else {
        self.seeBigPictureButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }
}

@end
