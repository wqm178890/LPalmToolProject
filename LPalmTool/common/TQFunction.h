//
//  TQFunction.h
//  SoundStock
//
//  Created by Reader on 15/7/1.
//  Copyright (c) 2015年 Reader. All rights reserved.
//

#ifndef __TQFUNCTION_H
#define __TQFUNCTION_H

#import <UIKit/UIKit.h>

NSString* getStringFormMD5(NSString* str);

UIImage* getResizableImageWithImg(UIImage* img);
UIImage* resizableImageWithCapInsets(UIEdgeInsets insets,UIImage* img);
NSString* getDevicePlatform();

NSString *webCachePathForKey(NSString *key);
NSString* getWebFilePath(NSString *requestUrl);

NSString* decodeString(NSString* strUrl);
NSString* encodeString(NSString* strUrl);

#endif
