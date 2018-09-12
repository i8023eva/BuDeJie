//
//  UIImageView+EVA.m
//  BuDeJie
//
//  Created by 李元华 on 2018/9/11.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "UIImageView+EVA.h"
#import "UIImage+EVA.h"

#import <AFNetworkReachabilityManager.h>

@implementation UIImageView (EVA)

- (void)eva_setHeaderView:(NSString *)url {
    UIImage *placeholderImage = [UIImage imageNamed:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:url]
                     placeholderImage:placeholderImage.eva_circleImageWithContext
                            completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                                if (!image) return;
                                self.image = [image eva_circleImageWithContext];
                            }];
}

- (void)eva_setOriginImage:(NSString *)originImageURL
            thumbnailImage:(NSString *)thumbnailImageURL
               placeholder:(UIImage *)placeholder
                 completed:(nullable SDExternalCompletionBlock)completedBlock{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //    storeImage:  ----  SDWebImageCacheKeyFilterBlock cacheKeyFilter;
    /*
     SDWebImageManager.sharedManager.cacheKeyFilter = ^(NSURL * _Nullable url) {
        url = [[NSURL alloc] initWithScheme:url.scheme host:url.host path:url.path];
        return [url absoluteString];
     };
     */
    UIImage *originImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originImageURL];
    
    if (originImage) { //原图已下载
        self.image = originImage;
        completedBlock(originImage, nil, 0, [NSURL URLWithString:originImageURL]);// 传回数据
    } else {
        if (manager.isReachableViaWiFi) {
            [self sd_setImageWithURL:[NSURL URLWithString:originImageURL] placeholderImage:placeholder completed:completedBlock];
        } else if(manager.isReachableViaWWAN) {
            [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placeholder completed:completedBlock];
        } else {
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailImageURL];
            if (thumbnailImage) { //缩略图已下载
                self.image = thumbnailImage;
                completedBlock(thumbnailImage, nil, 0, [NSURL URLWithString:thumbnailImageURL]);
            } else { //都没有，显示占位图
                self.image = placeholder;
            }
        }
    }
}
@end
