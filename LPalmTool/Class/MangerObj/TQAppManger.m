//
//  TQAppManger.m
//  LPalmNews
//
//  Created by 林述灿 on 15/8/18.
//  Copyright (c) 2015年 LSC. All rights reserved.
//

#import "TQAppManger.h"
#import "MobClick.h"

@implementation TQAppManger
@synthesize mainNavigateCtrl;

+ (TQAppManger *)sharedManger {
    
    static TQAppManger* kTQAppManger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kTQAppManger = [[TQAppManger alloc] init];
    });

    return kTQAppManger;
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
