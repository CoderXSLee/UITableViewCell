//
//  AppDelegate.m
//  UITableViewCell-展开查看更多
//
//  Created by Ariel on 15/7/8.
//  Copyright (c) 2015年 Ariel. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    MainViewController *controller = [[MainViewController alloc] init];
    self.window.rootViewController = controller;
    
    [self.window makeKeyAndVisible];
    return YES;
}


@end
