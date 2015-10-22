//
//  DeviceDetection.m
//  SoundStock
//
//  Created by 林述灿 on 15/7/29.
//  Copyright (c) 2015年 Reader. All rights reserved.
//

#import "DeviceDetection.h"

@implementation DeviceDetection

+ (float)getScreenScale
{
    float scale = 1.0;
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
    {
        scale = [UIScreen mainScreen].scale;
    }
    
    return scale;
}

+(CGRect) mainScreenBounds
{
    CGRect ret = [UIScreen mainScreen].bounds;
    
    float width = ret.size.width < ret.size.height ? ret.size.width:ret.size.height;
    float height = ret.size.height > ret.size.width ? ret.size.height:ret.size.width;
    CGRect rc = CGRectMake(0, 0, width, height);
    
    return rc;
}

+ (CGRect)clientSizeFull
{
    CGRect rcClientSizeFull = [DeviceDetection mainScreenBounds];
    return rcClientSizeFull;
}


+ (CGRect)clientSizeFullLandscape
{
    CGRect rcClientSizeFullLandscape = [DeviceDetection mainScreenBounds];
    
    CGFloat w = rcClientSizeFullLandscape.size.height;
    rcClientSizeFullLandscape.size.height = rcClientSizeFullLandscape.size.width;
    rcClientSizeFullLandscape.size.width = w;
    
    return rcClientSizeFullLandscape;
}


//除状态栏
+ (CGRect)clientSize
{
    CGRect rcClientSize = [DeviceDetection mainScreenBounds];
    rcClientSize.size.height -= StatusBarHeight;
    return rcClientSize;
}
//除状态栏
+ (CGRect)clientSizeLandscape
{
    CGRect rcClientSizeLandscape = [DeviceDetection mainScreenBounds];
    
    CGFloat w = rcClientSizeLandscape.size.height;
    rcClientSizeLandscape.size.height = rcClientSizeLandscape.size.width;
    rcClientSizeLandscape.size.width = w;
    
    rcClientSizeLandscape.size.height -= StatusBarHeight;
    return rcClientSizeLandscape;
}

// 除状态栏 20 navibar
+ (CGRect)clientSizeNavi
{
    CGRect rcClientSizeNavi = [DeviceDetection mainScreenBounds];
//    rcClientSizeNavi.origin.y += NAVIGATION_TOP_HEIGHT;
    rcClientSizeNavi.size.height -= (StatusBarHeight + NAVIGATION_TOP_HEIGHT);
    return rcClientSizeNavi;
}

// 除状态栏 20 navibar
+ (CGRect)clientSizeNaviLandscape
{
    CGRect rcClientSizeNaviLandscape = [DeviceDetection mainScreenBounds];
    
    CGFloat w = rcClientSizeNaviLandscape.size.height;
//    rcClientSizeNaviLandscape.origin.y += NAVIGATION_TOP_HEIGHT;
    rcClientSizeNaviLandscape.size.height = rcClientSizeNaviLandscape.size.width;
    rcClientSizeNaviLandscape.size.width = w;
    rcClientSizeNaviLandscape.size.height -= (StatusBarHeight + NAVIGATION_TOP_HEIGHT);
    return rcClientSizeNaviLandscape;
}

// 除状态栏 navibar 底部栏
+ (CGRect)clientSizeNaviWithoutToolbar
{
    CGRect rcClientSizeNavi = [DeviceDetection mainScreenBounds];
//    rcClientSizeNavi.origin.y += StatusBarHeight + NAVIGATION_TOP_HEIGHT;
    rcClientSizeNavi.size.height -= (StatusBarHeight + NAVIGATION_TOP_HEIGHT + ToolBar_Height);
    return rcClientSizeNavi;
}

// 除状态栏 navibar 底部栏
+ (CGRect)clientSizeNaviWithoutToolbarLandscape
{
    CGRect rcClientSizeNaviLandscape = [DeviceDetection mainScreenBounds];
    
    CGFloat w = rcClientSizeNaviLandscape.size.height;
//    rcClientSizeNaviLandscape.origin.y += NAVIGATION_TOP_HEIGHT;
    rcClientSizeNaviLandscape.size.height = rcClientSizeNaviLandscape.size.width;
    rcClientSizeNaviLandscape.size.width = w;
    rcClientSizeNaviLandscape.size.height -= (StatusBarHeight + NAVIGATION_TOP_HEIGHT + ToolBar_Height);
    return rcClientSizeNaviLandscape;
}

+ (CGFloat)screenWidth{
    CGRect rcClientSizeNavi = [DeviceDetection mainScreenBounds];
    return rcClientSizeNavi.size.width;
}

+ (CGFloat)screenWidthLandscape{
    CGRect rcClientSizeNavi = [DeviceDetection mainScreenBounds];
    return rcClientSizeNavi.size.height;
}

+ (CGFloat)screenHeight{
    CGRect rcClientSizeNavi = [DeviceDetection mainScreenBounds];
    return rcClientSizeNavi.size.height;
}

+ (CGFloat)screenHeightLandscape{
    CGRect rcClientSizeNavi = [DeviceDetection mainScreenBounds];
    return rcClientSizeNavi.size.width;
}

@end
