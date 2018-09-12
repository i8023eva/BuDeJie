//
//  EVAEssenceModel.h
//  BuDeJie
//
//  Created by 李元华 on 2018/6/10.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, EVAEssenceType) {
    /** 全部 */
//    EVAEssenceTypeAll = 1,
    /** 图片 */
    EVAEssenceTypePicture = 10,
    /** 段子 */
    EVAEssenceTypeWord = 29,
    /** 声音 */
    EVAEssenceTypeVoice = 31,
    /** 视频 */
    EVAEssenceTypeVideo = 41
};

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
/** 最热评论 - 接口失效 - 模拟数据 */
@property (nonatomic, strong) NSArray *top_cmt;

/** 帖子的类型 10为图片 29为段子 31为音频 41为视频 */
@property (nonatomic, assign) EVAEssenceType type;

/** 宽度(像素) */
@property (nonatomic, assign) NSInteger width;
/** 高度(像素) */
@property (nonatomic, assign) NSInteger height;

/** 小图 */
@property (nonatomic, copy) NSString *image0;
/** 中图 */
@property (nonatomic, copy) NSString *image2;
/** 大图 */
@property (nonatomic, copy) NSString *image1;

/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 音频\视频的播放次数 */
@property (nonatomic, assign) NSInteger playcount;

/** 根据当前模型计算出来的cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect typeFrame;
@end
