//
//  AdMoGoConfigDataCenter.h
//  AdsMogo
//
//  Created by MOGO on 12-6-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdMoGoConfigData.h"
#import "AdMogoConfigDic.h"
@interface AdMoGoConfigDataCenter : NSObject


@property(readonly,retain,nonatomic) AdMogoConfigDic * config_dict;

+(id) singleton;

+ (AdMoGoConfigData *) getconfigDictByKey:(NSString *)key;

+ (void) deleteAllData;
@end
