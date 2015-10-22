//
//  DeviceDetection.h
//  SoundStock
//
//  Created by 林述灿 on 15/7/29.
//  Copyright (c) 2015年 Reader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceDetection : NSObject

+ (CGRect)clientSizeFull;
+ (CGRect)clientSizeFullLandscape;
//除状态栏
+ (CGRect)clientSize;
//除状态栏
+ (CGRect)clientSizeLandscape;
// 除状态栏 20 navibar
+ (CGRect)clientSizeNavi;
// 除状态栏 20 navibar
+ (CGRect)clientSizeNaviLandscape;
// 除状态栏 navibar 底部栏
+ (CGRect)clientSizeNaviWithoutToolbar;
// 除状态栏 navibar 底部栏
+ (CGRect)clientSizeNaviWithoutToolbarLandscape;
+ (CGFloat)screenWidth;
+ (CGFloat)screenWidthLandscape;
+ (CGFloat)screenHeight;
+ (CGFloat)screenHeightLandscape;
@end
