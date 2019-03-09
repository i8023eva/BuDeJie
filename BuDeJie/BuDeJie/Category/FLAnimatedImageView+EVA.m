//
//  FLAnimatedImageView+EVA.m
//  BuDeJie
//
//  Created by 李元华 on 2019/3/7.
//  Copyright © 2019年 李元华. All rights reserved.
//

#import "FLAnimatedImageView+EVA.h"


#import <AFNetworkReachabilityManager.h>
#import <SDWebImageGIFCoder.h>
#import <SDWebImageCodersManager.h>

@interface FLAnimatedImageView ()

@end


@implementation FLAnimatedImageView (EVA)


- (void)eva_setOriginImage:(NSString *)originImageURL
            thumbnailImage:(NSString *)thumbnailImageURL
               placeholder:(UIImage *)placeholder
                 completed:(nullable SDExternalCompletionBlock)completedBlock{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
#warning gif 只显示第一帧
    /*
     Note: there is a backwards compatible feature, so if you are still trying to load a GIF into a UIImageView, it will only show the 1st frame as a static image by default. However, you can enable the full GIF support by using the built-in GIF coder. See GIF coder
     
     */
    [[SDWebImageCodersManager sharedInstance] addCoder: [SDWebImageGIFCoder sharedCoder]];
    
    
    //    storeImage:  ----  SDWebImageCacheKeyFilterBlock cacheKeyFilter;
    /*
     SDWebImageManager.sharecdManager.cacheKeyFilter = ^(NSURL * _Nullable url) {
     url = [[NSURL alloc] initWithScheme:url.scheme host:url.host path:url.path];
     return [url absoluteString];
     };
     */
    
    
//    @property (nonatomic, assign) BOOL shouldAnimate; // Before checking this value, call `-updateShouldAnimate` whenever the animated image or visibility (window, superview, hidden, alpha) has changed.
//    @property (nonatomic, assign) BOOL needsDisplayWhenImageBecomesAvailable;

    
    //NSHomeDirectory(); 缓存中是 gif
    UIImage *originImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originImageURL];
    
    if (originImage) { //原图已下载
//                self.image = originImage;//使用 sd 不要直接设置 image
//                completedBlock(originImage, nil, 0, [NSURL URLWithString:originImageURL]);// 传回数据


        
//        if (self.isAnimating == NO) {
//
//
//            [self startAnimating];
//        }
        
        
        [self sd_setImageWithURL:[NSURL URLWithString:originImageURL] placeholderImage:placeholder completed:completedBlock];
        
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
                
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placeholder completed:completedBlock];
            } else { //都没有，显示占位图
                
                //                self.image = placeholder;
                [self sd_setImageWithURL:nil placeholderImage:placeholder completed:completedBlock];
            }
        }
    }
}
@end
