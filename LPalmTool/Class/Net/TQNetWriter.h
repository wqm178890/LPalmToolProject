//
//  TQNetWriter.h
//  LPalmTool
//
//  Created by 林述灿 on 15/10/26.
//  Copyright © 2015年 LSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TQNetWriter : NSObject

-(void)appendInteger:(NSString*)key value:(NSInteger)value;
-(void)appendInt64:(NSString *)key value:(long long)value;
-(void)appendString:(NSString *)key value:(NSString*)value;
-(void)appendBool:(NSString *)key value:(BOOL)value;
-(void)appendDic:(NSDictionary*) dic;

@end
