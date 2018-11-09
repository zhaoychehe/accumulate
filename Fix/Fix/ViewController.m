//
//  ViewController.m
//  Fix
//
//  Created by 赵燕超 on 2018/11/8.
//  Copyright © 2018 dbaglobal. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD+YCExtension.h"
#import "NSObject+YCExtension.h"
#import "YCButton.h"
#import "YCFix.h"

@interface ViewController ()

@property (nonatomic, weak) UISwitch *sw;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(200, 250, 50, 30)];
    sw.onTintColor = [UIColor purpleColor];
    [self.view addSubview:sw];
    self.sw = sw;
    
    [self addView];
}

- (void)addView
{
    YCButton *v = [[YCButton alloc] init];
    v.backgroundColor = [UIColor redColor];
    v.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:v];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    void  (^animation)(void) = ^{
//        self.sw.on = YES;
//    };
//    SEL sel = @selector(click);
//    NSString
//    [ViewController dd_performClassSelector:@selector(animate:animations:) withObjects:@[@"147", sel]];
////    [ViewController animate:@"1234" animations:animation];
////    [UIView dd_performClassSelector:@selector(animateWithDuration:animations:) withObjects:@[]];
////    [ViewController performSelector:@selector(animate:animations:) withObject:@"4321" withObject:animation];
    
//    [self showLoading];
}

- (void)showLoading
{
    NSLog(@"123");
}

- (void)click
{
}


@end
