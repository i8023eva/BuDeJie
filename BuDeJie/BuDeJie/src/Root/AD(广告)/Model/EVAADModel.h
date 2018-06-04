//
//  EVAADModel.h
//  BuDeJie
//
//  Created by 李元华 on 2018/6/3.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EVAADModel : NSObject
/** 广告地址 */
@property (nonatomic, strong) NSString *w_picurl;
/** 点击广告跳转的界面 */
@property (nonatomic, strong) NSString *ori_curl;

@property (nonatomic, assign) CGFloat w;

@property (nonatomic, assign) CGFloat h;
@end
