//
//  ListenNewsDetailCtrl.m
//  LPalmNews
//
//  Created by 林述灿 on 15/8/12.
//  Copyright (c) 2015年 LSC. All rights reserved.
//

#import "ListenNewsDetailCtrl.h"
#import "TQWebView.h"
#import "NJKWebView.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface ListenNewsDetailCtrl ()<NJKWebViewProgressDelegate,UIWebViewDelegate>
{
    NJKWebView* m_webView;
    NJKWebViewProgress* m_progressProxy;
    NJKWebViewProgressView* m_progressView;
}
@end

@implementation ListenNewsDetailCtrl

- (id)init{
    self = [super init];
    if (self) {
        
        m_webView = [[NJKWebView alloc] initWithFrame:ClientSizeNavi];
        [self.view addSubview:m_webView];
        m_webView.backgroundColor = [UIColor clearColor];
        [m_webView release];
        
        m_progressProxy = [[NJKWebViewProgress alloc] init];
        m_webView.delegate = m_progressProxy;
        m_progressProxy.webViewProxyDelegate = self;
        m_progressProxy.progressDelegate = self;
        
        CGFloat progressBarHeight = 1.5f;
        CGRect navigaitonBarBounds = CGRectMake(0, StatusBarHeight, ScreenWidth, NAVIGATION_TOP_HEIGHT);
        CGRect barFrame = CGRectMake(0, 0, navigaitonBarBounds.size.width, progressBarHeight);
        m_progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
        [self.view addSubview:m_progressView];
        [m_progressView release];
    }

    return self;
}

- (void)openUrl:(NSString*)url{
    if (m_webView) {
        [m_webView openUrl:url];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [super.navigationController setNavigationBarHidden:YES animated:NO];
//    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [super.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [m_progressView setProgress:progress animated:YES];
}

- (void)setTitle:(NSString *)title{
    [super setTitle:title];
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
//    if (!self.refreshControl) {
//        self.refreshControl = [[RefreshControl alloc] initInScrollView:_webView.scrollView];
//        [self.refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
//    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    CGRect ff = _webView.frame;
//    m_errorWebView = [[WebErrorView alloc] initWithFrame:ff];
//    m_errorWebView.errorDelegate = self;
//    [_bgView addSubview:m_errorWebView];
//    [m_errorWebView release];
}

@end
