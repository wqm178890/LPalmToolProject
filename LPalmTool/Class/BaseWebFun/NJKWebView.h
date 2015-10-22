//
//  BaseWebView.h
//  WebDemo
//
//  Created by CD on 14-4-17.
//  Copyright (c) 2014年 CD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebSegmentItem : NSObject

@property(nonatomic, assign) NSInteger segmentId;
@property(nonatomic, retain) NSString* segmentTitle;
@property(nonatomic, retain) NSString* segmentAction;
@property(nonatomic, assign) NSInteger segmentStyle;

@end

@interface NJKWebView : UIWebView<UIWebViewDelegate>
{
    BOOL _bFirst;
}

@property(nonatomic, retain) UINavigationController* nav;


- (void)openUrl:(NSString *)url;
@end
