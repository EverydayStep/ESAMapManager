//
//  ESAMapPOIManager.h
//  ESAMapManager
//
//  Created by codeLocker on 2017/8/1.
//  Copyright © 2017年 codeLocker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapSearchKit/AMapSearchKit.h>
@class ESAMapPOIManager;
@protocol ESAMapPOIManagerDelegate <NSObject>
- (void)mapPOIManager:(ESAMapPOIManager *)manager searchRequest:(id)request didFailWithError:(NSError *)error;
- (void)mapPOIManager:(ESAMapPOIManager *)manager searchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response;
@end

@interface ESAMapPOIManager : NSObject

@property (nonatomic, weak) id<ESAMapPOIManagerDelegate> delegate;

+ (ESAMapPOIManager *)manager;

/**
 关键字POI检索

 @param keyword 查询关键字，多个关键字用“|”分割
 @param city 查询城市，可选值：cityname（中文或中文全拼）、citycode、adcode.(注：台湾地区一律设置为【台湾】，不具体到市。)
 @param types 类型，多个类型用“|”分割 可选值:文本分类、分类代码
 */
- (void)poiSearchKeyword:(NSString *)keyword city:(NSString *)city types:(NSString *)types;

/**
 关键字检索

 @param request 检索请求
 */
- (void)poiSearchKeywordWithRequest:(AMapPOIKeywordsSearchRequest *)request;

/**
 周边POI检索

 @param location 中心点
 @param keyword 查询关键字，多个关键字用“|”分割
 @param radius 搜索半径
 @param types 类型，多个类型用“|”分割 可选值:文本分类、分类代码
 */
- (void)poiSearchAround:(AMapGeoPoint *)location keyword:(NSString *)keyword radius:(NSInteger)radius types:(NSString *)types;

/**
 周边POI检索

 @param request 检索请求
 */
- (void)poiSearchAroundWithRequest:(AMapPOIAroundSearchRequest *)request;

/**
 多边形POI检索

 @param points 点坐标
 @param keyword 查询关键字，多个关键字用“|”分割
 @param types 类型，多个类型用“|”分割 可选值:文本分类、分类代码
 */
- (void)poiSearchPolygon:(NSArray<AMapGeoPoint *>*)points keyword:(NSString *)keyword types:(NSString *)types;

/**
 多边形POI检索

 @param request 检索请求
 */
- (void)poiSearchPolygonWithRequest:(AMapPOIPolygonSearchRequest *)request;

/**
 ID检索

 @param uid ID
 */
- (void)poiSearchUID:(NSString *)uid;

/**
 IDPOI检索
 
 @param request 检索请求
 */
- (void)poiSearchUIDWithRequest:(AMapPOIIDSearchRequest *)request;
@end
