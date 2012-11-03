//
//  SettingView.h
//  MD
//
//  Created by 王 佳 on 12-8-20.
//  Copyright (c) 2012年 Gingco.Net New Media GmbH. All rights reserved.
//
#pragma once
#import "iosUtil.h"
#import "SettingViewController.h"
#import "GameListViewController.h"

@interface MDGameViewController : UIViewController<UIPopoverControllerDelegate>
{
    GameListViewController* gameListVC;
    SettingViewController* settingVC;
    UIPopoverController * popoverVC;
}

@property(nonatomic, strong) GameListViewController* gameListVC;
@property(nonatomic, strong) SettingViewController* settingVC;
@property(nonatomic, strong) UIPopoverController * popoverVC;
+(MDGameViewController*)sharedInstance;

-(void)showGameList;
@end

