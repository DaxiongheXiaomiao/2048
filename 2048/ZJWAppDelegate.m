//
//  ZJWAppDelegate.m
//  2048
//
//  Created by DaxiongheXiaomiao on 14-7-26.
//  Copyright (c) 2014年 DaxiongheXiaomiao. All rights reserved.
//

#import "ZJWAppDelegate.h"
#import "ZJWViewController.h"

@implementation ZJWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application{

    if([self.window.rootViewController isKindOfClass:[ZJWViewController class]]){
    
        ZJWViewController *viewCotroller = (ZJWViewController *)self.window.rootViewController;
        
        viewCotroller.archiveRecord();
        NSLog(@"archive record");
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application{

    if([self.window.rootViewController isKindOfClass:[ZJWViewController class]]){
        
        ZJWViewController *viewCotroller = (ZJWViewController *)self.window.rootViewController;
        
        viewCotroller.archiveRecord();
        NSLog(@"archive record");
    }
    
}
@end
