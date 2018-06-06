//
//  EVAMeCollectionViewCell.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/6.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVAMeCollectionViewCell.h"
#import "EVAMeModel.h"

#import <UIImageView+WebCache.h>

@interface EVAMeCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation EVAMeCollectionViewCell

- (void)setModel:(EVAMeModel *)model {
    _model = model;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    self.nameLabel.text = model.name;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
