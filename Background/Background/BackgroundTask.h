//
//  BackgroundTask.h
//  Background
//
//  Created by 赵燕超 on 2018/11/17.
//  Copyright © 2018 Background. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BackgroundTask : NSObject

+ (instancetype)shareTask;

// 开启后台任务
- (UIBackgroundTaskIdentifier)beginNewBackgroundTask;


@end

NS_ASSUME_NONNULL_END
