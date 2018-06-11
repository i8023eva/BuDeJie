//
//  EVAEssenceModel.h
//  BuDeJie
//
//  Created by 李元华 on 2018/6/10.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EVAEssenceModel : NSObject
/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *passtime;

/** 顶数量 */
@property (nonatomic, assign) NSInteger love;
/** 踩数量 */
@property (nonatomic, assign) NSInteger hate;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;
@end
