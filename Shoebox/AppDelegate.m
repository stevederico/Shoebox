//
//  AppDelegate.m
//  Shoebox
//
//  Created by Stephen Derico on 6/3/12.
//  Copyright (c) 2012 Bixby Apps. All rights reserved.
//
#import "HomeViewController.h"
#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    HomeViewController *hvc = [[HomeViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:hvc];
    [self.window setRootViewController:nav];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


@end
