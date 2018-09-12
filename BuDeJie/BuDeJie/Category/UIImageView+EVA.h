//
//  UIImageView+EVA.h
//  BuDeJie
//
//  Created by 李元华 on 2018/9/11.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIImageView+WebCache.h>

@interface UIImageView (EVA)

- (void)eva_setHeaderView:(NSString *)url;


- (void)eva_setOriginImage:(NSString *)originImageURL thumbnailImage:(NSString *)thumbnailImageURL placeholder:(UIImage *)placeholder completed:(nullable SDExternalCompletionBlock)completedBlock;
@end
