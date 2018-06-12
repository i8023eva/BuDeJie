//
//  EVAEssenceModel.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/10.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVAEssenceModel.h"

@implementation EVAEssenceModel

- (CGFloat)cellHeight {
//    不为0, 计算过
    if (_cellHeight) return _cellHeight;
    //  text Y
    _cellHeight += 55;
    //  text height
    CGSize textMaxSize = CGSizeMake(eva_screenW - 2 * 10, MAXFLOAT);
    _cellHeight += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + 10;
    //   工具条 + 间距
    _cellHeight += 35 + 10;
    
    return _cellHeight;
}
@end
