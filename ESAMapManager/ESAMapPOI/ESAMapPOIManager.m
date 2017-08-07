//
//  ESAMapPOIManager.m
//  ESAMapManager
//
//  Created by codeLocker on 2017/8/1.
//  Copyright © 2017年 codeLocker. All rights reserved.
//

#import "ESAMapPOIManager.h"

@interface ESAMapPOIManager()<AMapSearchDelegate>
@property (nonatomic, strong) AMapSearchAPI *searchAPI;
@end

@implementation ESAMapPOIManager
+ (ESAMapPOIManager *)manager {
    static ESAMapPOIManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ESAMapPOIManager alloc] init];
    });
    return manager;
}

- (id)init {
    self = [super init];
    if (self) {
        self.searchAPI = [[AMapSearchAPI alloc] init];
        self.searchAPI.delegate = self;
    }
    return self;
}

#pragma mark - Search_Methods
- (void)poiSearchKeyword:(NSString *)keyword city:(NSString *)city types:(NSString *)types {
    
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    request.keywords = keyword;
    request.city = city;
    request.types = types;
    [self poiSearchKeywordWithRequest:request];
}

- (void)poiSearchKeywordWithRequest:(AMapPOIKeywordsSearchRequest *)request {
    [self.searchAPI AMapPOIKeywordsSearch:request];
}

- (void)poiSearchAround:(AMapGeoPoint *)location keyword:(NSString *)keyword radius:(NSInteger)radius types:(NSString *)types {
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.keywords = keyword;
    request.location = location;
    request.radius = radius;
    request.types = types;
    [self poiSearchAroundWithRequest:request];
}
- (void)poiSearchAroundWithRequest:(AMapPOIAroundSearchRequest *)request {
    [self.searchAPI AMapPOIAroundSearch:request];
}

- (void)poiSearchPolygon:(NSArray<AMapGeoPoint *>*)points keyword:(NSString *)keyword types:(NSString *)types {
    AMapGeoPolygon *polygon = [AMapGeoPolygon polygonWithPoints:points];
    AMapPOIPolygonSearchRequest *request = [[AMapPOIPolygonSearchRequest alloc] init];
    request.polygon = polygon;
    request.keywords = keyword;
    request.types = types;
    [self poiSearchPolygonWithRequest:request];
}
- (void)poiSearchPolygonWithRequest:(AMapPOIPolygonSearchRequest *)request {
    [self.searchAPI AMapPOIPolygonSearch:request];
}

- (void)poiSearchUID:(NSString *)uid {
    AMapPOIIDSearchRequest *request = [[AMapPOIIDSearchRequest alloc] init];
    request.uid = uid;
    [self poiSearchUIDWithRequest:request];
}

- (void)poiSearchUIDWithRequest:(AMapPOIIDSearchRequest *)request {
    [self.searchAPI AMapPOIIDSearch:request];
}

#pragma mark - AMapSearchDelegate
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    NSLog(@"%@",error);
}

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
    NSLog(@"%@",response);
}

@end
