//
//  EVAEssenceTableViewCell.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/11.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVAEssenceTableViewCell.h"
#import "UIImage+EVA.h"

#import <UIImageView+WebCache.h>

@interface EVAEssenceTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;

@property (weak, nonatomic) IBOutlet UIButton *loveButton;
@property (weak, nonatomic) IBOutlet UIButton *hateButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end

@implementation EVAEssenceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setFrame:(CGRect)frame {
    frame.size.height -= 10;
    [super setFrame:frame];
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
