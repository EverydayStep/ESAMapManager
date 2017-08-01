//
//  ESAMapLocationManager.h
//  ESAMapManager
//
//  Created by codeLocker on 2017/8/1.
//  Copyright © 2017年 codeLocker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapLocationKit/AMapLocationKit.h>
@class ESAMapLocationManager;
@protocol ESAMapLocationManagerDelegate <NSObject>
@optional
/**
 定位信息返回

 @param locationManager manager
 @param location 经纬度信息
 @param reGeocode 逆地址信息
 */
- (void)locationManager:(ESAMapLocationManager *)locationManager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode;
@end

@interface ESAMapLocationManager : NSObject
/** 定位精度 */
@property(nonatomic, assign) CLLocationAccuracy desiredAccuracy;
/** 定位超时时间 */
@property(nonatomic, assign) NSInteger locationTimeout;
/** 逆地理超时时间 */
@property(nonatomic, assign) NSInteger reGeocodeTimeout;
/** 连续定位是否返回逆地理信息，默认NO */
@property (nonatomic, assign) BOOL locatingWithReGeocode;
/** 设定定位的最小更新距离 单位米*/
@property(nonatomic, assign) CLLocationDistance distanceFilter;
/** 允许后台定位 */
@property (nonatomic, assign) BOOL allowBackgroundLocation;
/** 代理 */
@property (nonatomic, weak) id<ESAMapLocationManagerDelegate> delegate;

+ (ESAMapLocationManager *)manager;

/**
 定位服务是否可用
 
 @return BOOL
 */
+ (BOOL)locationServicesEnabled;

/**
 地理位置访问权限
 
 @return 地理位置访问权限
 */
+ (CLAuthorizationStatus)authorizationState;

/**
 单次定位

 @param isReGeocode 是否需要逆地理信息
 @param success 定位成功回调
 @param fail 定位失败回调
 */
- (void)singleLocationWithReGeocode:(BOOL)isReGeocode success:(void(^)(CLLocation *location, AMapLocationReGeocode *regeocode))success fail:(void(^)(NSError *error))fail;

/**
 开始持续定位
 */
- (void)startContinuousLocation;
/**
 关闭持续定位
 */
- (void)stopContinuousLocation;
@end
