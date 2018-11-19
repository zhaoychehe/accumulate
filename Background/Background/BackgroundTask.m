//
//  BackgroundTask.m
//  Background
//
//  Created by 赵燕超 on 2018/11/17.
//  Copyright © 2018 Background. All rights reserved.
//

#import "BackgroundTask.h"

@interface BackgroundTask ()

@property (nonatomic, strong) NSMutableArray *taskList; //后台任务数组
@property (nonatomic, assign) UIBackgroundTaskIdentifier masterTaskId; //当前后台任务id

@end

@implementation BackgroundTask

/// 初始化
+ (instancetype)shareTask
{
    static BackgroundTask *task;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        task = [[BackgroundTask alloc]init];
        task.taskList = [NSMutableArray array];
        task.masterTaskId = UIBackgroundTaskInvalid;
    });
    return task;
}

/// 开启新的后台任务
- (UIBackgroundTaskIdentifier)beginNewBackgroundTask
{
    
    UIApplication *application = [UIApplication sharedApplication];
    __block UIBackgroundTaskIdentifier bgTaskId = UIBackgroundTaskInvalid;
    if([application respondsToSelector:@selector(beginBackgroundTaskWithExpirationHandler:)]) {
        bgTaskId = [application beginBackgroundTaskWithExpirationHandler:^{
            NSLog(@"Task 过期 %tu", bgTaskId);
            [self.taskList removeObject:@(bgTaskId)];//过期任务从后台数组删除
            bgTaskId = UIBackgroundTaskInvalid;
            [application endBackgroundTask:bgTaskId];
        }];
    }
    if (self.masterTaskId == UIBackgroundTaskInvalid) {
        //如果上次记录的后台任务已经失效了，就记录最新的任务为主任务
        self.masterTaskId = bgTaskId;
        NSLog(@"开启后台任务 %tu", bgTaskId);
    } else {
        //如果上次开启的后台任务还未结束，就提前关闭了，使用最新的后台任务
        NSLog(@"保持后台任务 %tu", bgTaskId);
        [self.taskList addObject:@(bgTaskId)];
        [self endBackGroundTask:NO];//留下最新创建的后台任务
    }
    return bgTaskId;
}

/**
 关闭后台任务
 @param all : yes 关闭所有 ,no 只留下主后台任务
 */
- (void)endBackGroundTask:(BOOL)all
{
    UIApplication *application = [UIApplication sharedApplication];
    //如果为all 清空后台任务数组
    //不为all 留下数组最后一个后台任务,也就是最新开启的任务
    if ([application respondsToSelector:@selector(endBackGroundTask:)]) {
        for (int i = 0; i < (all ? self.taskList.count : self.taskList.count-1); i++) {
            UIBackgroundTaskIdentifier bgTaskId = [self.taskList.firstObject integerValue];
            NSLog(@"关闭后台任务 %tu", bgTaskId);
            [application endBackgroundTask:bgTaskId];
            [self.taskList removeObjectAtIndex:0];
        }
    }
    ///如果数组大于0 所有剩下最后一个后台任务正在跑
    if(self.taskList.count > 0) {
        NSLog(@"后台任务正在保持运行 %tu", [self.taskList.firstObject integerValue]);
    }
    if(all) {
        [application endBackgroundTask:self.masterTaskId];
        self.masterTaskId = UIBackgroundTaskInvalid;
    } else {
        NSLog(@"kept master background task id %tu", self.masterTaskId);
    }
}



@end
