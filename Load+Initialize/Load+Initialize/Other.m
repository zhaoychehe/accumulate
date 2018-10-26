//
//  Ohter.m
//  Load+Initialize
//
//  Created by mjpc on 2017/2/25.
//  Copyright © 2017年 mali. All rights reserved.
//

#import "Other.h"

@implementation Other

+ (void)load {
    NSLog(@"222Other:%s %@", __FUNCTION__, [self class]);
}

+ (void)initialize {
    // 分类会把本类覆盖
    NSLog(@"---Other:%s %@", __FUNCTION__, [self class]);
}

@end
