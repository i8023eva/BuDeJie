//
//  EVAGlobalVar.h
//  BuDeJie
//
//  Created by 李元华 on 2018/6/2.
//  Copyright © 2018年 李元华. All rights reserved.
//
/*
 @#name 一个#是给 name 加双引号
 EVA##name 是拼接
 */


#import <Foundation/Foundation.h>

#define eva_RandomColor [UIColor colorWithDisplayP3Red:arc4random_uniform(256)/255.0 \
                                                 green:arc4random_uniform(256)/255.0 \
                                                  blue:arc4random_uniform(256)/255.0 alpha:1.0]

/*
 非iPhone X ：
 StatusBar 高20pt，NavigationBar 高44pt，底部TabBar高49pt
 iPhone X：
 StatusBar 高44pt，NavigationBar 高44pt，底部TabBar高83pt
 */
#define eva_TabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define eva_StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define eva_NavigationBarHeight 44

/***********屏幕适配*************/
#define eva_screenH [UIScreen mainScreen].bounds.size.height
#define eva_screenW [UIScreen mainScreen].bounds.size.width
#define eva_iPhone4 (eva_screenH == 480)
#define eva_iPhone5 (eva_screenH == 568)
#define eva_iPhone6 (eva_screenH == 667)
#define eva_iPhone6P (eva_screenH == 736)
#define eva_iPhoneX (eva_screenH == 812)
/***********屏幕适配*************/

/***********连续点击刷新数据通知*************/
UIKIT_EXTERN NSString * const EVATabBarButtonRepeatClickNotification;
UIKIT_EXTERN NSString * const EVAEssenceTitleButtonRepeatClickNotification;




