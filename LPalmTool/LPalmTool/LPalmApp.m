//
//  AppDelegate.m
//  LPalmNews
//
//  Created by 林述灿 on 15/8/4.
//  Copyright (c) 2015年 LSC. All rights reserved.
//

#import "LPalmApp.h"

#import "TQNavigationController.h"
#import "TQViewController.h"
#import "TQTabBarController.h"

#import "ChargeViewCtrl.h"
#import "AboutSystemViewCtrl.h"
#import "SaveElectricityViewCtrl.h"
#import "RemindViewCtrl.h"

#import "TQAppManger.h"

@interface LPalmApp ()

@end

@implementation LPalmApp


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    ChargeViewCtrl* t1 = [[ChargeViewCtrl alloc]init];
    t1.title = @"充电";
    TQNavigationController * nav1 = [[TQNavigationController alloc] initWithRootViewController:t1];
    
    SaveElectricityViewCtrl* t2 = [[SaveElectricityViewCtrl alloc]init];
    t2.title = @"省电";
    TQNavigationController * nav2 = [[TQNavigationController alloc] initWithRootViewController:t2];
    
    RemindViewCtrl* t3 = [[RemindViewCtrl alloc]init];
    t3.title = @"提醒";
    TQNavigationController * nav3 = [[TQNavigationController alloc] initWithRootViewController:t3];
    
    AboutSystemViewCtrl* t4 = [[AboutSystemViewCtrl alloc]init];
    t4.title = @"系统";
    TQNavigationController * nav4 = [[TQNavigationController alloc] initWithRootViewController:t4];
    
    TQTabBarController*  _viewController = [[TQTabBarController alloc] init];
    _viewController.viewControllers = [NSArray arrayWithObjects:nav1, nav2, nav3, nav4, nil];
    
    self.window.rootViewController = _viewController;
    [self.window makeKeyAndVisible];
    
//    UIImageView* startImageView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    //    if (iPhone5) {
//    startImageView.image = [UIImage imageNamed:@"LaunchImage-700-568h"];
//    //    }else if (iPhone6) {
//    //        self.startImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
//    //    }else if (iPhone6Plus) {
//    //        self.startImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h"];
//    //    }else {
//    //        self.startImageView.image = [UIImage imageNamed:@"LaunchImage-700"];
//    //    }
//    UIImage* image = [UIImage imageNamed:@"Skin/640*1136.jpg"];
//    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width/3, image.size.height/3)];
//    //    if (iPhone5) {
//    imageView.image = image;
//    [startImageView addSubview:imageView];
//    [imageView release];
//    
//    [[UIApplication sharedApplication].keyWindow addSubview:startImageView];
//    [startImageView release];
    
    [[TQAppManger sharedManger] initUMengTrack];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
