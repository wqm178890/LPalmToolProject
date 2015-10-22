//
//  WebJavascriptBridgeFun.h
//  ChangDu
//
//  Created by Reader on 15/5/26.
//
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol WebJavascriptBridgeFunProtocol <JSExport>

JSExportAs(loadUrlNewWindow, -(void)loadUrlNewWindow:(NSString*)sUrl sTitle:(NSString*)sTitle sCanShelf:(NSString*)sCanShelf sCanwebBack:(NSString*)sCanwebBack topBar:(NSString*)topBar bottomBar:(NSString*)bottomBar);
JSExportAs(jumLinkWithFunc, - (void)jumLinkWithFunc:(NSString*)sUrl sTitle:(NSString*)sTitle sCanShelf:(NSString*)sCanShelf sCanwebBack:(NSString*)sCanwebBack topBar:(NSString*)topBar bottomBar:(NSString*)bottomBar start:(NSString*)start stop:(NSString*)stop stop2:(NSString*)stop2);

JSExportAs(readbook, -(void)readbook:(NSString*)siteid bookId:(NSString*)bookid chapterId:(NSString*)chapterid);
JSExportAs(dowloadBook, - (void)dowloadBook:(NSString*)siteid bookId:(NSString*)bookid beginChapterId:(NSString*)beginid);
JSExportAs(toMenu, - (void)toMenu:(NSString*)siteid bookId:(NSString*)bookid paging:(NSString*)paging pageSize:(NSString*)pagesize canShelf:(NSString*)canshelf);
JSExportAs(addtoshelf, - (void)addtoshelf:(NSString*)siteId bookId:(NSString*)bookId);
JSExportAs(removebookfromshelf, - (void)removebookfromshelf:(NSString*)siteId bookId:(NSString*)bookId);
JSExportAs(loadBookInfo, - (void)loadBookInfo:(NSString*)siteId bookId:(NSString*)bookId sStaus:(NSString*)sSts);

JSExportAs(getdata, - (NSString*)getdata:(NSString*)key);
JSExportAs(removedata, - (BOOL)removedata:(NSString*)key);
JSExportAs(storedata,- (BOOL)storedata:(NSString*)key value:(NSString*)value expireTime:(NSString*)expireTime);

JSExportAs(showMsg, - (void)showMsg:(NSString*)title msg:(NSString*)msg callBack:(NSString*)callBack);
JSExportAs(showWMsg, - (void)showWMsg:(NSString*)title msg:(NSString*)msg callBack:(NSString*)callBack);
JSExportAs(showEMsg, - (void)showEMsg:(NSString*)title msg:(NSString*)msg callBack:(NSString*)callBack);

JSExportAs(showToast, - (void)showToast:(NSString*)msg length:(NSString*)length);
JSExportAs(confirm, - (void)confirm:(NSString*)title msg:(NSString*)msg callBack:(NSString*)callBack confirmBtn:(NSString*)confirmBtn cancelBtn:(NSString*)cnacelBtn);

JSExportAs(getdatafromserver, - (NSString*)getdatafromserver:(NSString*)url postData:(NSString*)postData isEncrypt:(NSString*)isEncrypt encoding:(NSString*)encoding httpMethod:(NSString*)httpMethod);

- (void)openShelf:(NSString*)idx;
- (void)showLoading:(NSString*)mgs;
- (void)hideLoading;
- (void)clearCache:(NSString*)url;
-(NSString*)getDeviceInfo;
- (void)init:(NSString*)books shelfBook:(NSString*)book;
@end

@class NJKWebView;
@interface WebJavascriptBridgeFun : NSObject<WebJavascriptBridgeFunProtocol>
//@property(nonatomic, retain) CyFloatWebPage *currentWebView;
@property(nonatomic, retain) JSContext* jsContext;

+(WebJavascriptBridgeFun*)shareWebManger;
- (BOOL)removedata:(NSString*)key;
- (NSString*)getdata:(NSString*)key;
- (BOOL)storedata:(NSString*)key value:(NSString*)value expireTime:(NSString*)expireTime;

@end
