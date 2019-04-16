//
//  FLAnimatedImageView+EVA.h
//  BuDeJie
//
//  Created by 李元华 on 2019/3/7.
//  Copyright © 2019年 李元华. All rights reserved.
//

#import "FLAnimatedImageView.h"

#import <FLAnimatedImageView+WebCache.h>



@interface FLAnimatedImageView (EVA)

- (void)eva_setOriginImage:(NSString * _Nonnull)originImageURL
            thumbnailImage:(NSString * _Nonnull)thumbnailImageURL
               placeholder:(UIImage * _Nullable)placeholder
                 completed:(nullable SDExternalCompletionBlock)completedBlock;
@end
NS_ASSUME_NONNULL_BEGIN

//全是 非 null 参数
NS_ASSUME_NONNULL_END
