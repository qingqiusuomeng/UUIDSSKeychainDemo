//
//  ViewController.m
//  UUIDSSKeychainDemo
//
//  Created by 李秋 on 2018/5/16.
//  Copyright © 2018年 liqiu. All rights reserved.
//

#import "ViewController.h"
#import "SSKeychain.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"获取唯一标识" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(getDeviceUUID) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}
- (void)getDeviceUUID{
    NSString * currentDeviceUUIDStr = [SSKeychain passwordForService:@"com.liqiu"account:@"uuid"];
    if (currentDeviceUUIDStr == nil || [currentDeviceUUIDStr isEqualToString:@""])
    {
        NSUUID * currentDeviceUUID  = [UIDevice currentDevice].identifierForVendor;
        currentDeviceUUIDStr = currentDeviceUUID.UUIDString;
        currentDeviceUUIDStr = [currentDeviceUUIDStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
        currentDeviceUUIDStr = [currentDeviceUUIDStr lowercaseString];
        [SSKeychain setPassword: currentDeviceUUIDStr forService:@"com.liqiu"account:@"uuid"];
    }
    NSLog(@"currentDeviceUUIDStr = %@",currentDeviceUUIDStr) ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
