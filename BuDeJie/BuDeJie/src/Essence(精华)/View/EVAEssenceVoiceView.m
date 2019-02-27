//
//  EVAEssenceVoiceView.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/14.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVAEssenceVoiceView.h"
#import "EVAEssenceModel.h"
#import "EVATapPictureViewController.h"

#import "UIImageView+EVA.h"

@interface EVAEssenceVoiceView()
@property (weak, nonatomic) IBOutlet UIImageView *placeholderView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;

@end

@implementation EVAEssenceVoiceView

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
    
    self.placeholderView.hidden = NO;
    [self.imageView eva_setOriginImage:model.image1 thumbnailImage:model.image0 placeholder:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!image) return;
        //控制占位图
        self.placeholderView.hidden = YES;
    }];
    
    if (model.playcount >= 10000) {
        self.playcountLabel.text = [NSString stringWithFormat:@"%.1f万播放", model.playcount / 10000.0];
    } else {
        self.playcountLabel.text = [NSString stringWithFormat:@"%ld播放", (long)model.playcount];
    }
    
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", model.voicetime / 60, model.voicetime % 60];
}

@end
