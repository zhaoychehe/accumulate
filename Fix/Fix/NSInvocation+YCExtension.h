//
//  NSInvocation+YCExtension.h
//  Fix
//
//  Created by 赵燕超 on 2018/11/8.
//  Copyright © 2018 dbaglobal. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSInvocation (YCExtension)

@property (nonatomic, strong) id dd_returnValue_obj;
@property (nonatomic, copy) NSArray *dd_arguments;

- (void)dd_setMyArgument:(id)obj atIndex:(NSInteger)argumentIndex;
- (id)dd_myArgumentAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
