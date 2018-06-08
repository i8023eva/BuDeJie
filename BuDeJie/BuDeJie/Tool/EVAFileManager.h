//
//  EVAFileManager.h
//  BuDeJie
//
//  Created by 李元华 on 2018/6/8.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EVAFileManager : NSObject

+ (void)getCacheSizeCompletion:(void(^)(NSUInteger size))completion;

+ (void)clearDisk;
@end
