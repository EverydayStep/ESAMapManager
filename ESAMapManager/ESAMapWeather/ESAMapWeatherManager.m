//
//  ESAMapWeatherManager.m
//  ESAMapManager
//
//  Created by codeLocker on 2017/8/7.
//  Copyright © 2017年 codeLocker. All rights reserved.
//

#import "ESAMapWeatherManager.h"
@interface ESAMapWeatherManager()<AMapSearchDelegate>
@property (nonatomic, strong) AMapSearchAPI *searchAPI;
@end
@implementation ESAMapWeatherManager
+ (ESAMapWeatherManager *)manager {
    static ESAMapWeatherManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ESAMapWeatherManager alloc] init];
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
#pragma mark - Weather_Methods
- (void)weatherSearch:(NSString *)city type:(AMapWeatherType)type {
    AMapWeatherSearchRequest *request = [[AMapWeatherSearchRequest alloc] init];
    request.city = city;
    request.type = type;
    [self weatherSearchWithRequest:request];
}

- (void)weatherSearchWithRequest:(AMapWeatherSearchRequest *)request {
    [self.searchAPI AMapWeatherSearch:request];
}

#pragma mark - AMapSearchDelegate
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    if (self.delegate && [self.delegate respondsToSelector:@selector(mapWeatherManager:searchRequest:didFailWithError:)]) {
        [self.delegate mapWeatherManager:self searchRequest:request didFailWithError:error];
    }
}

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
    if (self.delegate && [self.delegate respondsToSelector:@selector(mapWeatherManager:searchDone:response:)]) {
        [self.delegate mapWeatherManager:self searchDone:request response:response];
    }
}

@end
