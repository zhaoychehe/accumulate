//
//  ViewController.m
//  Fix
//
//  Created by 赵燕超 on 2018/11/8.
//  Copyright © 2018 dbaglobal. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD+YCExtension.h"

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
    UIButton *v = [[UIButton alloc] init];
    v.backgroundColor = [UIColor redColor];
    [v addTarget:self action:@selector(click) forControlEvents:64];
    v.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:v];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.sw.on = YES;
    [self showLoading];
}

- (void)showLoading
{
    NSLog(@"123");
}

- (void)click
{
}


@end
