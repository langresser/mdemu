//
//  CountryCodeHelper.h
//  GetDeviceInfo
//
//  Created by MOGO on 12-5-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MKReverseGeocoder.h>
#import <MapKit/MKPlacemark.h>
#import "AdMoGoConfigDataCenter.h"
#import "AdMoGoConfigData.h"
#import "AdMoGoLocationDelegate.h"

@interface AdMoGoCountryCodeHelper : NSObject<CLLocationManagerDelegate,MKReverseGeocoderDelegate>{

    NSString *countryCode;

    MKReverseGeocoder *geoCoder;
    
    CLLocation *curLocation;
    
    BOOL isstopLocation;
}

@property(nonatomic,assign)NSString * configKey;
@property(nonatomic,assign)id<AdMoGoLocationDelegate> delegate;
@property(nonatomic,assign)CLLocationManager *locationManager;
-(NSString *)currentLocaleCountryCode:(BOOL)locationOn;
- (void)stopLocation;
@end
