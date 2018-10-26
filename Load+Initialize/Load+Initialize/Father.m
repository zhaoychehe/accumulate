//
//  Father.m
//  Load+Initialize
//
//  Created by mjpc on 2017/2/25.
//  Copyright © 2017年 mali. All rights reserved.
//

#import "Father.h"

@implementation Father

+ (void)load {
    NSLog(@"111Father:%s %@", __FUNCTION__, [self class]);
}

+ (void)initialize {
    NSLog(@"222Father:%s %@", __FUNCTION__, [self class]);
}

@end
