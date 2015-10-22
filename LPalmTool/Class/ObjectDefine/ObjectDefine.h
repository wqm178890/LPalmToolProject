//
//  ObjectDefine.h
//  LPalmNews
//
//  Created by 林述灿 on 15/8/5.
//  Copyright (c) 2015年 LSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PageInfoItem : NSObject
@property(nonatomic, assign) NSInteger pagetotal;
@property(nonatomic, assign) NSInteger pagenumber;
@property(nonatomic, assign) NSInteger pageindex;
@end

@interface NewsInfoItem : NSObject
@property(nonatomic, assign) NSInteger newsId;
@property(nonatomic, assign) NSInteger sourceSite;
@property(nonatomic, assign) NSInteger categoryId;
@property(nonatomic, retain) NSString* title;
@property(nonatomic, retain) NSString* author;
@property(nonatomic, retain) NSString* createTime;
@property(nonatomic, retain) NSString* fromSite;
@property(nonatomic, retain) NSString* imgUrl;
@property(nonatomic, retain) NSString* sourceUrl;
@property(nonatomic, retain) NSString* newsText;
@property(nonatomic, retain) NSString* newsContent;
@property(nonatomic, retain) NSString* channelName;
@end

@interface NewsId : NSObject
@property(nonatomic, assign) NSInteger CategoryId;
@property(nonatomic, assign) NSInteger CategoryOrder;
@property(nonatomic, retain) NSString* CategoryName;
@end

@interface  weixinInfo:NSObject
@property(nonatomic, retain) NSString* weixinId;
@property(nonatomic, retain) NSString* title;
@property(nonatomic, retain) NSString* source;
@property(nonatomic, retain) NSString* firstImg;
@property(nonatomic, retain) NSString* mark;
@property(nonatomic, retain) NSString* url;
@end