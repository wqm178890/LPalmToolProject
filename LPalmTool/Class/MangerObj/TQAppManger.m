//
//  TQAppManger.m
//  LPalmNews
//
//  Created by 林述灿 on 15/8/18.
//  Copyright (c) 2015年 LSC. All rights reserved.
//

#import "TQAppManger.h"
#import "MobClick.h"

#import "ChargeViewCtrl.h"
#import "AboutSystemViewCtrl.h"
#import "SaveElectricityViewCtrl.h"
#import "RemindViewCtrl.h"

@interface TQAppManger ()<TQTabBarControllerDelegate>
@property(nonatomic, retain) TQTabBarController* mainTabBar;
@end

@implementation TQAppManger
@synthesize mainNavigateCtrl;
@synthesize mainTabBar;

+ (TQAppManger *)sharedManger {
    
    static TQAppManger* kTQAppManger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kTQAppManger = [[TQAppManger alloc] init];
    });

    return kTQAppManger;
}

- (TQTabBarController*)initMainTabbar{
    self.mainTabBar = [[[TQTabBarController alloc] init] autorelease];
    self.mainTabBar.tabBarDelegate = self;
    [self performSelector:@selector(createMainTabbar) withObject:nil afterDelay:3];//暂时延时3s看效果，后续由服务端控制
    return self.mainTabBar;
}

- (void)createMainTabbar{
    
    NSArray* array = [NSArray arrayWithObjects:
                      [NSDictionary dictionaryWithObjectsAndKeys:@"Skin/tabbar_mainframe.png", @"normal", @"Skin/tabbar_mainframeHL.png", @"select",@"充电",  @"title", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"Skin/tabbar_contacts.png", @"normal", @"Skin/tabbar_contactsHL.png", @"select",@"省电",  @"title", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"Skin/tabbar_discover.png", @"normal", @"Skin/tabbar_discoverHL.png", @"select",@"提醒",  @"title", nil],
                      [NSDictionary dictionaryWithObjectsAndKeys:@"Skin/tabbar_me.png", @"normal", @"Skin/tabbar_meHL.png", @"select",@"系统",  @"title", nil],
                      nil];
    
    ChargeViewCtrl* t1 = [[ChargeViewCtrl alloc]init];
    t1.title = _(@"charget title");
    TQNavigationController * nav1 = [[TQNavigationController alloc] initWithRootViewController:t1];
    
    SaveElectricityViewCtrl* t2 = [[SaveElectricityViewCtrl alloc]init];
    t2.title =_(@"power save title");
    TQNavigationController * nav2 = [[TQNavigationController alloc] initWithRootViewController:t2];
    
    RemindViewCtrl* t3 = [[RemindViewCtrl alloc]init];
    t3.title = _(@"remind title");
    TQNavigationController * nav3 = [[TQNavigationController alloc] initWithRootViewController:t3];
    
    AboutSystemViewCtrl* t4 = [[AboutSystemViewCtrl alloc]init];
    t4.title = _(@"system title");
    TQNavigationController * nav4 = [[TQNavigationController alloc] initWithRootViewController:t4];
    
    self.mainTabBar.viewControllers = [NSArray arrayWithObjects:nav1, nav2, nav3, nav4, nil];
    [self.mainTabBar initTabBarView:array];
}

- (void)tabBarDidSelectViewController:(UIViewController *)viewController didSelectItem:(NSDictionary*)item{
    self.mainNavigateCtrl = (TQNavigationController*)viewController;
}

- (void)initUMengTrack
{
    //[MobClick setCrashReportEnabled:NO]; // 如果不需要捕捉异常，打开此行
    //[MobClick setLogEnabled:YES];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:(ReportPolicy) REALTIME channelId:@""];
    //   reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
    //   channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
    
    [MobClick updateOnlineConfig];  //在线参数配置
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineConfigCallBack:) name:UMOnlineConfigDidFinishedNotification object:nil];
}

- (void)onlineConfigCallBack:(NSNotification *)note {
    
    NSLog(@"online config has fininshed and note = %@", note.userInfo);
}

@end
