//
//  YCFix.h
//  Fix
//
//  Created by 赵燕超 on 2018/11/8.
//  Copyright © 2018 dbaglobal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCFix : NSObject

+ (void)Fix;
+ (JSContext *)context;
+ (id)evalString:(NSString *)jsString;

+ (id)runWithClassname:(NSString *)className selector:(NSString *)selector arguments:(NSArray *)arguments;
+ (id)runWithInstance:(id)instance selector:(NSString *)selector arguments:(NSArray *)arguments;

@end

NS_ASSUME_NONNULL_END
