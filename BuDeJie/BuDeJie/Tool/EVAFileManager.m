//
//  EVAFileManager.m
//  BuDeJie
//
//  Created by 李元华 on 2018/6/8.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import "EVAFileManager.h"

@implementation EVAFileManager

+ (NSUInteger)getSize {
    __block NSUInteger size = 0;
    dispatch_queue_t ioQueue = dispatch_queue_create("com.hackemist.SDWebImageCache", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(ioQueue, ^{
        NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
        //    NSLog(@"%@", cachePath);
        NSFileManager *manager = [NSFileManager defaultManager];
        NSDirectoryEnumerator *fileEnumerator = [manager enumeratorAtPath:cachePath];
        for (NSString *fileName in fileEnumerator) {
            NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
            NSDictionary<NSString *, id> *attrs = [manager attributesOfItemAtPath:filePath error:nil];
            size += [attrs fileSize];
        }
    });
    return size;
}

/**
 有点卡顿 - 子线程
    > BUG IN CLIENT OF libsqlite3.dylib: database integrity compromised by API violation: vnode unlinked while in use:
    > 这种会有问题 - 直接不显示多少 M, 点击直接 clear
 */
+ (void)getCacheSizeCompletion:(void(^)(NSUInteger size))completion {

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //    @param YES 是否展开
        NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
        //    NSLog(@"%@", cachePath);
        NSFileManager *manager = [NSFileManager defaultManager];
        
        NSArray *subPaths = [manager subpathsAtPath:cachePath];
        
        __block NSInteger totalSize = 0;
        for (NSString *subPath in subPaths) {
            NSString *filePath = [cachePath stringByAppendingPathComponent:subPath];
            
            // 判断隐藏文件
            if ([filePath containsString:@".DS"]) continue;
            
            // 判断是否文件夹
            BOOL isDirectory;
            // 判断文件是否存在,并且判断是否是文件夹
            BOOL isExist = [manager fileExistsAtPath:filePath isDirectory:&isDirectory];
            if (!isExist || isDirectory) continue;
            
            NSDictionary *attr = [manager attributesOfItemAtPath:filePath error:nil];
            
            totalSize += [attr fileSize];
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(totalSize);
            }
        });
    });
    
    //    NSLog(@"%ld", totalSize);
//        NSLog(@"%ld", [SDImageCache sharedImageCache].getSize);
}

+ (void)clearDisk {
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSArray *subPaths = [manager contentsOfDirectoryAtPath:cachePath error:nil];
    
    for (NSString *subPath in subPaths) {
        NSString *filePath = [cachePath stringByAppendingPathComponent:subPath];
        
        [manager removeItemAtPath:filePath error:nil];
    }
}

@end
