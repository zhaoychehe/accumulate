//
//  LocationManager.h
//  Background
//
//  Created by 赵燕超 on 2018/11/17.
//  Copyright © 2018 Background. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BackgroundTask.h"

typedef void(^LocationSuccess) (double lat, double lng);
typedef void(^LocationFailed) (NSError *error);

NS_ASSUME_NONNULL_BEGIN

@interface LocationManager : NSObject

@property (nonatomic, copy) LocationSuccess successCallBack;
@property (nonatomic, copy) LocationFailed failedCallBack;

+ (instancetype)sharedManager;

- (void)getLocationWithSuccess:(LocationSuccess)success Failure:(LocationFailed)failure;

- (void)stopLocation;

@end

NS_ASSUME_NONNULL_END
