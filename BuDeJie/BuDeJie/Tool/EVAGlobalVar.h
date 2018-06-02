//
//  EVAGlobalVar.h
//  BuDeJie
//
//  Created by 李元华 on 2018/6/2.
//  Copyright © 2018年 李元华. All rights reserved.
//

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

