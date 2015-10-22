//
//  NewsMangerCtrl.m
//  LPalmNews
//
//  Created by 林述灿 on 15/9/29.
//  Copyright © 2015年 LSC. All rights reserved.
//

#import "NewsMangerCtrl.h"
#import "NewsManger.h"
#import "NetEngine/NDNetHttpTransfer.h"
#import "ObjectDefine.h"

@interface NewsMangerCtrl ()<NewsMangerDelegate>
{
    UITextView* _playTextView;
    UIButton* _playBtn;
    UIButton* _previousBtn;
    UIButton* _nextBtn;
    BOOL _bPlaying;
}
@property(nonatomic, retain) NSMutableArray* newsList;
@property(nonatomic, assign) NSInteger playIndex;

@end

@implementation NewsMangerCtrl
@synthesize newsList;
@synthesize playIndex;

- (id)init{
    self = [super init];
    if (self) {
        _bPlaying = NO;
        self.playIndex = 0;
        self.newsList = [NSMutableArray array];
        [NewsManger shareManger].delegate = self;
    }
    
    return self;
}

- (void)loadView{
    [super loadView];
    
    CGRect rc = ClientSizeNavi;
    
    UIImage* playBg = [[TQSkinManger sharedManger] getNewsPlayAudioNewsBg];
    CGSize playBgSize = playBg.size;
    playBgSize.height = (rc.size.width / playBgSize.width) * playBgSize.height;
    playBgSize.width = rc.size.width;
    
    UIImageView* playBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, rc.size.height - playBgSize.height, playBgSize.width, playBgSize.height)];
    playBgView.image = playBg;
    playBgView.userInteractionEnabled = YES;
    [self.view addSubview:playBgView];
    [playBgView release];
    
    UITextView* textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, rc.size.width, rc.size.height - playBgSize.height)];
    textView.backgroundColor = [UIColor whiteColor];
    textView.textColor = [UIColor blackColor];
    textView.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:textView];
    [textView release];
    _playTextView = textView;
    
    UIImage* playDisk = [[TQSkinManger sharedManger] getNewsPlayAudioDisk];
    UIImageView* playDiskView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(playBgView.bounds) - playDisk.size.width/2)/2, CGRectGetHeight(playBgView.bounds) - playDisk.size.height/2 - 10, playDisk.size.width/2, playDisk.size.height/2)];
    playDiskView.image = playDisk;
    [playBgView addSubview:playDiskView];
    [playDiskView release];
    
    UIImage* playDiskBlockImg = [[TQSkinManger sharedManger] getNewsPlayAudioBlockBg];
    UIImageView* playDiskBlockView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, playDiskBlockImg.size.width, playDiskBlockImg.size.height)];
    playDiskBlockView.image = playDiskBlockImg;
    [playBgView addSubview:playDiskBlockView];
    [playDiskBlockView release];
    playDiskBlockView.center = playDiskView.center;
    
    UIImage* playImg = [[TQSkinManger sharedManger] getNewsPlayAudioButton];
    UIButton* playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [playBtn setBackgroundImage:playImg forState:UIControlStateNormal];
    [playBgView addSubview:playBtn];
    [playBtn addTarget:self action:@selector(playClick) forControlEvents:UIControlEventTouchUpInside];
    playBtn.frame = CGRectMake((CGRectGetWidth(playDiskView.bounds) - playImg.size.width)/2, (CGRectGetHeight(playDiskView.bounds) - playImg.size.height)/2, playImg.size.width, playImg.size.height);
    playBtn.center = playDiskView.center;
    playBtn.enabled = NO;
    _playBtn = playBtn;
    
    UIImage* previousImg = [[TQSkinManger sharedManger] getNewsPlayAudioPrevious];
    UIImage* previousHightImg = [[TQSkinManger sharedManger] getNewsPlayAudioPreviousHight];
    UIButton* previousBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [previousBtn setBackgroundImage:previousImg forState:UIControlStateNormal];
    [previousBtn setBackgroundImage:previousHightImg forState:UIControlStateHighlighted];
    [playBgView addSubview:previousBtn];
    previousBtn.frame = CGRectMake((playDiskView.frame.origin.x - previousImg.size.width)/2, playBtn.frame.origin.y, playImg.size.width, playImg.size.height);
    [previousBtn addTarget:self action:@selector(previousClick) forControlEvents:UIControlEventTouchUpInside];
    previousBtn.enabled = NO;
    _previousBtn = previousBtn;
    
    UIImage* nextImg = [[TQSkinManger sharedManger] getNewsPlayAudioNext];
    UIImage* nextHightImg = [[TQSkinManger sharedManger] getNewsPlayAudioNextHight];
    UIButton* nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setBackgroundImage:nextImg forState:UIControlStateNormal];
    [nextBtn setBackgroundImage:nextHightImg forState:UIControlStateHighlighted];
    [playBgView addSubview:nextBtn];
    nextBtn.frame = CGRectMake(playDiskView.frame.origin.x + CGRectGetWidth(playDiskView.bounds) + (playDiskView.frame.origin.x - playImg.size.width)/2, playBtn.frame.origin.y, playImg.size.width, playImg.size.height);
    nextBtn.enabled = NO;
    [nextBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    _nextBtn = nextBtn;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!_bPlaying) {
        [self requestPlayList];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)playClick{
    _bPlaying = !_bPlaying;
    
    UIImage* playImg = [[TQSkinManger sharedManger] getNewsPlayAudioButton];
    if (_bPlaying) {
        playImg = [[TQSkinManger sharedManger] getNewsPlayAudioPause];
    }
    [_playBtn setBackgroundImage:playImg forState:UIControlStateNormal];

    if (_bPlaying) {
        [[NewsManger shareManger] resumeSpeak];
    }else{
        [[NewsManger shareManger] pauseSpeak];
    }
}

- (void)previousClick{
    if (self.playIndex > 0) {
        self.playIndex -= 1;
        [self playNews];
    }
}

- (void)nextClick{
    if (self.playIndex + 1 < self.newsList.count) {
        self.playIndex += 1;
        [self playNews];
    }
}

- (void)playNews{
//    [[NewsManger shareManger] stopSpeak];
    
    _bPlaying = YES;
    
    UIImage* playImg = [[TQSkinManger sharedManger] getNewsPlayAudioButton];
    if (_bPlaying) {
        playImg = [[TQSkinManger sharedManger] getNewsPlayAudioPause];
    }
    [_playBtn setBackgroundImage:playImg forState:UIControlStateNormal];

    if (self.newsList.count  > 0) {
        _playBtn.enabled = YES;
        NewsInfoItem* item = [self.newsList objectAtIndex:self.playIndex];
        if (item.newsText.length <= 0) {
            [self nextClick];
        }else{
            [[NewsManger shareManger] playNewsText:item.newsText];
            _playTextView.text = item.newsText;
        }
    }
    
    if (self.playIndex <=0 || self.newsList.count <= 1) {
        _previousBtn.enabled = NO;
    }else{
        _previousBtn.enabled = YES;
    }
    
    if (self.newsList.count >= 1 && self.playIndex < self.newsList.count) {
        _nextBtn.enabled = YES;
    }else{
        _nextBtn.enabled = NO;
    }
}

- (void)requestPlayList{
    
    NewsId* newsId = [[[NewsId alloc] init] autorelease];
    newsId.CategoryId = 1;
    
    //    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    //    [dic setObject:@"GetNewsList" forKey:@"action"];
    //    [dic setObject:[NSString stringWithFormat:@"%zd", 1] forKey:@"pageIndex"];
    //    [dic setObject:@"20" forKey:@"pageCount"];
    //    [dic setObject:@"3" forKey:@"SourceSite"];
    //    [dic setObject:[NSString stringWithFormat:@"%zd", newsId.CategoryId] forKey:@"CategoryId"];
    
    NSString* request = [NSString stringWithFormat:@"http://rmb0595.gotoip3.com/service/Api.ashx?action=GetNewsList&pageIndex=1&pageCount=20&SourceSite=3&CategoryId=%zd", newsId.CategoryId];
    [[NDNetHttpTransfer sharedTransfer] getData:request delegate:self];
    
    //    __block typeof(self) weakSelf = self;
    //    [[AFHTTPSessionManager manager] GET:@"http://rmb0595.gotoip3.com/service/Api.ashx" parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
    //        [weakSelf parse:responseObject];
    //        [weakSelf play];
    //    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    //        
    //    }];
}

- (void)parse:(id)data{
    [self.newsList removeAllObjects];
    NSDictionary* json = (NSDictionary*)data;
    NSDictionary* dataDic = [json objectForKey:@"data"];
    NSDictionary* pageDic = [dataDic objectForKey:@"pageinfo"];
    //    self.pageInfo.pageindex = ((NSDecimalNumber*)[pageDic objectForKey:@"pageindex"]).integerValue;
    //    self.pageInfo.pagenumber = ((NSDecimalNumber*)[pageDic objectForKey:@"pagenumber"]).integerValue;
    //    self.pageInfo.pagetotal = ((NSDecimalNumber*)[pageDic objectForKey:@"pagetotal"]).integerValue;
    
    NSArray* returnArr = [dataDic objectForKey:@"returndata"];
    for (NSDictionary* dic in returnArr) {
        NewsInfoItem* info = [[NewsInfoItem alloc] init];
        info.newsId = ((NSDecimalNumber*)[dic objectForKey:@"NewsId"]).integerValue;
        info.categoryId = ((NSDecimalNumber*)[dic objectForKey:@"CategoryId"]).integerValue;
        info.sourceSite = ((NSDecimalNumber*)[dic objectForKey:@"SourceSite"]).integerValue;
        info.author = [dic objectForKey:@"Author"];
        info.fromSite = [dic objectForKey:@"FromSite"];
        info.imgUrl = [dic objectForKey:@"ImgUrl"];
        info.newsText = [dic objectForKey:@"NewsText"];
        info.channelName = [dic objectForKey:@"ChannelName"];
        info.newsContent = [dic objectForKey:@"NewsContent"];
        info.sourceUrl = [dic objectForKey:@"SourceUrl"];
        info.createTime = [dic objectForKey:@"CreateTime"];
        info.title = [dic objectForKey:@"Title"];
        [self.newsList addObject:info];
        [info release];
    }
}

#pragma NewsMangerDelegate

- (void)newsPlayEnd{
    [self nextClick];
}

#pragma NDNetHttpTransfer

- (void)transferDidCancel:(NDNetHttpTransferIDRef)connection{
    NSLog(@"transferDidCancel");
}

- (void)transferDidFinishLoading:(NDNetHttpTransferIDRef)connection{
    NSData* data = (NSData*)[[NDNetHttpTransfer sharedTransfer] getConnectionData:connection];
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:NSJSONReadingAllowFragments
                          error:nil];
    
    [self parse:json];
    [self playNews];
}


- (void)transfer:(NDNetHttpTransferIDRef)connection didFailWithError:(NSError*)error{
    NSLog(@"didFailWithError");
}
@end
