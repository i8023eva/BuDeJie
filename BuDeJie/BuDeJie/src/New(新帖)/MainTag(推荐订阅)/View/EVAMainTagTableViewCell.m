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
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = model.theme_name;
    self.numLabel.text = model.sub_number;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
