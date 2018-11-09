//
//  YCButton.h
//  Fix
//
//  Created by 赵燕超 on 2018/11/8.
//  Copyright © 2018 dbaglobal. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCButton : UIButton

- (void)testArr:(NSArray *)list;
- (void)testDict:(NSDictionary *)dict;
- (void)testSelect:(SEL)select;
- (void)addBlock:(void(^)(NSString *str))block;

@end

NS_ASSUME_NONNULL_END
