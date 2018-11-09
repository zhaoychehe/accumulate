//
//  Test.m
//  LYFix
//
//  Created by xly on 2018/7/31.
//  Copyright © 2018年 Xly. All rights reserved.
//

#import "Test.h"

@implementation Test


- (void)instanceMethodCrash:(NSString *)string {
    NSMutableArray *array = [NSMutableArray new];
    [array addObject:string];
    NSLog(@"xly--%@",array);
}

+ (void)calssMethodCrash:(NSString *)string {
    NSMutableArray *array = [NSMutableArray new];
    [array addObject:string];
    NSLog(@"xly--%@",array);
}

+ (void)runBeforeClassMethod {
    NSLog(@"xly--%@",NSStringFromSelector(_cmd));
}

- (void)runBeforeInstanceMethod {
    NSLog(@"xly--%@",NSStringFromSelector(_cmd));
}

+ (void)runAfterClassMethod {
    NSLog(@"xly--%@",NSStringFromSelector(_cmd));
}

- (void)runAfterInstanceMethod {
    NSLog(@"xly--%@",NSStringFromSelector(_cmd));
}


+ (void)runInsteadClassMethod {
    NSLog(@"xly--%@",NSStringFromSelector(_cmd));
}

- (void)runInsteadInstanceMethod {
    NSLog(@"xly--%@",NSStringFromSelector(_cmd));
}

- (NSString *)changePrames:(NSString *)params {
    NSLog(@"xly--%@",params);
    NSLog(@"xly--%@",NSStringFromSelector(_cmd));

    return params;
}

+ (NSString *)changeReturnValue:(NSString *)params {
    NSLog(@"xly--%@",params);
    NSLog(@"xly--%@",NSStringFromSelector(_cmd));

    return params;
}

- (NSString *)runInstanceMethod:(NSString *)str {
    NSLog(@"xly--%@",NSStringFromSelector(_cmd));
    return str;
}

+ (NSInteger)runClassMethod:(NSString *)str {
    NSLog(@"xly--%@",NSStringFromSelector(_cmd));
    return str.length;
}
+ (NSArray *)runWithParams:(NSArray *)array {
    NSLog(@"xly--%@",array);
    return array;
}
+ (void)log {
    NSLog(@"xly--%@",@"^^^^^^^^^^^^^^^^^^^^^^^");
}
@end
