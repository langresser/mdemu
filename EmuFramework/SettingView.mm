//
//  SettingView.m
//  MD
//
//  Created by 王 佳 on 12-8-20.
//  Copyright (c) 2012年 Gingco.Net New Media GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingView.h"
#import "EAGLView.h"
#import "iOS.hh"
#include "gfx/interface.h"
#import <QuartzCore/QuartzCore.h>
#include "EmuSystem.hh"
#import "UIDevice+Util.h"

MDGameViewController* g_delegate = nil;

@implementation MDGameViewController
@synthesize settingVC, popoverVC;

+(MDGameViewController*)sharedInstance
{
    if (g_delegate == nil) {
        g_delegate = [[MDGameViewController alloc]init];
    }   
    
    return g_delegate;
}

-(void)showSettingPopup
{
    if (isPad()) {
        if (popoverVC == nil) {
            settingVC = [[SettingViewController alloc]initWithNibName:nil bundle:nil];
            popoverVC = [[UIPopoverController alloc] initWithContentViewController:settingVC];       
            popoverVC.delegate = self;
        }

        UIDeviceOrientation ori = [[UIDevice currentDevice]orientation];
        CGRect rect;
        switch (ori) {
            case UIDeviceOrientationPortrait:
                rect = CGRectMake(750, 0, 10, 10);
                break;
            case UIDeviceOrientationPortraitUpsideDown:
                rect = CGRectMake(0, 0, 10, 10);
                break;
            case UIDeviceOrientationLandscapeLeft:
                rect = CGRectMake(750, 1014, 10, 10);
                break;
            case UIDeviceOrientationLandscapeRight:
                rect = CGRectMake(0, 0, 10, 10);
                break;
            default:
                rect = CGRectMake(750, 0, 10, 10);
                break;
        }
        [popoverVC presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    } else {
        if (settingVC == nil) {
            settingVC = [[SettingViewController alloc]initWithNibName:nil bundle:nil];
        }

        [self presentModalViewController:settingVC animated:YES];
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    EmuSystem::start();
    Base::displayNeedsUpdate();
}
@end


void showSetting()
{
    EmuSystem::pause();
    [[MDGameViewController sharedInstance] showSettingPopup];
}
