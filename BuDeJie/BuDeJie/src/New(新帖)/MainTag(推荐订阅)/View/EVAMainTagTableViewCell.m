//
//  EVAMainTagTableViewCell.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/4.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVAMainTagTableViewCell.h"
#import "EVAMainTagModel.h"

#import <UIImageView+WebCache.h>

@interface EVAMainTagTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end

@implementation EVAMainTagTableViewCell

- (void)setModel:(EVAMainTagModel *)model {
    _model = model;
    
    self.nameLabel.text = model.theme_name;
    self.numLabel.text = [self resolveNumStringWithModel:model];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.image_list]
                     placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}


/**
 处理 >10000的数字

 @param model <#model description#>
 @return <#return value description#>
 */
- (NSString *)resolveNumStringWithModel:(EVAMainTagModel *)model {
    NSString *numString = [NSString stringWithFormat:@"%@人订阅", model.sub_number];
    NSInteger num = model.sub_number.integerValue;
    if (num > 10000) {
        CGFloat newNum = num / 10000.0;
        numString = [[NSString stringWithFormat:@"%.1f万人订阅", newNum]
                     stringByReplacingOccurrencesOfString:@".0" withString:@""];
        
    }
    return numString;
}

/**
 从xib加载就会调用一次
 */
- (void)awakeFromNib {
    [super awakeFromNib];
//    头像圆角 iOS9之前会降帧
//    self.iconView.layer.cornerRadius = 30.f;
//    self.iconView.layer.masksToBounds = YES;

    /*
     也可以通过 xib - runtime attributes - 设置属性[不推荐,别人找不到]
     */
}

- (void)circleWithImageContext {
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:_model.image_list]
                     placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]
                            completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                                // 1.开启图形上下文
                                // 比例因素:当前点与像素比例
                                UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
                                // 2.描述裁剪区域
                                UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
                                // 3.设置裁剪区域;
                                [path addClip];
                                // 4.画图片
                                [image drawAtPoint:CGPointZero];
                                // 5.取出图片
                                image = UIGraphicsGetImageFromCurrentImageContext();
                                // 6.关闭上下文
                                UIGraphicsEndImageContext();
                                
                                self.iconView.image = image;
                            }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
