//
//  NSObject+YCExtension.m
//  项目管理
//
//  Created by Daniel on 2017/8/24.
//  Copyright © 2017年 BIKE. All rights reserved.
//

#import "NSObject+YCExtension.h"
#import <objc/runtime.h>

@implementation NSObject (YCExtension)

+ (NSArray *)dd_objectsWithArray:(NSArray *)array {
    
    if (array.count == 0) {
        return nil;
    }
    // 断言是字典数组
    NSAssert([array[0] isKindOfClass:[NSDictionary class]], @"必须传入字典数组");
    // 0. 获得属性数组
    NSArray *list = [self dd_propertiesList];
    // 1. 遍历数组
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        // 2. 创建对象
        id obj = [self new];
        // 3. 遍历字典
        for (NSString *key in dict) {
            // 判断字典中的 key 是否在成员变量中存在
            if (![list containsObject:key]) {
                continue;
            }
            [obj setValue:dict[key] forKey:key];
        }
        // 4. 将对象添加到数组
        [arrayM addObject:obj];
    }
    return arrayM.copy;
}

+ (NSArray<NSString *> *)dd_propertiesList
{
    NSMutableArray *tmp = [NSMutableArray array];
    u_int count;
    objc_property_t * properties = class_copyPropertyList(self.class, &count);
    NSLog(@"Class's name: %@, Property's count: %d\n\n", self.class, count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSString * propertyName  = [NSString stringWithUTF8String:property_getName(property)];
        NSString * propertyType  = [NSString stringWithUTF8String:property_getAttributes(property)];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        NSLog(@"[%d]propertyName : %@", i, propertyName);
        NSLog(@"[%d]propertyValue: %@", i, propertyValue);
        NSLog(@"[%d]propertyType : %@\n\n", i, propertyType);
        [tmp addObject:propertyName];
    }
    free(properties);
    return tmp;
}

+ (NSArray<NSString *> *)dd_ivarsList
{
    NSMutableArray *tmp = [NSMutableArray array];
    u_int count;
    Ivar * ivars = class_copyIvarList(self.class, &count);
    NSLog(@"Class's name: %@, Ivar's count: %d\n\n", NSStringFromClass(self.class), count);
    
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        NSString * ivar_name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSString * ivar_type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        NSLog(@"[%d]ivar_name : %@", i, ivar_name);
        NSLog(@"[%d]ivar_type : %@\n\n", i, ivar_type);
        [tmp addObject:ivar_name];
    }
    free(ivars);
    return tmp;
}

+ (NSArray<NSString *> *)dd_methodList
{
    NSMutableArray *tmp = [NSMutableArray array];
    u_int count;
    Method * methods = class_copyMethodList(self.class,&count);
    NSLog(@"Class's name: %@, method's count: %d\n\n", NSStringFromClass(self.class), count);
    
    for(int i = 0;i < count; i++) {
        Method method = methods[i];
        NSString *methodName = [NSString stringWithUTF8String:sel_getName(method_getName(method))];
        NSString *methodType = [NSString stringWithUTF8String:method_getTypeEncoding(method)];
        NSString *methodArgs = @(method_getNumberOfArguments(method)).stringValue;
        NSLog(@"[%d]methodName : %@", i, methodName);
        NSLog(@"[%d]methodArgs : %@", i, methodArgs);
        NSLog(@"[%d]methodType : %@\n\n", i, methodType);
        [tmp addObject:methodName];
    }
    free(methods);
    return tmp;
}


+ (BOOL)dd_validateMehodCanRunWithTarget:(id)target selectorStr:(NSString *)selectorStr
{
    unsigned int methodCount =0;
    Method* methodList = class_copyMethodList([target class],&methodCount);
    NSMutableArray *methodsArray = [NSMutableArray arrayWithCapacity:methodCount];
    
    for(int i=0;i<methodCount;i++)
    {
        Method temp = methodList[i];
        //        IMP imp = method_getImplementation(temp);
        //        SEL name_f = method_getName(temp);
        const char* name_s =sel_getName(method_getName(temp));
        //        int arguments = method_getNumberOfArguments(temp);
        //        const char* encoding =method_getTypeEncoding(temp);
        //        NSLog(@"方法名：%@,参数个数：%d,编码方式：%@",[NSString stringWithUTF8String:name_s], arguments, [NSString stringWithUTF8String:encoding]);
        [methodsArray addObject:[NSString stringWithUTF8String:name_s]];
    }
    free(methodList);
    for (NSString *methodStr   in [methodsArray copy]) {
        if ([methodStr isEqualToString:selectorStr]) {
            return YES;
            break;
        }
    }
    return NO;
}

+ (void)dd_exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}

+ (void)dd_exchangeClassMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getClassMethod(self, method1), class_getClassMethod(self, method2));
}

- (id)dd_runSelector:(SEL)aSelector withObjects:(NSArray *)objects
{
    NSMethodSignature *signature = [self methodSignatureForSelector:aSelector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:aSelector];
    
    NSUInteger i = 1;
    
    for (id object in objects) {
        id tempObject = object;
        [invocation setArgument:&tempObject atIndex:++i];
    }
    [invocation invoke];
    
    if ([signature methodReturnLength]) {
        id data;
        [invocation getReturnValue:&data];
        return data;
    }
    return nil;
}


+ (id)dd_performSelector:(SEL)selector withTarget:(id)target objects:(NSArray *)objects
{
    if (!target) {
        target = self;
    }
    // 方法签名(方法的描述)
    NSMethodSignature *signature = [target methodSignatureForSelector:selector];
    if (signature == nil) {
#ifdef DEBUG
        [NSException raise:@"错误" format:@"%@方法找不到", NSStringFromSelector(selector)];
#else
#endif
        return nil;
    }
    
    // NSInvocation : 利用一个NSInvocation对象包装一次方法调用（方法调用者、方法名、方法参数、方法返回值）
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = target;
    invocation.selector = selector;
    
    // 设置参数
    NSInteger paramsCount = signature.numberOfArguments -2; //除self、_cmd以外的参数个数
    paramsCount = MIN(paramsCount, objects.count);
    for (NSInteger i = 0; i < paramsCount; i++) {
        id object = objects[i];
        if ([object isKindOfClass:[NSNull class]]) continue;
        [invocation setArgument:&object atIndex:i + 2];
    }
    // 调用方法
    [invocation invoke];
    // 获取返回值
    id returnValue =nil;
    if (signature.methodReturnLength) {// 有返回值类型，才去获得返回值
        [invocation getReturnValue:&returnValue];
    }
    return returnValue;
}
+ (id)dd_performClassSelector:(SEL)selector withObjects:(NSArray *)objects
{
    return [self dd_performSelector:selector withTarget:self objects:objects];
}
- (id)dd_performInstanceSelector:(SEL)selector withObjects:(NSArray *)objects
{
    return [[self class] dd_performSelector:selector withTarget:self objects:objects];
}

@end
