//
//  TQServerResponseManage.h
//  LPalmTool
//
//  Created by 林述灿 on 15/10/26.
//  Copyright © 2015年 LSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TQServerResponseManage : NSObject

+ (NSObject*)decodeDataFromServer:(NSData*)data;

@end
