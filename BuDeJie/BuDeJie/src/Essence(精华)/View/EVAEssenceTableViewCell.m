//
//  EVAEssenceTableViewCell.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/11.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVAEssenceTableViewCell.h"
#import "EVAEssenceVideoView.h"
#import "EVAEssenceVoiceView.h"
#import "EVAEssencePictureView.h"

#import "UIImage+EVA.h"

#import <UIImageView+WebCache.h>

@interface EVAEssenceTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;

@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtLabel;


@property (weak, nonatomic) IBOutlet UIButton *loveButton;
@property (weak, nonatomic) IBOutlet UIButton *hateButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (nonatomic, weak) EVAEssenceVideoView *videoView;
@property (nonatomic, weak) EVAEssenceVoiceView *voiceView;
@property (nonatomic, weak) EVAEssencePictureView *pictureView;

@end

@implementation EVAEssenceTableViewCell

- (EVAEssenceVideoView *)videoView {
    if (_videoView == nil) {
        _videoView  = [[NSBundle mainBundle] loadNibNamed:@"EVAEssenceVideoView" owner:nil options:nil].firstObject;
        [self.contentView addSubview:_videoView];
    }
    return _videoView;
}

- (EVAEssenceVoiceView *)voiceView {
    if (_voiceView == nil) {
        _voiceView  = [[NSBundle mainBundle] loadNibNamed:@"EVAEssenceVoiceView" owner:nil options:nil].firstObject;
        [self.contentView addSubview:_voiceView];
    }
    return _voiceView;
}

- (EVAEssencePictureView *)pictureView {
    if (_pictureView == nil) {
        _pictureView  = [[NSBundle mainBundle] loadNibNamed:@"EVAEssencePictureView" owner:nil options:nil].firstObject;
        [self.contentView addSubview:_pictureView];
    }
    return _pictureView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setFrame:(CGRect)frame {
    frame.size.height -= 10;
    [super setFrame:frame];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.essenceModel.type == EVAEssenceTypePicture) {
        self.pictureView.frame = self.essenceModel.typeFrame;
    } else if (self.essenceModel.type == EVAEssenceTypeVideo) {
        self.videoView.frame = self.essenceModel.typeFrame;
    } else if (self.essenceModel.type == EVAEssenceTypeVoice) {
        self.voiceView.frame = self.essenceModel.typeFrame;
    }
}

- (void)setEssenceModel:(EVAEssenceModel *)essenceModel {
    _essenceModel = essenceModel;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:essenceModel.profile_image]
                             placeholderImage:[UIImage imageNamed:@"defaultUserIcon"].circleImageWithContext
                                    completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                                        if (!image) return;
                                        self.profileImageView.image = image.circleImageWithContext;
    }];
    
    self.nameLabel.text = essenceModel.name;
    self.passtimeLabel.text = essenceModel.passtime;
    self.text_label.text = essenceModel.text;
    
//    中间视图
    if (essenceModel.type == EVAEssenceTypePicture) {
        self.pictureView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    } else if (essenceModel.type == EVAEssenceTypeVideo) {
        self.videoView.hidden = NO;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    } else if (essenceModel.type == EVAEssenceTypeVoice) {
        self.voiceView.hidden = NO;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    } else {
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }
    
    
//    最热评论 - 可能没有 - 有, 可能是文字或者语音
//    if (essenceModel.top_cmt.count) {
//        self.topCmtView.hidden = NO;
//        
//        NSDictionary *topcmtDict = essenceModel.top_cmt.firstObject;
//        NSString *content = topcmtDict[@"content"];
//        if (content.length == 0) {
//            content = @"[语音评论]";
//        }
//        NSString *username = topcmtDict[@"user"][@"username"];
//        self.topCmtLabel.text = [NSString stringWithFormat:@"%@ : %@", username, content];
//    } else {
//        self.topCmtView.hidden = YES;
//    }
    
    [self.loveButton setTitle:[self resolveNumStringWithNumber:essenceModel.love placeholder:@"顶"]
                     forState: UIControlStateNormal];
    [self.hateButton setTitle:[self resolveNumStringWithNumber:essenceModel.hate placeholder:@"踩"]
                     forState: UIControlStateNormal];
    [self.repostButton setTitle:[self resolveNumStringWithNumber:essenceModel.repost placeholder:@"分享"]
                     forState: UIControlStateNormal];
    [self.commentButton setTitle:[self resolveNumStringWithNumber:essenceModel.comment placeholder:@"评论"]
                     forState: UIControlStateNormal];
}

/**
 处理 >10000的数字
 @return 数字为0, 显示文字
 */
- (NSString *)resolveNumStringWithNumber:(NSInteger)number placeholder:(NSString *)placeholder{
    if (number >= 10000) {
        CGFloat newNum = number / 10000.0;
        return [[NSString stringWithFormat:@"%.1f万", newNum]
                     stringByReplacingOccurrencesOfString:@".0" withString:@""];
    } else if (number > 0) {
        return [NSString stringWithFormat:@"%ld", number];
    } else {
        return placeholder;
    }
}

@end
