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
    //  文字 Y
    _cellHeight += 55;
    //  文字 height
    CGSize textMaxSize = CGSizeMake(eva_screenW - 2 * 10, MAXFLOAT);
    _cellHeight += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + 10;
//    中间视图
    if (self.type != EVAEssenceTypeWord) {
        CGFloat typeX = 10;
        CGFloat typeY = _cellHeight;
        CGFloat typeW = textMaxSize.width;
        CGFloat typeH = typeW * self.height / self.width;
        
        if (typeH >= eva_screenH) {
            typeH = 200;
            self.bigPicture = YES;
        }
        self.typeFrame = CGRectMake(typeX, typeY, typeW, typeH);
        _cellHeight += typeH + 10;
    }
    //最热评论
//    if (self.top_cmt.count) {
//最热评论高度
        _cellHeight += 18;
        
        //  内容
//        NSDictionary *topcmtDict = self.top_cmt.firstObject;
//        NSString *content = topcmtDict[@"content"];
//        if (content.length == 0) {
//            content = @"[语音评论]";
//        }
//        NSString *username = topcmtDict[@"user"][@"username"];
//        NSString *topCmtText = [NSString stringWithFormat:@"%@ : %@", username, content];
    NSString *topText = @"最热评论最热评论最热评论最热评论最热评论最热评论最热评论最热评论最热评论最热评论";
        _cellHeight += [topText boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + 10;
//    }
    //   工具条 + 间距
    _cellHeight += 35 + 10;
    
    return _cellHeight;
}
@end
