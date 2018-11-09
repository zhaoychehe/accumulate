//
//  MBProgressHUD+YCExtension.m
//  JollyPlanet
//
//  Created by Daniel on 2017/9/20.
//  Copyright © 2017年 com.jollyColors.www. All rights reserved.
//

#import "MBProgressHUD+YCExtension.h"

@implementation MBProgressHUD (YCExtension)

#pragma mark 显示信息
+ (void)dd_show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].windows.lastObject;
    MBProgressHUD *hud = [self HUDForView:view];
    if (hud) {
        if (hud.mode != MBProgressHUDModeAnnularDeterminate) { // 已有loading 先删除
            [self dd_hideHUD];
            hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        }
    }else {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:1.5];
}

#pragma mark 显示错误信息
+ (void)dd_showError:(NSString *)error toView:(UIView *)view{
    [self dd_show:error icon:@"error.png" view:view];
}

+ (void)dd_showSuccess:(NSString *)success toView:(UIView *)view
{
    [self dd_show:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)dd_showMessage:(NSString *)message toView:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].windows.lastObject;
    MBProgressHUD *hud = [self HUDForView:view];
    if (hud) {
        if (hud.mode != MBProgressHUDModeAnnularDeterminate) { // 已有loading 先删除
            [self dd_hideHUD];
            hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        }
    }else {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    
    return hud;
}

#pragma mark 显示进度条
+ (MBProgressHUD *)dd_showProgress:(CGFloat)progress message:(NSString *)message toView:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].windows.lastObject;
    MBProgressHUD *hud = [self HUDForView:view];
    if (hud) {
        if (hud.mode != MBProgressHUDModeAnnularDeterminate) { // 已有loading 先删除
            [self dd_hideHUD];
            hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        }
    }else {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    
    // Set the annular determinate mode to show task progress.
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    if (message.length) {
        hud.labelText = message;
    }
    
    progress = MIN(1.0, MAX(0.0, progress));
    hud.progress = progress;
    
    return hud;
}


#pragma mark 显示loading
+ (MBProgressHUD *)dd_showLoading
{
    return [[self class] dd_showLoadingWithView:nil];
}

+ (MBProgressHUD *)dd_showLoadingWithView:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].windows.lastObject;
    if ([self HUDForView:view]) { // 已有loading 直接返回
        return [self HUDForView:view];
    }
//    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"loading_0"],[UIImage imageNamed:@"loading_1"],[UIImage imageNamed:@"loading_2"],[UIImage imageNamed:@"loading_3"], nil];
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen dd_screenWidth]-70)*0.5, 200, 70, 70)];
//    imageView.animationImages = array; //动画图片数组
//    imageView.animationDuration = 0.8; //执行一次完整动画所需的时长
//    //    gifImageView.animationRepeatCount = 0;  //动画重复次数 0表示无限次，默认为0
//    [imageView startAnimating];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.customView = imageView;
//    hud.dimBackground = NO;
//    // 隐藏时候从父控件中移除
//    hud.removeFromSuperViewOnHide = YES;
//    hud.mode = MBProgressHUDModeCustomView;
//    //小矩形的背景色
//    hud.color = [UIColor clearColor];
    
    return hud;
    
}

+ (void)dd_showSuccess:(NSString *)success
{
    [self dd_showSuccess:success toView:nil];
}

+ (void)dd_showError:(NSString *)error
{
    [self dd_showError:error toView:nil];
}

+ (MBProgressHUD *)dd_showMessage:(NSString *)message
{
    return [self dd_showMessage:message toView:nil];
}

+ (MBProgressHUD *)dd_showProgress:(CGFloat)progress message:(NSString *)message
{
    return [self dd_showProgress:progress message:message toView:nil];
}

+ (void)dd_hideHUDForView:(UIView *)view
{
    [self hideHUDForView:view animated:YES];
}

+ (void)dd_hideHUD
{
    [self dd_hideHUDForView:nil];
}

@end
