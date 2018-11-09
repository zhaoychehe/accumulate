//
//  MBProgressHUD+YCExtension.h
//  JollyPlanet
//
//  Created by Daniel on 2017/9/20.
//  Copyright © 2017年 com.jollyColors.www. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (YCExtension)

+ (void)dd_showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)dd_showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)dd_showMessage:(NSString *)message toView:(UIView *)view;
+ (MBProgressHUD *)dd_showProgress:(CGFloat)progress message:(NSString *)message toView:(UIView *)view;

/**
 展示成功数据信息 1.5s自动消失

 @param success 成功数据信息
 */
+ (void)dd_showSuccess:(NSString *)success;

/**
 展示失败信息 1.2s自动消失

 @param error 失败信息
 */
+ (void)dd_showError:(NSString *)error;


/**
 展示信息 消失调用dd_hideHUD

 @param message 信息
 @return MBProgressHUD
 */
+ (MBProgressHUD *)dd_showMessage:(NSString *)message;


/**
 展示信息 消失调用dd_hideHUD

 @param progress 进度
 @param message 信息
 @return MBProgressHUD
 */
+ (MBProgressHUD *)dd_showProgress:(CGFloat)progress message:(NSString *)message;

/**
 消失
 */
+ (void)dd_hideHUD;
+ (void)dd_hideHUDForView:(UIView *)view;

/**
 展示Loading 消失调用dd_hideHUD

 @return MBProgressHUD
 */
+ (MBProgressHUD *)dd_showLoading;
+ (MBProgressHUD *)dd_showLoadingWithView:(UIView *)view;

@end
