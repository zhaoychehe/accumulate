//
//  YCButton.m
//  Fix
//
//  Created by 赵燕超 on 2018/11/8.
//  Copyright © 2018 dbaglobal. All rights reserved.
//

#import "YCButton.h"

@implementation YCButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)testArr:(NSArray *)list
{
    NSLog(@"%@", list);
}
- (void)testDict:(NSDictionary *)dict
{
    NSLog(@"%@", dict);
}
- (void)testSelect:(SEL)select
{
    [self addTarget:self action:select forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"SEL");
}
- (void)selectClick:(UIButton *)btn
{
    NSLog(@"selectClick");
    NSLog(@"%@", btn);
}
- (void)addBlock:(void(^)(NSString *str))block
{
    NSLog(@"addBlock");
    if (block) {
        block(@"123");
    }
}

@end
