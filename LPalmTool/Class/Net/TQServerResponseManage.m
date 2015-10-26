//
//  TQServerResponseManage.m
//  LPalmTool
//
//  Created by 林述灿 on 15/10/26.
//  Copyright © 2015年 LSC. All rights reserved.
//

#import "TQServerResponseManage.h"

@implementation TQServerResponseManage

+ (NSObject*)decodeDataFromServer:(NSData*)data {
    
    @synchronized(self) {
        NSObject* ret = nil;
        if (data != nil && [data length]) {
            ret = (NSObject*)[[self class] decodeData:data];
        }
        
        return ret;
    }
}

+ (NSObject*)decodeData:(NSData*)data{
     NSObject* ret = nil;
    
    return ret;
}

@end
