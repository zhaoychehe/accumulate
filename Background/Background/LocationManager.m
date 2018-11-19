//
//  LocationManager.m
//  Background
//
//  Created by 赵燕超 on 2018/11/17.
//  Copyright © 2018 Background. All rights reserved.
//

#import "LocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationManager () <CLLocationManagerDelegate>

@property (nonatomic, assign) BOOL isCollect;

@property (nonatomic, strong) CLLocationManager *manager;

@end

@implementation LocationManager

+ (instancetype)sharedManager {
    static LocationManager *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[LocationManager alloc] init];
        shared.manager = [[CLLocationManager alloc] init];
        shared.manager.delegate = shared;
        shared.manager.distanceFilter = kCLDistanceFilterNone; // 不移动也可以后台刷新回调
        //控制定位精度,越高耗电量越
        shared.manager.desiredAccuracy = kCLLocationAccuracyBest;
        [shared.manager requestAlwaysAuthorization];
        //监听进入后台通知
        [[NSNotificationCenter defaultCenter] addObserver:shared selector:@selector(applicationEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    });
    return shared;
}

//后台监听方法
- (void)applicationEnterBackground
{
    NSLog(@"进入后台");
    [self.manager startUpdatingLocation];
    [[BackgroundTask shareTask] beginNewBackgroundTask];
}
//重启定位服务
- (void)restartLocation
{
    NSLog(@"重新启动定位");
    [self.manager startUpdatingLocation];
    [[BackgroundTask shareTask] beginNewBackgroundTask];
}

- (void)getLocationWithSuccess:(LocationSuccess)success Failure:(LocationFailed)failure {
    self.successCallBack = [success copy];
    self.failedCallBack = [failure copy];
    // 停止上一次的
    [self.manager stopUpdatingLocation];
    // 开始新的数据定位
    [self.manager startUpdatingLocation];
}

- (void)stopLocation {
    self.isCollect = NO;
    [self.manager stopUpdatingLocation];
}

// 每隔一段时间就会调用
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"定位收集");
    //如果正在10秒定时收集的时间，不需要执行延时开启和关闭定位
    if (self.isCollect) return;

    CLLocation *loc = [locations lastObject];
    CLLocationCoordinate2D l = loc.coordinate;
    double lat = l.latitude;
    double lnt = l.longitude;
    self.successCallBack ? self.successCallBack(lat, lnt) : nil;
    
    [self performSelector:@selector(restartLocation) withObject:nil afterDelay:120];
    [self performSelector:@selector(stopLocation) withObject:nil afterDelay:10];
    self.isCollect = YES;//标记正在定位
    
}

//失败代理方法
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    self.failedCallBack ? self.failedCallBack(error) : nil;
    switch([error code])
    {
        case kCLErrorNetwork:
            NSLog(@"网络错误");
            break;
        case kCLErrorDenied:
            NSLog(@"请开启后台服务");
            break;
        default:
            break;
    }
}

@end
