//
//  UMengOnlineParameterManger.m
//  ChangDu
//
//  Created by Reader on 15/6/2.
//
//

#import "UMengOnlineParameterManger.h"
//#import "MobClick.h"

@implementation UMengOnlineParameterManger

@synthesize storeHotURL,storeAPIURL,storeCategoryURL,storeChatURL,storeRankURL,storeSearchURL,shelfInitBookURL,lastPageCommentURL,clientInitURL,httpConnectTimeout,webCacheTimeOut,version,fetchURL,bShowByAppSwitch,appCheckVersion;

+(UMengOnlineParameterManger*)shareManger{
    static UMengOnlineParameterManger* shareMange = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareMange = [[UMengOnlineParameterManger alloc] init];
    });
    
    return shareMange;
}

- (id)init{
    self = [super init];
    if (self) {
        self.httpConnectTimeout = 10;
        self.webCacheTimeOut = 10;
        self.version = 1014;
        self.appCheckVersion = 2;
        self.bShowByAppSwitch = NO;

//        self.storeHotURL = [self getRequestURLWithVersion:@"http://192.168.1.14/ulreader/HomePage.aspx?ver2=1010"];
//        self.storeCategoryURL = [self getRequestURLWithVersion:@"http://192.168.1.14/ulreader/HomePage.aspx?ver2=1010"];
//        self.lastPageCommentURL = [self getRequestURLWithVersion:@"http://192.168.1.14/ulreader/BookEnd.aspx?"];
        self.storeHotURL = [self getRequestURLWithVersion:@"http://121.42.31.179:8008/HomePage.aspx?ver2=1010"];
        self.storeAPIURL = [self getRequestURLWithVersion:@"http://121.42.31.179:8008/request.ashx"];
        self.storeCategoryURL = [self getRequestURLWithVersion:@"http://121.42.31.179:8008/CategoryPage.aspx?ver2=1010"];
        self.storeRankURL = [self getRequestURLWithVersion:@"http://121.42.31.179:8008/RankPage.aspx?ver2=1010"];
        self.storeSearchURL = [self getRequestURLWithVersion:@"http://121.42.31.179:8008/SearchPage.aspx?ver2=1010"];
        self.storeChatURL = [self getRequestURLWithVersion:@"http://121.42.31.179:8008/Chat.aspx?sv=1014"];
        self.shelfInitBookURL = [self getRequestURLWithVersion:@"http://121.42.31.179:8008/ClientDataInit.aspx"];
        self.lastPageCommentURL = [self getRequestURLWithVersion:@"http://121.42.31.179:8008/BookEnd.aspx?"];
        self.clientInitURL = [self getRequestURLWithVersion:@"http://121.42.31.179:8008/ClientOnStart.aspx"];
        self.fetchURL = @"http://121.42.31.179:8012/request.ashx?";
        
//        [self updateFromUMeng];
    }
    
    return self;
}

- (void)dealloc{
    
    self.storeHotURL = nil;
    self.storeAPIURL = nil;
    self.storeCategoryURL = nil;
    self.storeRankURL = nil;
    self.storeSearchURL = nil;
    self.storeChatURL = nil;
    self.shelfInitBookURL = nil;
    self.lastPageCommentURL = nil;
    self.clientInitURL = nil;
    self.fetchURL = nil;

    [super dealloc];
}

//- (void)updateFromUMeng{
//    
//    NSString* httpTimeout = [MobClick getConfigParams:@"httpConnectTimeout"];
//    if (httpTimeout && httpTimeout.length > 0) {
//        self.httpConnectTimeout = httpTimeout.integerValue;
//    }
//    
//    NSString* cacheTimeout = [MobClick getConfigParams:@"webCacheTimeout"];
//    if (cacheTimeout && cacheTimeout.length > 0) {
//        self.webCacheTimeOut = cacheTimeout.integerValue;
//    }
//    
//    NSString* ver = [MobClick getConfigParams:@"version"];
//    if (ver && ver.length > 0) {
//        self.version = ver.integerValue;
//    }
//    
//    NSString* hotUrl = [MobClick getConfigParams:@"storeHotUrl"];
//    if (hotUrl && hotUrl.length > 0) {
//        self.storeHotURL = [self getRequestURLWithVersion:hotUrl];
//    }
//    
//    NSString* rankUrl = [MobClick getConfigParams:@"storeRankUrl"];
//    if (rankUrl && rankUrl.length > 0) {
//        self.storeRankURL = [self getRequestURLWithVersion:rankUrl];
//    }
//    
//    NSString* categoryUrl = [MobClick getConfigParams:@"storeCategoryUrl"];
//    if (categoryUrl && categoryUrl.length > 0) {
//        self.storeCategoryURL = [self getRequestURLWithVersion:categoryUrl];
//    }
//    
//    NSString* searchUrl = [MobClick getConfigParams:@"storeSearchUrl"];
//    if (searchUrl && searchUrl.length > 0) {
//        self.storeSearchURL = [self getRequestURLWithVersion:searchUrl];
//    }
//    
//    NSString* shelfInitBookUrl = [MobClick getConfigParams:@"shelfInitBookUrl"];
//    if (shelfInitBookUrl && shelfInitBookUrl.length > 0) {
//        self.shelfInitBookURL = [self getRequestURLWithVersion:shelfInitBookUrl];
//    }
//    
//    NSString* lastPageCommentUrl = [MobClick getConfigParams:@"lastPageCommendUrl"];
//    if (lastPageCommentUrl && lastPageCommentUrl.length > 0) {
//        self.lastPageCommentURL = [self getRequestURLWithVersion:lastPageCommentUrl];
//    }
//    
//    NSString* clientInitUrl = [MobClick getConfigParams:@"clientInitUrl"];
//    if (clientInitUrl && clientInitUrl.length > 0) {
//        self.clientInitURL = [self getRequestURLWithVersion:clientInitUrl];
//    }
//    
//    NSString* storeApiUrl = [MobClick getConfigParams:@"storeAPIUrl"];
//    if (storeApiUrl && storeApiUrl.length > 0) {
//        self.storeAPIURL = [self getRequestURLWithVersion:storeApiUrl];
//    }
//    
//    NSString* storeChatUrl = [MobClick getConfigParams:@"storeChatUrl"];
//    if (storeChatUrl && storeChatUrl.length > 0) {
//        self.storeChatURL = [self getRequestURLWithVersion:storeChatUrl];
//    }
//    
//    NSString* fetchUrl = [MobClick getConfigParams:@"fetchUrl"];
//    if (fetchUrl && fetchUrl.length > 0) {
//        self.fetchURL = fetchUrl;
//    }
//    
//    NSString* appStoreCheckVersion = [MobClick getConfigParams:@"appStoreCheckVersion"];
//    if (appStoreCheckVersion && appStoreCheckVersion.length > 0) {
//        if (self.appCheckVersion >= appStoreCheckVersion.integerValue) {
//            self.bShowByAppSwitch = YES;
//        }
//    }
//}

- (NSString*)getRequestURLWithVersion:(NSString*)url{
    if ([url rangeOfString:@"?"].length > 0) {
        url = [NSString stringWithFormat:@"%@&ver=%ld", url, (long)self.version];
    }else{
        url = [NSString stringWithFormat:@"%@?ver=%ld", url, (long)self.version];
    }
    
    return url;
}
@end
