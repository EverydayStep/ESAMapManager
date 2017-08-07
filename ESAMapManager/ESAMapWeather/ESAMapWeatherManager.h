//
//  ESAMapWeatherManager.h
//  ESAMapManager
//
//  Created by codeLocker on 2017/8/7.
//  Copyright © 2017年 codeLocker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapSearchKit/AMapSearchKit.h>
@class ESAMapWeatherManager;
@protocol ESAMapWeatherManagerDelegate <NSObject>
- (void)mapWeatherManager:(ESAMapWeatherManager *)manager searchRequest:(id)request didFailWithError:(NSError *)error;
- (void)mapWeatherManager:(ESAMapWeatherManager *)manager searchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response;
@end

@interface ESAMapWeatherManager : NSObject

@property (nonatomic, weak) id<ESAMapWeatherManagerDelegate> delegate;

+ (ESAMapWeatherManager *)manager;

/**
 天气查询

 @param city 城市
 @param type 类型
 */
- (void)weatherSearch:(NSString *)city type:(AMapWeatherType)type;

/**
 天气查询

 @param request 查询请求
 */
- (void)weatherSearchWithRequest:(AMapWeatherSearchRequest *)request;
@end
