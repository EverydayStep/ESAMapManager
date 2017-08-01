//
//  ESAMapLocationManager.m
//  ESAMapManager
//
//  Created by codeLocker on 2017/8/1.
//  Copyright © 2017年 codeLocker. All rights reserved.
//

#import "ESAMapLocationManager.h"

@interface ESAMapLocationManager()<AMapLocationManagerDelegate>
@property (nonatomic, strong) AMapLocationManager *locationManager;
@end

@implementation ESAMapLocationManager
+ (ESAMapLocationManager *)manager {
    static ESAMapLocationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ESAMapLocationManager alloc] init];
    });
    return manager;
}

- (id)init {
    self = [super init];
    if (self) {
        self.locationManager = [[AMapLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    return self;
}

+ (BOOL)locationServicesEnabled {
    return [CLLocationManager locationServicesEnabled];
}

+ (CLAuthorizationStatus)authorizationState {
    return [CLLocationManager authorizationStatus];
}

#pragma mark - Location_Methods
- (void)singleLocationWithReGeocode:(BOOL)isReGeocode success:(void(^)(CLLocation *location, AMapLocationReGeocode *regeocode))success fail:(void(^)(NSError *error))fail {
    
    [self.locationManager requestLocationWithReGeocode:isReGeocode completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error) {
            if (fail) fail(error);
        }else {
            if (success) success(location,regeocode);
        }
    }];
}

- (void)startContinuousLocation {
    [self.locationManager startUpdatingLocation];
}

- (void)stopContinuousLocation {
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - AMapLocationManagerDelegate
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(locationManager:didUpdateLocation:reGeocode:)]) {
        [self.delegate locationManager:self didUpdateLocation:location reGeocode:reGeocode];
    }
}
#pragma mark - Setter && Getter
- (void)setDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy {
    _desiredAccuracy = desiredAccuracy;
    self.locationManager.desiredAccuracy = _desiredAccuracy;
}

- (void)setReGeocodeTimeout:(NSInteger)reGeocodeTimeout {
    _reGeocodeTimeout = reGeocodeTimeout;
    self.locationManager.reGeocodeTimeout = _reGeocodeTimeout;
}

- (void)setLocationTimeout:(NSInteger)locationTimeout {
    _locationTimeout = locationTimeout;
    self.locationManager.locationTimeout = _locationTimeout;
}

- (void)setDistanceFilter:(CLLocationDistance)distanceFilter {
    _distanceFilter = distanceFilter;
    self.locationManager.distanceFilter = _distanceFilter;
}

- (void)setLocatingWithReGeocode:(BOOL)locatingWithReGeocode {
    _locatingWithReGeocode = locatingWithReGeocode;
    self.locationManager.locatingWithReGeocode = _locatingWithReGeocode;
}

- (void)setAllowBackgroundLocation:(BOOL)allowBackgroundLocation {
    _allowBackgroundLocation = allowBackgroundLocation;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
        self.locationManager.allowsBackgroundLocationUpdates = _allowBackgroundLocation;
    }else {
        [self.locationManager setPausesLocationUpdatesAutomatically:!_allowBackgroundLocation];
    }
}
@end
