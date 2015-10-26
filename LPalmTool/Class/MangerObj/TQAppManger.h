//
//  TQAppManger.h
//  LPalmNews
//
//  Created by 林述灿 on 15/8/18.
//  Copyright (c) 2015年 LSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TQNavigationController.h"
#import "TQTabBarController.h"

@interface TQAppManger : NSObject
@property(nonatomic, retain) TQNavigationController* mainNavigateCtrl;

+ (TQAppManger *)sharedManger;
- (TQTabBarController*)initMainTabbar;
- (void)initUMengTrack;

@end
