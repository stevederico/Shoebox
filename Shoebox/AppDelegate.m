//
//  AppDelegate.m
//  Shoebox
//
//  Created by Stephen Derico on 6/3/12.
//  Copyright (c) 2012 Bixby Apps. All rights reserved.
//
#import "SDDataManager.h"
#import "HomeViewController.h"
#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"9sIiiAhe4l7nDsDgwrsM0FgkhZstPL4Kct8mizfT"
                  clientKey:@"WsmsEbjX8ztmiT9N2Qxzjvj1Ye1e6rWW8D14c07D"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    HomeViewController *hvc = [[HomeViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:hvc];
    [self.window setRootViewController:nav];
    
    
    
    
//    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
  
    
    return YES;
}


@end
