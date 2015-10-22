//
//  WebJavascriptBridgeFun.m
//  ChangDu
//
//  Created by Reader on 15/5/26.
//
//

#import "WebJavascriptBridgeFun.h"
#import "UMengOnlineParameterManger.h"
#import "WebLoadingView.h"

const static NSInteger CY_MAXSQL = 8192;

@interface WebJavascriptBridgeFun ()
@property(nonatomic, retain) NSString* webCallBack;
@end


@implementation WebJavascriptBridgeFun
//@synthesize currentWebView;
@synthesize jsContext;
@synthesize webCallBack;

+(WebJavascriptBridgeFun*)shareWebManger{
    static WebJavascriptBridgeFun* shareMange = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareMange = [[WebJavascriptBridgeFun alloc] init];
    });
    
    return shareMange;
}

- (id)init{
    self = [super init];
    if (self) {
        self.jsContext = nil;
        self.webCallBack = nil;
    }
    
    return self;
}

-(NSString*)getDeviceInfo{
    NSString* deviceId = nil;//[DeviceIdAdapter getDeviceID_Adapter];
    NSString* deviceName = nil;//getDeviceName();
    NSString* userId = [self getdata:@"MyUser"];
    if (!userId) {
        userId = @"";
    }
    NSString* showPic = @"0";//默认显示
//    if ([[PandaGlobalSettings Shared] GetEconomiclCapacityModle]) {
//        showPic = @"1";
//    }
    NSMutableDictionary* deviceDict = [[[NSMutableDictionary alloc] init] autorelease];
    [deviceDict setObject:deviceId forKey:@"DeviceId"];
    [deviceDict setObject:userId forKey:@"USER_ID"];
    [deviceDict setObject:deviceId forKey:@"IMEI"];
    [deviceDict setObject:deviceId forKey:@"MAC"];
    [deviceDict setObject:deviceId forKey:@"IMSI"];
    [deviceDict setObject:@"1" forKey:@"MT"];
    [deviceDict setObject:@"2" forKey:@"VER"];
    [deviceDict setObject:showPic forKey:@"IF_PICTURE"];
    [deviceDict setObject:deviceName forKey:@"DEV"];
    
    NSData* data = [NSJSONSerialization dataWithJSONObject:deviceDict options:NSJSONWritingPrettyPrinted error:nil];
    NSString* deviceInfo = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    
    return deviceInfo;
}

- (void)showMsg:(NSString*)title msg:(NSString*)msg callBack:(NSString*)callBack{
    self.webCallBack = callBack;
    
//    AlertViewManger *alertView = [[AlertViewManger alloc] initWithTitle:@""
//                                                                message:title
//                                                               delegate:self
//                                                      cancelButtonTitle:nil
//                                                      otherButtonTitles:msg, nil];
//    alertView.tag = 1;
//    [alertView show];
//    [alertView release];
}
- (void)showWMsg:(NSString*)title msg:(NSString*)msg callBack:(NSString*)callBack{
    self.webCallBack = callBack;
    
//    AlertViewManger *alertView = [[AlertViewManger alloc] initWithTitle:@""
//                                                                message:title
//                                                               delegate:self
//                                                      cancelButtonTitle:nil
//                                                      otherButtonTitles:msg, nil];
//    alertView.tag = 1;
//    [alertView show];
//    [alertView release];
}

- (void)showEMsg:(NSString*)title msg:(NSString*)msg callBack:(NSString*)callBack{
    self.webCallBack = callBack;
    
//    AlertViewManger *alertView = [[AlertViewManger alloc] initWithTitle:@""
//                                                                message:title
//                                                               delegate:self
//                                                      cancelButtonTitle:nil
//                                                      otherButtonTitles:msg, nil];
//    alertView.tag = 1;
//    [alertView show];
//    [alertView release];
}

- (void)showToast:(NSString*)msg length:(NSString*)length{
//    AlertViewManger *alertView = [[AlertViewManger alloc] initWithTitle:@""
//                                                                message:msg
//                                                               delegate:self
//                                                      cancelButtonTitle:nil
//                                                      otherButtonTitles:_(@"OK"), nil];
//    alertView.tag = 2;
//    [alertView show];
//    [alertView release];
}

- (void)confirm:(NSString*)title msg:(NSString*)msg callBack:(NSString*)callBack confirmBtn:(NSString*)confirmBtn cancelBtn:(NSString*)cnacelBtn{
    
//    self.webCallBack = callBack;
//    
//    AlertViewManger *alertView = [[AlertViewManger alloc] initWithTitle:@""
//                                                                message:title
//                                                               delegate:self
//                                                      cancelButtonTitle:cnacelBtn
//                                                      otherButtonTitles:confirmBtn, nil];
//    alertView.tag = 0;
//    [alertView show];
//    [alertView release];
}

- (void)alertView:(NSNumber *)viewTag clickedButtonAtIndex:(NSNumber*)buttonIndex
{
//    NSInteger tag = viewTag.integerValue;
//    NSInteger index = buttonIndex.integerValue;
//    if (tag == 0) {
//        if (index == 1) {
//            [self.jsContext evaluateScript:self.webCallBack];
//        }
//    }else if (tag == 1){
//        [self.jsContext evaluateScript:self.webCallBack];
//    }else{
//        
//    }
//    
//    self.webCallBack = nil;
}

- (void)openShelf:(NSString*)idx{
//    [self performSelectorOnMainThread:@selector(popToMainViewByIndex:) withObject:idx waitUntilDone:NO];
    
}

- (void)popToMainViewByIndex:(NSString*)idx
{
//    [[ReaderGUICtrl sharedGUICtrl].mainNaviCtrl popViewControllerAnimated:NO];
//    [ReaderSkinManage sharedData].bPushDirectoryFormReadingView = NO;
//    [[ReaderGUICtrl sharedGUICtrl] popReaderControllerbyAnimated:YES];
//    
//    [self performSelector:@selector(tranToStoreByIndex:) withObject:idx afterDelay:1.0f];
}

- (void)tranToStoreByIndex:(NSString*)idx
{
//    NSInteger index = idx.integerValue;
//    
//    [[ReaderGUICtrl sharedGUICtrl] setMainViewTabSelectedIndex:index];
}

- (void)showLoading:(NSString*)mgs{
//    [WebLoadingView showWebLoading];
}

- (void)hideLoading{
//    [WebLoadingView hiddenWebLoading];
}

//url为空 清除所有
- (void)clearCache:(NSString*)url{
    
//    if (url && url.length > 0) {
//        NSString* filePath = getWebFilePath(url);
//        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
//    }else{
//        NSString* dirPath = getWebCacheDir();
//        [[NSFileManager defaultManager] removeItemAtPath:dirPath error:nil];
//    }
}

- (NSString*)getdatafromserver:(NSString*)url postData:(NSString*)postData isEncrypt:(NSString*)isEncrypt encoding:(NSString*)encoding httpMethod:(NSString*)httpMethod{
//   
//    NSURL *c_url = [NSURL URLWithString:url];
//    NSMutableURLRequest *postRequest = [[NSMutableURLRequest alloc] initWithURL:c_url];
//    [postRequest setHTTPMethod:httpMethod];
//    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField: @"Content-Type"];
//    [postRequest setTimeoutInterval:2];
//    
////    if (para != nil)
////    {
////        NSString *postLength = [NSString stringWithFormat:@"%d", [para length]];
////        [postRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
////        [postRequest setHTTPBody:para];
////    }
//    
//    NSHTTPURLResponse* response = nil;
//    NSData *ret_data = nil;
//    NSInteger code = 0;
//    int index = 0;
//    while (index < 3)
//    {
//        ret_data= [NSURLConnection sendSynchronousRequest:postRequest returningResponse:&response error:nil];
//        code = [response statusCode];
//        if (code == 200)
//        {
//            break;		
//        }		
//        index++;		
//    }
//    
//    [postRequest release];
    
    NSString* result = nil;
//    if (ret_data) {
//        result = [[NSString alloc] initWithData:ret_data encoding:NSUTF8StringEncoding];
//    }
    
    return result;
}

- (void)addtoshelf:(NSString*)siteId bookId:(NSString*)bookId{
    NSLog(@"=======================");
}

- (void)removebookfromshelf:(NSString*)siteId bookId:(NSString*)bookId{
    NSLog(@"=======================");
}


- (void)loadBookInfo:(NSString*)siteId bookId:(NSString*)bookId sStaus:(NSString*)sSts{
    NSLog(@"=======================");
    
}


-(void)loadUrlNewWindow:(NSString*)sUrl sTitle:(NSString*)sTitle sCanShelf:(NSString*)sCanShelf sCanwebBack:(NSString*)sCanwebBack topBar:(NSString*)topBar bottomBar:(NSString*)bottomBar{

//    if (topBar && [topBar isEqualToString:@"undefined"]) {
//        topBar = nil;
//    }
//    
//    NJKWebPageCtrl* vc = [[NJKWebPageCtrl alloc] initWebViewAndTabBarWithFrame:ClientSizeNavi hiddenTabBar:YES];
//    vc.title = sTitle;
//    [[ReaderGUICtrl sharedGUICtrl].mainNaviCtrl pushViewController:vc animated:YES];
//    [vc release];
//    
//    if (topBar && topBar.length > 0) {
//        NSError* error;
//        NSMutableArray* buttons = [[NSMutableArray alloc] init];
//        
//        NSDictionary* json = [NSJSONSerialization
//                              JSONObjectWithData:[topBar dataUsingEncoding:NSUTF8StringEncoding]
//                              options:NSJSONReadingAllowFragments
//                              error:&error];
//        NSArray* arr = [json objectForKey:@"buttons"];
//        for (NSInteger i = 0; i < arr.count; i++) {
//            WebSegmentItem* item = [[WebSegmentItem alloc] init];
//            
//            NSDictionary* dic = [arr objectAtIndex:i];
//            item.segmentId = ((NSDecimalNumber*)[dic objectForKey:@"id"]).intValue;
//            item.segmentStyle = ((NSDecimalNumber*)[dic objectForKey:@"style"]).intValue;
//            item.segmentTitle = [dic objectForKey:@"title"];
//            item.segmentAction = [dic objectForKey:@"action"];
//            [buttons addObject:item];
//            [item release];
//        }
//        
//        [vc createSegmentCtrlWithItems:buttons];
//        [buttons release];
//        
//    }else{
//        [vc openUrl:sUrl];
//    }
}

- (void)jumLinkWithFunc:(NSString*)sUrl sTitle:(NSString*)sTitle sCanShelf:(NSString*)sCanShelf sCanwebBack:(NSString*)sCanwebBack topBar:(NSString*)topBar bottomBar:(NSString*)bottomBar start:(NSString*)start stop:(NSString*)stop stop2:(NSString*)stop2{
    
//    NJKWebPageCtrl* vc = [[NJKWebPageCtrl alloc] initWebViewAndTabBarWithFrame:ClientSizeNavi hiddenTabBar:YES];
//    vc.title = sTitle;
//    [[ReaderGUICtrl sharedGUICtrl].mainNaviCtrl pushViewController:vc animated:YES];
//    [vc release];
//    
//    if (topBar && topBar.length > 0) {
//        NSError* error;
//        NSMutableArray* buttons = [[NSMutableArray alloc] init];
//        
//        NSDictionary* json = [NSJSONSerialization
//                              JSONObjectWithData:[topBar dataUsingEncoding:NSUTF8StringEncoding]
//                              options:NSJSONReadingAllowFragments
//                              error:&error];
//        NSArray* arr = [json objectForKey:@"buttons"];
//        for (NSInteger i = 0; i < arr.count; i++) {
//            WebSegmentItem* item = [[WebSegmentItem alloc] init];
//            
//            NSDictionary* dic = [arr objectAtIndex:i];
//            item.segmentId = ((NSDecimalNumber*)[dic objectForKey:@"id"]).intValue;
//            item.segmentStyle = ((NSDecimalNumber*)[dic objectForKey:@"style"]).intValue;
//            item.segmentTitle = [dic objectForKey:@"title"];
//            item.segmentAction = [dic objectForKey:@"action"];
//            [buttons addObject:item];
//            [item release];
//        }
//        
//        [vc createSegmentCtrlWithItems:buttons];
//        [buttons release];
//        
//    }else{
//        [vc openUrl:sUrl];
//    }
}

- (void)dowloadBook:(NSString*)siteid bookId:(NSString*)bookid beginChapterId:(NSString*)beginid{
//    NSString* readUrl = [NSString stringWithFormat:@"%@(%@,%@)", CD_BOOKALLSAVE, siteid, bookid];
//    [self performSelector:@selector(bookAction:) withObject:readUrl afterDelay:0.1f];
}

- (void)toMenu:(NSString*)siteid bookId:(NSString*)bookid paging:(NSString*)paging pageSize:(NSString*)pagesize canShelf:(NSString*)canshelf{
//     NSString* readUrl = [NSString stringWithFormat:@"%@(%@,%@)", CD_BOOKREADDIR, siteid, bookid];
//    [self performSelector:@selector(bookAction:) withObject:readUrl afterDelay:0.1f];
}


-(void)readbook:(NSString*)siteid bookId:(NSString*)bookid chapterId:(NSString*)chapterid{

//    NSString* readUrl = [NSString stringWithFormat:@"%@(%@,%@,%@,%@,%@,%@)", CD_BOOKREADCHAPTER, siteid, bookid, chapterid, chapterid, @"", @""];
//    [self performSelector:@selector(bookAction:) withObject:readUrl afterDelay:0.1f];
}

- (void)bookAction:(NSString*)url{
//    [[PriatedBookMange shareMange] performSelectorOnMainThread:@selector(cdBookAction:) withObject:url waitUntilDone:YES];
}

- (BOOL)removedata:(NSString*)key{
    
//    NSString *dbPath = [NSString stringWithFormat:@"%@%s",[[ReaderGUICtrl sharedGUICtrl] getPreferencePath],WEB_DATA_DB];
//    NSString* tableName = @"WebStoreData";
//    TQSQLite *db = new TQSQLite((char *)[dbPath UTF8String]);
//    if (db != NULL)
//    {
//        char buf[CY_MAXSQL];
//        memset(buf, 0, CY_MAXSQL);
//        sprintf(buf, "create table if not exists %s (ID integer primary key autoincrement, webKey text, webValue text, webExpireTime text)", [tableName UTF8String]);
//        int res = db->exec(buf);
//        
//        sprintf(buf, "delete from %s where webKey = '%s'", [tableName UTF8String], [key UTF8String]);
//        res = db->query(buf);
//        
//        delete db;
//    }

    return YES;
}

- (NSString*)getdata:(NSString*)key{

    NSString* getDataValue = nil;
    
//    NSString *dbPath = [NSString stringWithFormat:@"%@%s",[[ReaderGUICtrl sharedGUICtrl] getPreferencePath], WEB_DATA_DB];
//    NSString* tableName = @"WebStoreData";
//    
//    TQSQLite *db = new TQSQLite((char *)[dbPath UTF8String]);
//    if (db != NULL) {
//        char buf[CY_MAXSQL];
//        memset(buf, 0, CY_MAXSQL);
//        sprintf(buf, "create table if not exists %s (ID integer primary key autoincrement, webKey text, webValue text, webExpireTime text)", [tableName UTF8String]);
//        int res = db->exec(buf);
//        if (res >= 0) {
//            memset(buf, 0, CY_MAXSQL);
//            sprintf(buf, "select webValue,webExpireTime from %s where webKey = '%s' order by ID desc", [tableName UTF8String], [key UTF8String]);
//            int row = db->query(buf);
//            if (row > 0) {
//                NSString* webValue = db->queryData(0, 0) ? [NSString stringWithUTF8String:db->queryData(0, 0)] : @"";
//                NSString* webExpireTime = db->queryData(0, 0) ? [NSString stringWithUTF8String:db->queryData(0, 1)] : @"";
//                //判断时间是否过期
//                NSDateFormatter *dateformatter=[[[NSDateFormatter alloc] init] autorelease];
//                [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//                NSDate* expireTimeDate = [dateformatter dateFromString:webExpireTime];
//                NSTimeInterval expireTime = [[NSDate date] timeIntervalSinceDate:expireTimeDate];
//                if (expireTime < 0) {
//                    getDataValue = webValue;
//                }
//            }
//        }
//        
//        delete db;
//    }
    
    return getDataValue;
}

- (BOOL)storedata:(NSString*)key value:(NSString*)value expireTime:(NSString*)expireTime{
    
//    if ([expireTime isEqualToString:@"undefined"]) {
//        expireTime = nil;
//    }
//    
//    if (key && key.length > 0 && value && value.length > 0) {
//        
//        if(!expireTime || expireTime.length == 0){
//            NSDate * senddate=[NSDate distantFuture];
//            NSDateFormatter *dateformatter=[[[NSDateFormatter alloc] init] autorelease];
//            [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//            expireTime = [dateformatter stringFromDate:senddate];
//        }
//        
//        NSString *dbPath = [NSString stringWithFormat:@"%@%s",[[ReaderGUICtrl sharedGUICtrl] getPreferencePath],WEB_DATA_DB];
//        NSString* tableName = @"WebStoreData";
//        TQSQLite *db = new TQSQLite((char *)[dbPath UTF8String]);
//        if (db != NULL)
//        {
//            char buf[CY_MAXSQL];
//            memset(buf, 0, CY_MAXSQL);
//            sprintf(buf, "create table if not exists %s (ID integer primary key autoincrement, webKey text, webValue text, webExpireTime text)", [tableName UTF8String]);
//            int res = db->exec(buf);
//            
//            sprintf(buf, "delete from %s where webKey = '%s'", [tableName UTF8String], [key UTF8String]);
//            res = db->query(buf);
//    
//            sprintf(buf, "insert or replace into %s (webKey, webValue, webExpireTime)" "values ('%s','%s','%s')", [tableName UTF8String], [key UTF8String],[value UTF8String],[expireTime UTF8String]);
//            res = db->query(buf);
//            
//            delete db;
//        }
//        
//        return YES;
//    }
    
    return NO;
}

- (void)init:(NSString*)books shelfBook:(NSString*)book{
//    [[WebInitShelfManger shareManger] initBookShlef:books];
}

@end
