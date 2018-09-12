//
//  EVAEssencePictureView.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/14.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVAEssencePictureView.h"
#import "EVAEssenceModel.h"

#import "UIImageView+EVA.h"

@interface EVAEssencePictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;
@property (weak, nonatomic) IBOutlet UIImageView *placeholderView;

@end

@implementation EVAEssencePictureView

- (void)setModel:(EVAEssenceModel *)model {
    _model = model;
    
    self.placeholderView.hidden = NO;
    [self.imageView eva_setOriginImage:model.image1 thumbnailImage:model.image0 placeholder:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!image) return;
        //控制占位图
        self.placeholderView.hidden = YES;
    }];
    
//    GIF -- imageView 不能播放 gif
    if ([model.image1.lowercaseString hasSuffix:@"gif"]) {
        self.gifView.hidden = NO;
    } else {
        self.gifView.hidden = YES;
    }
//    长图
    if (model.isBigPicture) {
        self.seeBigPictureButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;//CGFloat scale = 1;  SD_
        self.imageView.clipsToBounds = YES;
//        图片比例
        if (self.imageView.image) {
            CGFloat imageW = model.typeFrame.size.width;
            CGFloat imageH = imageW * model.height / model.width;
            
            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
            [self.imageView.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
    } else {
        self.seeBigPictureButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }
}

@end
