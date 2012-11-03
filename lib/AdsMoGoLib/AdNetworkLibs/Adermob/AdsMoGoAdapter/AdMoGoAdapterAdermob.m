//
//  AdMoGoAdapterAdermob.m
//  AdsMogo   
//  Version: 1.1.9
//  Created by pengxu on 12-4-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.

#import "AdMoGoAdapterAdermob.h"
#import "AdMoGoAdNetworkRegistry.h"
//#import "AdMoGoView.h"
#import "AdMoGoAdNetworkConfig.h"
#import "AdMoGoConfigData.h"
#import "AdMoGoConfigDataCenter.h"

@implementation AdMoGoAdapterAdermob

+ (AdMoGoAdNetworkType)networkType {
	return AdMoGoAdNetworkTypeAdermob;
}

+ (void)load {
	[[AdMoGoAdNetworkRegistry sharedRegistry] registerClass:self];
}

- (void)getAd {
    
    isStop = NO;
    
    [adMoGoCore adDidStartRequestAd];
    CGRect adFrame = CGRectMake(0, 0, 320, 50);
    AdMoGoConfigDataCenter *configDataCenter = [AdMoGoConfigDataCenter singleton];
    
    AdMoGoConfigData *configData = [configDataCenter.config_dict objectForKey:adMoGoCore.config_key];
    AdViewType type = [configData.ad_type intValue];
    switch (type) {
        case AdViewTypeNormalBanner:
            adFrame = CGRectMake(0, 0, 320, 50);
            break;
        case AdViewTypeLargeBanner:
            adFrame = CGRectMake(0, 0, 728, 90);
            break;
        default:
            [adMoGoCore adapter:self didGetAd:@"adermob"];
            [adMoGoCore adapter:self didFailAd:nil];
            return;
            break;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, adFrame.size.width, adFrame.size.height)];
    [AderSDK stopAdService];
//    [AderSDK startAdService:view appID:networkConfig.pubId adFrame:adFrame model:MODEL_RELEASE]; [self.ration objectForKey:@"key"]
    
    [AderSDK startAdService:view appID:[self.ration objectForKey:@"key"] adFrame:adFrame model:MODEL_RELEASE];
    
    [AderSDK setDelegate:self];
    self.adNetworkView = view;
}

- (void)stopBeingDelegate{
    [AderSDK setDelegate:nil];
}

- (void)stopAd{
    [self stopBeingDelegate];
    isStop = YES;
}

- (void)dealloc {
	[super dealloc];
}

- (void)didSucceedToReceiveAd:(NSInteger)count {
    
    if (isStop) {
        return;
    }
    
    [adMoGoCore adapter:self didGetAd:@"adermob"];
    [adMoGoCore adapter:self didReceiveAdView:adNetworkView];
}

- (void) didReceiveError:(NSError *)error {
    
    if (isStop) {
        return;
    }
    
    [adMoGoCore adapter:self didGetAd:@"adermob"];
    [adMoGoCore adapter:self didFailAd:nil];
}


@end
