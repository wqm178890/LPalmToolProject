//
//  BaseWebView.m
//  WebDemo
//
//  Created by CD on 14-4-17.
//  Copyright (c) 2014年 CD. All rights reserved.
//

#import "NJKWebView.h"
#import "BaseURLRequest.h"
#import "WebJavascriptBridgeFun.h"
#import "BaseWebURLCache.h"

@implementation WebSegmentItem

@synthesize segmentAction;
@synthesize segmentId;
@synthesize segmentStyle;
@synthesize segmentTitle;

@end

@interface NJKWebView()

@end
@implementation NJKWebView
@synthesize nav;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    _bFirst = YES;
    self.delegate = self;
    

    return self;
}

- (void)openUrl:(NSString *)url{
    [NSURLProtocol registerClass:[BaseURLProtocol class]];
    
//    BaseURLRequest* request = [BaseURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    [self loadRequest:request];
}


//
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    NSLog(@"%@", request);
    if (UIWebViewNavigationTypeOther == navigationType ) {
//        
//        if (!_bFirst) {
//            NSString* url = [[request URL] absoluteString];
//            
//            TestViewController * ctl = [[TestViewController alloc] initWithNibName:nil bundle:nil url:url];
//            AppDelegate* del = (AppDelegate*)[UIApplication sharedApplication].delegate;
//            [del pushViewController:ctl];
//            return NO;
//        }
//        else{
//             _bFirst = NO;
//        }
    }
   
    JSContext* context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"ulJsInt"] = [WebJavascriptBridgeFun shareWebManger];
    
    return  YES;
}

//- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    JSContext* context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    context[@"ulJsInt"] = [WebJavascriptBridgeFun shareWebManger];
//}

@end
