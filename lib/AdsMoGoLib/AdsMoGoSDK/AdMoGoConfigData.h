//
//  AdMoGoConfigDataStruct.h
//  mogosdk
//
//  Created by MOGO on 12-5-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
	AMBannerAnimationTypeNone           = 0,
	AMBannerAnimationTypeFlipFromLeft   = 1,
	AMBannerAnimationTypeFlipFromRight  = 2,
	AMBannerAnimationTypeCurlUp         = 3,
	AMBannerAnimationTypeCurlDown       = 4,
	AMBannerAnimationTypeSlideFromLeft  = 5,
	AMBannerAnimationTypeSlideFromRight = 6,
	AMBannerAnimationTypeFadeIn         = 7,
	AMBannerAnimationTypeRandom         = 8,
} AMBannerAnimationType;

@interface AdMoGoConfigData : NSObject
{
    
    NSMutableDictionary *_config_extra;
    
    
    
    NSMutableArray *_config_rations;
    
    
    NSString * _app_key;
    
    
    NSNumber * _ad_type;
    
    
    AMBannerAnimationType bannerAnimationType;
    
    
    NSString *_countryCode;
    
    
    NSString *_cityCode;
}
@property(retain,nonatomic) NSString * app_key;
@property(retain,nonatomic) NSNumber * ad_type;
@property(retain,nonatomic) NSMutableDictionary *config_extra;
@property(retain,nonatomic) NSMutableArray *config_rations;
@property (nonatomic,readonly) AMBannerAnimationType bannerAnimationType;
@property (nonatomic,readonly) NSUInteger isCloseAd;
@property (nonatomic,readonly)  NSUInteger cycle_time;
@property(retain,nonatomic) NSString *countryCode;
@property(retain,nonatomic) NSString *cityCode;
@property(retain,nonatomic) NSString *curLocation;


- (id) getMoGoConfigData;


- (NSString *) getTimestamp;


- (BOOL) refreshConfig;


- (BOOL) configDataIsExisted;


- (int) getMoGonfigNetworkType;

- (UIColor *) getBackgroundColor;

- (UIColor *) getTextColorColor;


- (BOOL) getClickOptimized;


- (NSString *) getPackage;

- (NSString *) getVersion;

- (BOOL) istestMode;

- (BOOL) islocationOn;

- (NSMutableString *)getAdPlatforms;

@end
