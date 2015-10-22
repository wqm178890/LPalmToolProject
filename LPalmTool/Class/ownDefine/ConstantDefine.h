//
//  ConstantDefine.h
//  TQProject
//
//  Created by Reader on 15/4/14.
//  Copyright (c) 2015年 Reader. All rights reserved.
//

#ifndef TQProject_ConstantDefine_h
#define TQProject_ConstantDefine_h

#import "DeviceDetection.h"

#define NAVIGATION_TOP_HEIGHT (44)//横屏32
#define ToolBar_Height       49//(47)
#define StatusBarHeight (20)

#define ScreenWidth [DeviceDetection screenWidth]
#define ScreenWidthLandscape [DeviceDetection screenWidthLandscape]
#define ScreenHeight [DeviceDetection screenHeight]
#define ScreenHeightLandscape [DeviceDetection screenHeightLandscape]

#define ClientSizeFull [DeviceDetection clientSizeFull]
#define ClientSizeFullLandscape [DeviceDetection clientSizeFullLandscape]
#define ClientSize [DeviceDetection clientSize]//除状态栏
#define ClientSizeLandscape [DeviceDetection clientSizeLandscape]//除状态栏
#define ClientSizeNavi [DeviceDetection clientSizeNavi]// 除状态栏 navibar
#define ClientSizeNaviLandscape [DeviceDetection clientSizeNaviLandscape]// 除状态栏 navibar
#define ClientSizeNaviWithoutToolbar [DeviceDetection clientSizeNaviWithoutToolbar]// 除状态栏 navibar 底部栏
#define ClientSizeNaviWithoutToolbarLandscape [DeviceDetection clientSizeNaviWithoutToolbarLandscape]// 除状态栏 navibar 底部栏

#define UMENG_APPKEY @"56264430e0f55a8aba001c26"

#endif
