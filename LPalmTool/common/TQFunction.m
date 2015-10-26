//
//  TQFunction.m
//  SoundStock
//
//  Created by Reader on 15/7/1.
//  Copyright (c) 2015年 Reader. All rights reserved.
//

#import "TQFunction.h"
#include <sys/sysctl.h>
#import <CommonCrypto/CommonDigest.h>

NSString* getStringFormMD5(NSString* str)
{
    const char* cStr =[str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result);
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

UIImage* getResizableImageWithImg(UIImage* img)
{
    if (img.size.height<3 || img.size.width<3)
    {
        return img;
    }
    CGFloat h = 0;
    if (ceilf(img.size.height/2)*2 < img.size.height)
    {
        //奇数
        h = ceilf(img.size.height/2);
    }
    else
    {
        h = ceilf(img.size.height/2)-1;
    }
    
    CGFloat w = 0;
    if (ceilf(img.size.width/2)*2 < img.size.width)
    {
        //奇数
        w = ceilf(img.size.width/2);
    }
    else
    {
        w = ceilf(img.size.width/2)-1;
    }
    
    
    UIEdgeInsets insets = UIEdgeInsetsMake(h,w,h,w);
    img = resizableImageWithCapInsets(insets,img);
    return img;
}

UIImage* resizableImageWithCapInsets(UIEdgeInsets insets,UIImage* img)
{
    if ([img respondsToSelector:@selector(resizableImageWithCapInsets:)])//(getSystemVesion() >= 5.0)
    {
        return [img resizableImageWithCapInsets:insets];
    }
    else
    {
        return [img stretchableImageWithLeftCapWidth:insets.left topCapHeight:insets.top];//ios6开始无效了
    }
}

NSString* getDevicePlatform()
{
//    size_t size;
//    int nR = sysctlbyname("hw.machine", NULL, &size, NULL, 0);
//    char *machine = (char *)malloc(size);
//    nR = sysctlbyname("hw.machine", machine, &size, NULL, 0);
//    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
//    free(machine);
    
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = (char *)malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
}

NSString* getWebCacheDir()
{
    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingString:@"/tmp/NetData/"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

NSString *webCachePathForKey(NSString *key)
{
    const char *str = [key UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    return filename;
}

NSString* getWebFilePath(NSString *requestUrl)
{
    NSString* md5 = @"";
//#ifdef SIM_DEBUG
    md5 = webCachePathForKey(requestUrl);
//#else
//    NSString* path = [NSString stringWithFormat:@"%@%@", getWebCacheDir(), requestUrl];
//    md5 = webCachePathForKey(path);
//#endif
    
    NSString* key = [NSString stringWithFormat:@"%@%@", getWebCacheDir(), md5];
    
    return key;
}

NSString* decodeString(NSString* strUrl)
{
    //使用系统的decode,有问题统一在这里改.
    strUrl = [strUrl stringByReplacingOccurrencesOfString:@"+" withString:@"%20"];
    NSString *str = [strUrl stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return str;
}

NSString* encodeString(NSString* strUrl)
{
    //使用系统的encode,有问题统一在这里改.
    NSString *str = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return str;
}
