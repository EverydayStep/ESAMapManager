//
//  ViewController.m
//  ESAMapManager
//
//  Created by codeLocker on 2017/8/1.
//  Copyright © 2017年 codeLocker. All rights reserved.
//

#import "ViewController.h"
#import "ESAMapLocationManager.h"

@interface ViewController ()<ESAMapLocationManagerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttn:(id)sender {
//    switch ([ESAMapLocationManager authorizationState]) {
//        case kCLAuthorizationStatusNotDetermined:
//            NSLog(@"1");
//            break;
//        case kCLAuthorizationStatusRestricted:
//            NSLog(@"2");
//            break;
//        case kCLAuthorizationStatusDenied:
//            NSLog(@"3");
//            break;
//        case kCLAuthorizationStatusAuthorizedAlways:
//            NSLog(@"4");
//            break;
//        case kCLAuthorizationStatusAuthorizedWhenInUse:
//            NSLog(@"5");
//            break;
//        default:
//            break;
//    }
    
    [ESAMapLocationManager manager].distanceFilter = 0;
    [ESAMapLocationManager manager].locatingWithReGeocode = YES;
    [ESAMapLocationManager manager].delegate = self;
    [[ESAMapLocationManager manager] startContinuousLocation];
    
//    [[ESAMapLocationManager manager] singleLocationWithReGeocode:YES success:^(CLLocation *location, AMapLocationReGeocode *regeocode) {
//        NSLog(@"%@",location);
//        NSLog(@"%@",regeocode.city);
//    } fail:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
}

#pragma mark - ESAMapLocationManagerDelegate
- (void)locationManager:(ESAMapLocationManager *)locationManager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode {
    NSLog(@"%@",location);
}
@end
