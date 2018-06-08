//
//  EVABaseSettingTableViewController.h
//  BuDeJie
//
//  Created by 李元华 on 2018/6/8.
//  Copyright © 2018年 李元华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EVASettingTableViewCell.h"

@interface EVABaseSettingTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray<EVASettingGroupModel *> *groupModel_Arr;


@end
