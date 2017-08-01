//
//  ESAMapService.m
//  ESAMapManager
//
//  Created by codeLocker on 2017/8/1.
//  Copyright © 2017年 codeLocker. All rights reserved.
//

#import "ESAMapService.h"
#import <ESUtils/ESUtils.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@implementation ESAMapService
+ (void)registerServiceKey:(NSString *)key {
    if ([ESUtils isEmptyString:key]) {
        return;
    }
    [AMapServices sharedServices].apiKey =key;
}

@end
