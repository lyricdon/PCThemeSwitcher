//
//  AppDelegate.m
//  PCThemeSwitcher
//
//  Created by Lyric Don on 2018/2/26.
//  Copyright © 2018年 PCTheme.com. All rights reserved.
//

#import "AppDelegate.h"
#import "PCTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [PCTabBarController tabbar];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
