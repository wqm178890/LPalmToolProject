//
//  BaseWebURLCache.m
//  ChangDu
//
//  Created by Reader on 15/5/26.
//
//

#import "BaseWebURLCache.h"
#import "UMengOnlineParameterManger.h"
#import "TQFunction.h"

#define HTTP_OK (200)

@implementation BaseWebURLCache
//application/x-javascript
- (NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request {
    
    NSString *pathString = [[request URL] absoluteString];
//    NSLog(@"cachedResponseForRequest:\n%@", pathString);
    
    if (![self isImageType:request]) {
        NSString* strPlist = [self getPathPlist:request];
        NSMutableDictionary *dict = [[[NSMutableDictionary alloc] initWithContentsOfFile:strPlist] autorelease];
//        NSString* strExpires = [dict objectForKey:@"Expires"];
        if (dict  ){//&& ![self isExpires:strExpires]) {//且没过期 则直接返回缓存
            NSString* strPath = [self getFilePath:request];
            NSData* data = [NSData dataWithContentsOfFile:strPath];
            NSString* strType = [dict objectForKey:@"Content-Type"];
            NSArray* arr = [strType componentsSeparatedByString:@";"];
            strType = [arr objectAtIndex:0];
//            NSURLResponse *response = [[[NSURLResponse alloc] initWithURL:[request URL]
//                                                                MIMEType:strType
//                                                   expectedContentLength:[data length]
//                                                        textEncodingName:@"UTF-8"] autorelease];
//
//            
//            NSLog(@"use cache:\n%@", pathString);
//            NSCachedURLResponse* cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:data];
//            NSHTTPURLResponse* responsexx =((NSHTTPURLResponse*)cachedResponse.response);
//            NSLog([NSString stringWithFormat:@"==============statusCode = %d============", responsexx.statusCode ]);
            
            NSDictionary *headers = @{@"Access-Control-Allow-Origin" : @"*", @"Access-Control-Allow-Headers" : @"Content-Type"};
            NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:request.URL statusCode:200 HTTPVersion:@"1.0" headerFields:headers];
            
            return [[[NSCachedURLResponse alloc] initWithResponse:response data:data] autorelease];
            
        }
        else{
//            NSLog(@"request new:\n%@", pathString);
            return [super cachedResponseForRequest:request];
        }
    }
    
    NSString* strType = @"image/jpg";
    if ([pathString hasSuffix:@".png"]) {
        strType = @"image/png";
    }
    NSString* strPath = [self getFilePath:request];
    if ([self fileExist:strPath]) {
        NSData* data = [NSData dataWithContentsOfFile:strPath];
        NSURLResponse *response = [[[NSURLResponse alloc] initWithURL:[request URL]
                                                            MIMEType:strType
                                               expectedContentLength:[data length]
                                                    textEncodingName:nil] autorelease];

        return [[[NSCachedURLResponse alloc] initWithResponse:response data:data] autorelease];
    }
    
    return [super cachedResponseForRequest:request];
}

- (void)storeCachedResponse:(NSCachedURLResponse *)cachedResponse forRequest:(NSURLRequest *)request {
    NSString *pathString = [[request URL] absoluteString];
//    NSLog(@"===storeCachedResponse url = %@ ========", pathString);
    NSString* strPath = [self getFilePath:request];
    if (![self isImageType:request]) {
        
        NSHTTPURLResponse* response =((NSHTTPURLResponse*)cachedResponse.response);
        NSDictionary* allHeaderFileds = [((NSHTTPURLResponse*)cachedResponse.response) allHeaderFields];
//        NSString* strExpires = [allHeaderFileds objectForKey:@"Expires"];
        
        if (response.statusCode == HTTP_OK ){//&& strExpires && strExpires.length > 0) {
            NSString* strPlist = [self getPathPlist:request];
            [allHeaderFileds writeToFile:strPlist atomically:YES];//下一步  将头和Html内容合并
        }
        else{
            [super storeCachedResponse:cachedResponse forRequest:request];
        }
    }
    
    //request.ashx 这个请求不缓存
    if ([pathString.lowercaseString rangeOfString:@"request.ashx"].length > 0) {
         NSString* strPlist = [self getPathPlist:request];
        [[NSFileManager defaultManager] removeItemAtPath:strPlist error:nil];
    }else{
        [self saveFile:strPath  data:cachedResponse.data];
    }
}

-(BOOL) isExpires:(NSString*)strExpires
{
    if (strExpires == nil) {
        return NO;
    }
    
    NSDate* date = [self dateFromRFC1123String:strExpires];
    
    NSDate* now = [NSDate date];
    
    
    //NSDate * date2 = [self dateFromRFC1123Stringxx:strExpires];
    NSDate *compare = [now laterDate:date];
    BOOL bExpires = NO;
    if ([compare isEqual:now]) {
        bExpires = YES;
    }
    
    return bExpires;
    
}

-(NSDate *)dateFromRFC1123String:(NSString *)string
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
    // Does the string include a week day?
    NSString *day = @"";
    if ([string rangeOfString:@","].location != NSNotFound) {
        day = @"EEE, ";
    }
    // Does the string include seconds?
    NSString *seconds = @"";
    if ([[string componentsSeparatedByString:@":"] count] == 3) {
        seconds = @":ss";
    }
    [formatter setDateFormat:[NSString stringWithFormat:@"%@dd MMM yyyy HH:mm%@ z",day,seconds]];
    return [formatter dateFromString:string];
}



-(BOOL) fileExist:(NSString*) strPath
{
    return  [[NSFileManager defaultManager] fileExistsAtPath:strPath];
}

-(NSString*)getPathPlist:(NSURLRequest*) request
{
    NSString* strCache = [self getFilePath:request];
    NSString* strPlist = [NSString stringWithFormat:@"%@.plist", strCache];
    return strPlist;
}

-(BOOL) isImageType:(NSURLRequest*)request
{
    BOOL bImage = NO;
    NSString *pathString = [[request URL] absoluteString];
    if ([pathString hasSuffix:@".jpg"] || [pathString hasSuffix:@".png"]){
        bImage = YES;
    }
    
    return bImage;
    
}

-(NSString*) getFilePath:(NSURLRequest *)request
{
    NSString *pathString = [[request URL] absoluteString];
    
    return getWebFilePath(pathString);
}

-(void) saveFile:(NSString*) path data:(NSData*)data
{
    [data writeToFile:path atomically:YES];
}


@end


@implementation BaseURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    NSString* strPath = [[self class] getFilePath:request];
    BOOL bTrue =[[NSFileManager defaultManager] fileExistsAtPath:strPath isDirectory:nil];

    return bTrue;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (void) startLoading {
    id<NSURLProtocolClient> client = [self client];
    NSURLRequest* request = [self request];
    
    NSString* strPath = [[self class]getFilePath:request];
    NSData* data = [NSData dataWithContentsOfFile:strPath];
    NSHTTPURLResponse* response = [[[NSHTTPURLResponse alloc] initWithURL:[request URL] statusCode:200 HTTPVersion:@"HTTP/1.1" headerFields:[NSDictionary dictionary]] autorelease];
    [client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    [client URLProtocol:self didLoadData:data];
    [client URLProtocolDidFinishLoading:self];

}

+ (NSString*) getFilePath:(NSURLRequest *)request
{
    NSString *pathString = [[request URL] absoluteString];
    
    return getWebFilePath(pathString);
}

- (void) stopLoading {
}

@end
