//
//  TQNetWriter.m
//  LPalmTool
//
//  Created by 林述灿 on 15/10/26.
//  Copyright © 2015年 LSC. All rights reserved.
//

#import "TQNetWriter.h"

@interface TQNetWriter ()
@property(nonatomic, retain)NSMutableString* strUrlData;
@property(nonatomic, retain) NSString* strBaseUrl;
@end

@implementation TQNetWriter

static NSString * s_defaultURL = nil;
static bool s_bUseTestUrl = false;
#define KEY @"iloveyou2015"
@synthesize strBaseUrl, strUrlData;

-(id) init
{
    if(self = [super init])
    {
        [self initUrl];
    }
    
    return self;
}

-(void) initUrl
{
    [self initBaseUrl];
    self.strUrlData = [NSMutableString string];
    self.strBaseUrl = s_defaultURL;
}

-(void)initBaseUrl
{
    if (s_defaultURL == nil) {//后期根据umeng那边设定修改
        s_defaultURL = @"http://api.andreader.com/api.aspx";
    }
}

-(void)appendInteger:(NSString*)key value:(NSInteger)value
{
    NSNumber* num = [NSNumber numberWithInteger:value];
    [self appendNumber:key value:num];
}
-(void)appendInt64:(NSString *)key value:(long long)value
{
    NSNumber* num = [NSNumber numberWithLongLong:value];
    [self appendNumber:key value:num];
    
}
-(void)appendString:(NSString *)key value:(NSString*)value
{
    if (value == nil) {
        value = @"";
    }
    NSString *str = encodeString(value);
    [self.strUrlData appendFormat:@"&%@=%@", key, str];
}
-(void)appendBool:(NSString *)key value:(BOOL)value
{
    int data = value? 1: 0;
    NSNumber* num = [NSNumber numberWithBool:data];
    [self appendNumber:key value:num];
}

-(void) appendNumber:(NSString *)key value:(NSNumber*)value
{
    [self.strUrlData appendFormat:@"&%@=%@", key, value.stringValue];
}

-(void)appendDic:(NSDictionary*) dic
{
    for (NSString* strKey in dic.allKeys) {
        NSString* value = [dic objectForKey:strKey];
        [self appendString:strKey value:value];
    }
}

-(NSString*) url:(int)actionID
{
    [self appendInteger:@"actionID" value:actionID];
    return [self url];
}

-(NSString*) url
{
    NSString* strFullUrl = nil;
    
    [self appendCommonData];
    
    NSString* md5Data = [NSString stringWithFormat:@"%@%@", self.strUrlData, KEY];
    NSString*sign =  getStringFormMD5(md5Data);
    [self appendString:@"sign" value:sign];
    
    
    if ([self.strBaseUrl rangeOfString:@"?"].length > 0) {
        strFullUrl = [NSString stringWithFormat:@"%@%@", self.strBaseUrl, self.strUrlData];
    }
    else{
        strFullUrl = [NSString stringWithFormat:@"%@?%@", self.strBaseUrl,self.strUrlData];
    }
    return strFullUrl;
}

-(void) appendCommonData
{
    NSString* width = [NSString stringWithFormat:@"%.0f", [UIScreen mainScreen].bounds.size.width];
    NSString* height =[NSString stringWithFormat:@"%.0f", [UIScreen mainScreen].bounds.size.height];
    NSString* model = [[UIDevice currentDevice] model];
    NSString* version = [UIDevice currentDevice].systemVersion;
    
    NSString *ver = @"1";
    NSString *appstoreVer = @"1.0";
    NSString *mt = @"1";//设备类型 1：ios 2：安卓
    NSString* channelId = @"AppStore";//渠道
    BOOL isJailbroken = NO;
    
//    [self appendString:@"guid" value:strUid];//设备唯一标识，后期根据实际情况再加
    [self appendString:@"systemver" value:version];
    [self appendString:@"ver" value:ver];
    [self appendString:@"appstorever" value:appstoreVer];
    [self appendString:@"mt" value:mt];
    [self appendString:@"sw" value:width];
    [self appendString:@"sh" value:height];
    [self appendString:@"device" value:model];
    [self appendBool:@"isJailbroken" value:isJailbroken];
    [self appendString:@"Chl" value:channelId];
}



-(void)dealloc
{
    self.strUrlData = nil;
    self.strBaseUrl = nil;
    
    [super dealloc];
}

@end
