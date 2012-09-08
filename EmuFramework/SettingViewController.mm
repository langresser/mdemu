//
//  SettingViewController.m
//  MD
//
//  Created by 王 佳 on 12-9-5.
//  Copyright (c) 2012年 Gingco.Net New Media GmbH. All rights reserved.
//

#import "SettingViewController.h"
#import "iOS.hh"
#include "gfx/interface.h"
#import <QuartzCore/QuartzCore.h>
#include "EmuSystem.hh"
#include "Option.hh"
#import "UIDevice+Util.h"
#import "SettingView.h"

static int g_currentMB = 0;

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView
{
    settingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    m_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, 320, 430) style:UITableViewStyleGrouped];
    m_tableView.delegate = self;
    m_tableView.dataSource = self;
    [settingView addSubview:m_tableView];
    DianJinOfferBanner *_banner = [[DianJinOfferBanner alloc] initWithOfferBanner:CGPointMake(0, 0) style:kDJBannerStyle320_50];
    DianJinTransitionParam *transitionParam = [[DianJinTransitionParam alloc] init];
    transitionParam.animationType = kDJTransitionCube;
    transitionParam.animationSubType = kDJTransitionFromTop;
    transitionParam.duration = 1.0;
    [_banner setupTransition:transitionParam];
    [_banner startWithTimeInterval:20 delegate:self];
    [settingView addSubview:_banner];
    
    UIButton* btnBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnBack.frame = CGRectMake(260, 50, 50, 30);
    [btnBack setTitle:@"返回" forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(onClickBack) forControlEvents:UIControlEventTouchUpInside];

    btnBack.alpha = 0.7;
    [settingView addSubview:btnBack];
    
    [self setView:settingView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.contentSizeForViewInPopover = CGSizeMake(320, 480);
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    g_currentMB = [[NSUserDefaults standardUserDefaults]integerForKey:@"MB"];
    [m_tableView reloadData];
}

-(void)onClickBack
{
    if (isPad()) {
        [[MDGameViewController sharedInstance].popoverVC dismissPopoverAnimated:YES];
    } else {
        [self dismissModalViewControllerAnimated:YES];
    }
    
    EmuSystem::start();
    
    extern void onViewChange(void * = 0, Gfx::GfxViewState * = 0);
    onViewChange();
    Base::displayNeedsUpdate();
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"附加剧本";
    } else if (section == 1) {
        return @"系统";
    } else if (section == 2) {
        return @"游戏攻略";
    }
    return @"";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return [NSString stringWithFormat:@"当您的M币达到100时，将自动解锁所有附加剧本。当前M币：%d", g_currentMB];
    }
    return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    } else if (section == 1) {
        return 6;
    } else if (section == 2) {
        return 5;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    
    if (indexPath.section == 0) {
        static NSString* cellIdent = @"MyCellSetting";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdent];
            cell.textLabel.font = [UIFont systemFontOfSize:17.0];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        NSString* currentRom = [[NSUserDefaults standardUserDefaults]stringForKey:@"currentRom"];
        
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"正篇";
                cell.detailTextLabel.text = @"简体中文版";
                
                if ([currentRom compare:@"langrisser2_cn.smd"] == NSOrderedSame) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                } else {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
                
                break;
            case 1:
                cell.textLabel.text = @"意志之路修改篇";
                cell.detailTextLabel.text = @"繁体完整汉化版";
                
                if ([currentRom compare:@"langrisser2-yy.bin"] == NSOrderedSame) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                } else {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
                break;
            case 2:
                cell.textLabel.text =  @"帝国篇";
                cell.detailTextLabel.text = @"可以选择帝国兵种";
                
                if ([currentRom compare:@"langrisser2_1.4.bin"] == NSOrderedSame) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                } else {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
                break;
            case 3:
                cell.textLabel.text =  @"梦幻模拟战1";
                cell.detailTextLabel.text = @"有爱的同学推荐玩ss汉化版";
                
                if ([currentRom compare:@"langrisser1.bin"] == NSOrderedSame) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                } else {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
                break;
            default:
                break;
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 2) {
            static NSString *CellIdentifier = @"PickCell";
            CPPickerViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                cell = [[CPPickerViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            cell.textLabel.text = @"存档位置";
            cell.textLabel.font = [UIFont systemFontOfSize:17];
            cell.dataSource = self;
            cell.delegate = self;
            cell.currentIndexPath = indexPath;
            cell.showGlass = YES;
            cell.peekInset = UIEdgeInsetsMake(0, 35, 0, 35);
            
            [cell reloadData];            
            [cell selectItemAtIndex:EmuSystem::saveStateSlot + 1 animated:NO];
            
            return cell;
        } else if (indexPath.row == 3) {
            static NSString *CellIdentifier = @"PickCell2";
            CPPickerViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) {
                cell = [[CPPickerViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            cell.textLabel.text = @"手柄样式";
            cell.textLabel.font = [UIFont systemFontOfSize:17];
            cell.dataSource = self;
            cell.delegate = self;
            cell.currentIndexPath = indexPath;
            cell.showGlass = YES;
            cell.peekInset = UIEdgeInsetsMake(0, 35, 0, 35);
            
            [cell reloadData];
            extern BasicByteOption option6BtnPad;
            [cell selectItemAtIndex:option6BtnPad ? 1 : 0 animated:NO];
            
            return cell;
        } else {
            static NSString* cellIdent = @"MyCellMy";
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdent];
                cell.textLabel.font = [UIFont systemFontOfSize:17.0];
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            
            FsSys::cPath saveStr;
            if (EmuSystem::saveStateSlot == -1) {
                snprintf(saveStr, 256, "%s/save/%s.0%c.gp", Base::documentsPath(), EmuSystem::gameName, 'A');
            } else {
                snprintf(saveStr, 256, "%s/save/%s.0%c.gp", Base::documentsPath(), EmuSystem::gameName, '0' + EmuSystem::saveStateSlot);
            }
            
            NSString* saveStatus;
            
            NSFileManager* fm = [NSFileManager defaultManager];
            
            if ([fm fileExistsAtPath:[NSString stringWithUTF8String:saveStr]]) {
                NSDictionary* attr = [fm attributesOfItemAtPath:[NSString stringWithUTF8String:saveStr] error:nil];
                NSDate* time = [attr objectForKey:NSFileModificationDate];

                if (EmuSystem::saveStateSlot == -1) {
                    saveStatus = [NSString stringWithFormat:@"自动存档: %@", [time description]];
                } else {
                    saveStatus = [NSString stringWithFormat:@"%d 存档位: %@", EmuSystem::saveStateSlot, [time description]];
                }
                
            } else {
                if (EmuSystem::saveStateSlot == -1) {
                    saveStatus = @"自动存档: 空白";
                } else {
                    saveStatus = [NSString stringWithFormat:@"%d 存档位: 空白", EmuSystem::saveStateSlot];
                }
            }
            
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"读档";
                    cell.detailTextLabel.text = saveStatus;
                    break;
                case 1:
                    cell.textLabel.text = @"存档";
                    cell.detailTextLabel.text = saveStatus;
                    break;
                case 4:
                    cell.textLabel.text = @"重置游戏";
                    cell.detailTextLabel.text = @"";
                    break;
                case 5:
                    cell.textLabel.text = @"高级设置";
                    cell.detailTextLabel.text = @"";
                    break;
                default:
                    break;
            }
        }
    } else if (indexPath.section == 2) {
        static NSString* cellIdent = @"MyCellGongl";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
            cell.textLabel.font = [UIFont systemFontOfSize:17.0];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"剧情攻略";
                break;
            case 1:
                cell.textLabel.text = @"转职表";
                break;
            case 2:
                cell.textLabel.text =  @"游戏秘籍";
                break;
            case 3:
                cell.textLabel.text = @"论坛";
                break;
            case 4:
                cell.textLabel.text = @"精品推荐";
                break;
            default:
                break;
        }
    }
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        EmuSystem::saveAutoState(1);
		EmuSystem::saveBackupMem();
		EmuSystem::resetAutoSaveStateTime();
        
        NSString* currentRom = [[NSUserDefaults standardUserDefaults]stringForKey:@"currentRom"];
        
        extern void startGameFromMenu();
        switch (indexPath.row) {
            case 0:
                if ([currentRom compare:@"langrisser2_cn.smd"] == NSOrderedSame) {
                    return;
                }
                
                // 默认打开
                if(EmuSystem::loadGame("langrisser2_cn.smd", false, false))
                {
                    [self onClickBack];
                    startGameFromMenu();
                }
                [[NSUserDefaults standardUserDefaults]setObject:@"langrisser2_cn.smd" forKey:@"currentRom"];
                break;
            case 1:
                if ([currentRom compare:@"langrisser2-yy.bin"] == NSOrderedSame) {
                    return;
                }
                
                if (![self isHackEnable]) {
                    return;
                }
                
                // 默认打开
                if(EmuSystem::loadGame("langrisser2-yy.bin", false, false))
                {
                    [self onClickBack];
                    startGameFromMenu();
                }
                [[NSUserDefaults standardUserDefaults]setObject:@"langrisser2-yy.bin" forKey:@"currentRom"];
                break;
            case 2:
            {
                if ([currentRom compare:@"langrisser2_1.4.bin"] == NSOrderedSame) {
                    return;
                }
                
                if (![self isHackEnable]) {
                    return;
                }
                
                // 默认打开
                if(EmuSystem::loadGame("langrisser2_1.4.bin", false, false))
                {
                    [self onClickBack];
                    startGameFromMenu();
                }
                [[NSUserDefaults standardUserDefaults]setObject:@"langrisser2_1.4.bin" forKey:@"currentRom"];
            }
                break;
            case 3:
                if ([currentRom compare:@"langrisser1.bin"] == NSOrderedSame) {
                    return;
                }
                
                if (![self isHackEnable]) {
                    return;
                }
                
                // 默认打开
                if(EmuSystem::loadGame("langrisser1.bin", false, false))
                {
                    [self onClickBack];
                    startGameFromMenu();
                }
                [[NSUserDefaults standardUserDefaults]setObject:@"langrisser1.bin" forKey:@"currentRom"];
                break;
            default:
                break;
        }
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                [self onClickBack];
                EmuSystem::loadState();
                break;
            case 1:
                [self onClickBack];
                EmuSystem::saveState();
                break;
            case 4:
            {
                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"" message:@"是否重置游戏?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.tag = 100;
                [alert show];
            }
                break;
            case 5:
                [self onClickBack];
                extern void restoreMenuFromGame();
                restoreMenuFromGame();
                break;
            default:
                break;
        }
    } else if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
                openWebsite("http://langrissers.com/md2/3.htm");
                //                cell.textLabel.text = @"剧情攻略";
                break;
            case 1:
                openWebsite("http://langrissers.com/md2/4.htm");
                //               cell.textLabel.text = @"转职表";
                break;
            case 2:
                openWebsite("http://langrissers.com/md2/9.htm");
                //             cell.textLabel.text =  @"游戏秘籍";
                break;
            case 3:
                openWebsite("http://bananastudio.cn/bbs/forum.php");
                //             cell.textLabel.text = @"论坛";
                break;
            case 4:
                [[DianJinOfferPlatform defaultPlatform]showOfferWall: self delegate:self];
                break;
            default:
                break;
        }
    }
}

- (void)appActivatedDidFinish:(NSDictionary *)resultDic
{
    NSLog(@"%@", resultDic);
    NSNumber *result = [resultDic objectForKey:@"result"];
    if ([result boolValue]) {
        NSNumber *awardAmount = [resultDic objectForKey:@"awardAmount"];
        NSString *identifier = [resultDic objectForKey:@"identifier"];
        NSLog(@"app identifier = %@", identifier);
        g_currentMB += [awardAmount floatValue];
        
        if (settingView != nil) {
            [m_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        }
        
        if (g_currentMB >= 100) {
            NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
            if (defaults) {
                [[NSUserDefaults standardUserDefaults] setObject:[[UIDevice currentDevice] uniqueDeviceIdentifier] forKey:kRemoveAdsFlag];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
        [[NSUserDefaults standardUserDefaults]setInteger:g_currentMB forKey:@"MB"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

-(BOOL)isHackEnable
{
    NSString* flag = [[NSUserDefaults standardUserDefaults] stringForKey:kRemoveAdsFlag];
    if (flag && [flag isEqualToString:[[UIDevice currentDevice] uniqueDeviceIdentifier]]) {
        return YES;
    }
    
    if (g_currentMB >= 100) {
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        if (defaults) {
            [m_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            [[NSUserDefaults standardUserDefaults] setObject:[[UIDevice currentDevice] uniqueDeviceIdentifier] forKey:kRemoveAdsFlag];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        return YES;
    }
    
    NSString* title = [NSString stringWithFormat:@"当您M币达到100时，将自动解锁所有附加剧本。您可以通过安装精品推荐应用的方式免费获取M币。"];
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:title delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:@"获取M币", nil];
    [alert show];
    return NO;
}

#pragma mark - CPPickerViewCell DataSource

- (NSInteger)numberOfItemsInPickerViewAtIndexPath:(NSIndexPath *)pickerPath {
    if (pickerPath.row == 2) {
        return 11;
    } else if (pickerPath.row == 3) {
        return 2;
    }
}

- (NSString *)pickerViewAtIndexPath:(NSIndexPath *)pickerPath titleForItem:(NSInteger)item {
    if (pickerPath.row == 2) {
        if (item == 0) {
            return @"自动";
        } else {
            return [NSString stringWithFormat:@"%d", item - 1];
        }
    } else if (pickerPath.row == 3) {
        if (item == 0) {
            return @"3按钮";
        } else {
            return @"6按钮";
        }
    }
    
    
    return nil;
}

#pragma mark - CPPickerViewCell Delegate

- (void)pickerViewAtIndexPath:(NSIndexPath *)pickerPath didSelectItem:(NSInteger)item {
    
    if (pickerPath.row == 2) {
        EmuSystem::saveStateSlot = (item - 1);
    } else if (pickerPath.row == 3) {
        extern void setupMDInput();
        extern BasicByteOption option6BtnPad;
        if (item == 0) {
            option6BtnPad = 0;
            setupMDInput();
        } else if (item == 1) {
            option6BtnPad = 1;
            setupMDInput();
        }
    }

    [m_tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (alertView.tag == 100) {
        if (buttonIndex == 1) {
            [self onClickBack];
            EmuSystem::resetGame();
        }
    } else {
        if (buttonIndex == 1) {
            [[DianJinOfferPlatform defaultPlatform]showOfferWall: self delegate:self];
        }
    }
    
}

@end
