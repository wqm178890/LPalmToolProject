//
//  LinstenNewsView.m
//  LPalmNews
//
//  Created by 林述灿 on 15/8/13.
//  Copyright (c) 2015年 LSC. All rights reserved.
//

#import "ListenNewsView.h"

#import "TQRequestLoadingView.h"

#import "ObjectDefine.h"
#import "UIScrollView+KS.h"
#import "TQTableView.h"
#import "ListenNewsCell.h"
#import "ListenNewsDetailCtrl.h"

#import "TQAppManger.h"

@interface ListenNewsView ()<UITableViewDataSource, UITableViewDelegate,KSRefreshViewDelegate>
{
    TQRequestLoadingView* m_loadingView;
    TQTableView* m_tableView;
    NSMutableArray* m_newsArray;
    
}
@property(nonatomic, retain) PageInfoItem* pageInfo;
@property(nonatomic, retain) NSString* pageCateogryId;
@end

@implementation ListenNewsView
@synthesize pageInfo;
@synthesize pageCateogryId;

- (id)initWithIdentifier:(NSString *)identifier{
    self = [super initWithIdentifier:identifier];
    if (self) {
        m_newsArray = [[NSMutableArray alloc] init];
        self.pageInfo = [[PageInfoItem alloc] init];
    }
    
    return self;
}


- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
//    [self adjustView];
}

//- (void)adjustView{
//    if (m_loadingView) {
//        m_loadingView.frame = self.bounds;
//    }
//    CGRect rc = self.bounds;
//    if (m_tableView) {
//        m_tableView.frame = self.bounds;
//        m_tableView.footer.frame = self.bounds;
//    }
//}

- (void)setUp:(CGRect)frame{
    if (!m_tableView) {
        m_tableView = [[TQTableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        m_tableView.delegate = self;
        m_tableView.dataSource = self;
        m_tableView.footer = [[[KSDefaultFootRefreshView alloc] initWithDelegate:self] autorelease];
        //      [m_tableView setEmptySeparator];
        [self addSubview:m_tableView];
        [m_tableView release];
        
        if (!m_loadingView) {
            m_loadingView = [[TQRequestLoadingView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
            [self addSubview:m_loadingView];
            [m_loadingView release];
        }
    }
}

- (void)loadRequestById:(NSString*)cateogryId{
    self.pageCateogryId = cateogryId;
    
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    [dic setObject:@"GetNewsList" forKey:@"action"];
    [dic setObject:@"1" forKey:@"pageIndex"];
    [dic setObject:@"20" forKey:@"pageCount"];
    [dic setObject:@"3" forKey:@"SourceSite"];
    [dic setObject:cateogryId forKey:@"CategoryId"];
    
//    NSString* parame = @"action=GetNewsList&pageIndex=1&pageCount=20&ChannelName=同花顺头条&SourceSite=1&sec=news*+";
//    
//    NSString* sec = getStringFormMD5(parame);
//    [dic setObject:sec forKey:@"sec"];
    //arc 使用
    //    __weak __typeof(self)weakSelf = self;
    
    //非arc
//    __block typeof(self) weakSelf = self;
    //    [[AFHTTPSessionManager manager].requestSerializer willChangeValueForKey:@"timeoutInterval"];
    //    [AFHTTPSessionManager manager].requestSerializer.timeoutInterval = 5.0f;
    //    [[AFHTTPSessionManager manager].requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
//    [[AFHTTPSessionManager manager] GET:@"http://rmb0595.gotoip3.com/service/Api.ashx" parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        //         __strong __typeof(weakSelf)strongSelf = weakSelf;
        //        [strongSelf createNewsView];
//        [weakSelf parse:responseObject];
//        [weakSelf loadNews];
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"network error");
//    }];
}

- (void)parse:(id)data{
    //    NSDictionary* json = [NSJSONSerialization
    //                          JSONObjectWithData:data
    //                          options:NSJSONReadingAllowFragments
    //                          error:nil];
    
    NSDictionary* json = (NSDictionary*)data;
    NSDictionary* dataDic = [json objectForKey:@"data"];
    NSDictionary* pageDic = [dataDic objectForKey:@"pageinfo"];
    self.pageInfo.pageindex = ((NSDecimalNumber*)[pageDic objectForKey:@"pageindex"]).integerValue;
    self.pageInfo.pagenumber = ((NSDecimalNumber*)[pageDic objectForKey:@"pagenumber"]).integerValue;
    self.pageInfo.pagetotal = ((NSDecimalNumber*)[pageDic objectForKey:@"pagetotal"]).integerValue;
    
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
        [m_newsArray addObject:info];
        [info release];
    }
}
- (void)loadNews{
    if (m_loadingView && m_loadingView.superview){
        [m_loadingView removeFromSuperview];
        m_loadingView = nil;
    }

    [m_tableView reloadData];
}

- (void)refreshViewDidLoading:(id)view
{
    if ([view isEqual:m_tableView.header]) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //            [self.dataSource removeAllObjects];
            //            [self addData];
            
            //            if (self.tableView.footer) {
            //                if (self.dataSource.count >= 30) {
            //                    self.tableView.footer.isLastPage = YES;
            //                } else {
            //                    self.tableView.footer.isLastPage = NO;
            //                }
            //            }
            //
            //            [self.tableView reloadData];
            //            [self.tableView.header setState:RefreshViewStateDefault];
            //            [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        });
        
        return;
    }
    
    if ([view isEqual:m_tableView.footer]) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //            if (self.dataSource.count >= 30) {
            //
            //                [m_tableView.footer setIsLastPage:YES];
            //                [self.tableView reloadData];
            //            } else {
            //                [self addData];
            //                [self.tableView.footer setState:RefreshViewStateDefault];
            //                [self.tableView reloadData];
            //            }
            if (self.pageInfo.pageindex < self.pageInfo.pagenumber) {
                [self requestNextNewsDada];
            }else{
                [m_tableView.footer setIsLastPage:YES];
            }
        });
    }
}

- (void)requestNextNewsDada{
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    [dic setObject:@"GetNewsList" forKey:@"action"];
    [dic setObject:[NSString stringWithFormat:@"%zd", self.pageInfo.pageindex + 1] forKey:@"pageIndex"];
    [dic setObject:@"20" forKey:@"pageCount"];
    [dic setObject:@"3" forKey:@"SourceSite"];
    [dic setObject:self.pageCateogryId forKey:@"CategoryId"];
    //arc 使用
    //    __weak __typeof(self)weakSelf = self;
    
    //非arc
//    __block typeof(self) weakSelf = self;
//    [[AFHTTPSessionManager manager] GET:@"http://rmb0595.gotoip3.com/service/Api.ashx" parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        //         __strong __typeof(weakSelf)strongSelf = weakSelf;
        //        [strongSelf createNewsView];
//        [weakSelf updateView:responseObject];
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"network error");
//    }];
}

- (void)updateView:(id)responseData{
    [self parse:responseData];
    [m_tableView.footer setState:RefreshViewStateDefault];
    [m_tableView reloadData];
}

- (NSInteger)numberOfSections;
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ListenNewsCell getCellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return m_newsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListenNewsCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ListenNewsCell"];
    if (!cell) {
        cell = [[ListenNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ListenNewsCell"];
    }
    
    NewsInfoItem* info = [m_newsArray objectAtIndex:indexPath.row];
    [cell updateCellData:info];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsInfoItem* info = [m_newsArray objectAtIndex:indexPath.row];
    ListenNewsDetailCtrl* ctrl = [[ListenNewsDetailCtrl alloc] init];
    //    ctrl.title = info.title;
    [ctrl openUrl:[NSString stringWithFormat:@"http://rmb0595.gotoip3.com/service/News/ArticleDetail.aspx?id=%zd",info.newsId]];
    ctrl.hidesBottomBarWhenPushed = YES;
    ctrl.navigationController.navigationBarHidden = YES;
    [[TQAppManger sharedManger].mainNavigateCtrl pushViewController:ctrl animated:YES];
    [ctrl release];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
    //    return UITableViewCellEditingStyleInsert;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"commitEditingStyle");
    [m_newsArray removeObjectAtIndex:indexPath.row];
    [m_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction* action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [m_newsArray removeObjectAtIndex:indexPath.row];
        [m_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }];
    
    UITableViewRowAction* action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"收藏" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
    }];
    
    return [NSArray arrayWithObjects:action1, action2, nil];
}

- (void)dealloc{
    self.pageInfo = nil;
    if (m_newsArray) {
        [m_newsArray release];
        m_newsArray = nil;
    }
    
    [super dealloc];
}


@end
