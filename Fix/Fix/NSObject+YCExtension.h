//
//  NSObject+YCExtension.h
//  项目管理
//
//  Created by Daniel on 2017/8/24.
//  Copyright © 2017年 BIKE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YCExtension)

/**
 使用字典数组创建当前类对象的数组
 
 @param array 字典数组
 @return 当前类对象的数组
 */
+ (NSArray *)dd_objectsWithArray:(NSArray *)array;

/**
 返回当前类的属性数组
 
 @return 属性数组
 */
+ (NSArray<NSString *> *)dd_propertiesList;

/**
 返回当前类的成员变量数组
 
 @return 成员变量数组
 */
+ (NSArray<NSString *> *)dd_ivarsList;

/**
 当前类的所有方法
 
 @return 方法数组
 */
+ (NSArray<NSString *> *)dd_methodList;


//
// NSString *sel = @"selectTest:sstr:";
// BOOL is = [self.class validateMehodCanRunWithTarget:self selectorStr:sel];
// NSString *str = [self runSelector:NSSelectorFromString(sel) withObjects:@[@"abc", @"azs"]];
// - (NSString *)selectTest:(NSString *)str sstr:(NSString *)sstr{}
/**
 判断是否可以执行某方法

 @param target 目标
 @param selectorStr 方法名
 @return BOOL
 */
+ (BOOL)dd_validateMehodCanRunWithTarget:(id)target selectorStr:(NSString *)selectorStr;
/**
 执行某方法

 @param aSelector 方法
 @param objects 参数
 @return 返回结果
 */
- (id)dd_runSelector:(SEL)aSelector withObjects:(NSArray *)objects;

/**
 交换两个对象方法的实现

 @param method1 方法1
 @param method2 方法2
 */
+ (void)dd_exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2;
/**
 交换两个类方法的实现
 
 @param method1 方法1
 @param method2 方法2
 */
+ (void)dd_exchangeClassMethod1:(SEL)method1 method2:(SEL)method2;




/// 执行类方法
+ (id)dd_performClassSelector:(SEL)selector withObjects:(NSArray *)objects;
/// 执行实例方法
- (id)dd_performInstanceSelector:(SEL)selector withObjects:(NSArray *)objects;

@end
