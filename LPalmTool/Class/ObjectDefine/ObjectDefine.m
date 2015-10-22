//
//  ObjectDefine.m
//  LPalmNews
//
//  Created by 林述灿 on 15/8/5.
//  Copyright (c) 2015年 LSC. All rights reserved.
//

#import "ObjectDefine.h"

@implementation PageInfoItem
@synthesize pageindex,pagenumber,pagetotal;
@end

@implementation NewsInfoItem

@synthesize newsContent,newsId,title,author,sourceSite,fromSite,imgUrl,sourceUrl,categoryId,channelName,createTime,newsText;

- (void)dealloc{
    self.newsText = nil;
    self.newsContent = nil;
    self.title = nil;
    self.sourceUrl = nil;
    self.author = nil;
    self.fromSite = nil;
    self.imgUrl = nil;
    self.channelName = nil;
    self.createTime = nil;
    
    [super dealloc];
}

@end

@implementation NewsId

@synthesize CategoryId,CategoryName,CategoryOrder;

- (void)dealloc{
    self.CategoryName = nil;
    [super dealloc];
}
@end


@implementation weixinInfo

@synthesize weixinId,title,source,firstImg,mark,url;

-(void)dealloc{
    weixinId = nil;
    title = nil;
    source = nil;
    firstImg = nil;
    mark = nil;
    url = nil;
    [super dealloc];
}

@end