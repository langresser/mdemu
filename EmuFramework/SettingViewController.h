//
//  SettingViewController.h
//  MD
//
//  Created by 王 佳 on 12-9-5.
//  Copyright (c) 2012年 Gingco.Net New Media GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "iosUtil.h"
#import <DianJinOfferPlatform/DianJinOfferPlatform.h>
#import <DianJinOfferPlatform/DianJinBannerSubViewProperty.h>
#import <DianJinOfferPlatform/DianJinTransitionParam.h>
#import <DianJinOfferPlatform/DianJinOfferPlatformProtocol.h>
#import "AdMoGoDelegateProtocol.h"
#import "AdMoGoView.h"
#import "AdMoGoWebBrowserControllerUserDelegate.h"
#import "CPPickerViewCell.h"

@interface SettingViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, DianJinOfferPlatformProtocol, CPPickerViewCellDelegate, CPPickerViewCellDataSource, AdMoGoDelegate,AdMoGoWebBrowserControllerUserDelegate>
{
    UIView* settingView;
    UITableView* m_tableView;
    
    AdMoGoView *adView;
}

@end
