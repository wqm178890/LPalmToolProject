//
//  ListenNewsCtrl.m
//  SoundStock
//
//  Created by 林述灿 on 15/7/22.
//  Copyright (c) 2015年 Reader. All rights reserved.
//

#import "ListenNewsCtrl.h"

#import "TQTableView.h"
#import "ListenNewsCell.h"

#import "TQRequestLoadingView.h"

#import "ObjectDefine.h"
#import "UIScrollView+KS.h"
#import "ListenNewsDetailCtrl.h"

#import "ListenNewsView.h"

#import "WKPageView.h"

#import "NewsMangerCtrl.h"
#import "TQAppManger.h"
#import "NewsManger.h"

@interface ListenNewsCtrl () <WKPageViewDataSource,WKPageViewDelegate>
{
    
}

@property(nonatomic, retain) NSArray* newsList;
@property(nonatomic, assign) NSInteger currentIndex;
@end

@implementation ListenNewsCtrl
@synthesize newsList;
@synthesize currentIndex;

- (id)init{
    self = [super init];
    if (self) {
        self.currentIndex = 0;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self readNewsData];
    WKPageView *pageView = [[WKPageView alloc] initWithFrame:ClientSizeNavi];//self.view.bounds];
    pageView.dataSource = self;
    pageView.delegate = self;
    pageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:pageView];
//    self.pageView = pageView;
    
    UIImage* normalImg = [[TQSkinManger sharedManger] getNewsPlayBtnNormal];
    UIImage* pressImg = [[TQSkinManger sharedManger] getNewsPlayBtnPress];
    UIButton* playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [playBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [playBtn setBackgroundImage:pressImg forState:UIControlStateHighlighted];
    [playBtn addTarget:self action:@selector(playClick) forControlEvents:UIControlEventTouchUpInside];
    playBtn.frame = CGRectMake(CGRectGetWidth(ClientSizeNavi) - normalImg.size.width, CGRectGetHeight(ClientSizeNavi)- normalImg.size.height, normalImg.size.width, normalImg.size.height);
    [self.view addSubview:playBtn];
}

- (void)playClick{
    if (![NewsManger shareManger].newsCtrl) {
        [NewsManger shareManger].newsCtrl = [[[NewsMangerCtrl alloc] init] autorelease];
    }
    
    [[TQAppManger sharedManger].mainNavigateCtrl pushViewController:[NewsManger shareManger].newsCtrl animated:YES];
}


- (void)readNewsData{
    NSMutableArray* list = [[NSMutableArray alloc] init];
    NSString* filePath = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath], @"NewsList.plist"];
    NSArray* array = [NSArray arrayWithContentsOfFile:filePath];
    for (NSDictionary* dic in array) {
        NewsId* newsId = [[NewsId alloc] init];
        newsId.CategoryId = ((NSNumber*)[dic objectForKey:@"CategoryId"]).integerValue;
        newsId.CategoryOrder = ((NSNumber*)[dic objectForKey:@"CategoryOrder"]).integerValue;
        newsId.CategoryName = [dic objectForKey:@"CategoryName"];
        [list addObject:newsId];
        [newsId release];
    }
    
    self.newsList = list;
    [list release];
}

- (void)dealloc{
    self.newsList = nil;
    
    [super dealloc];
}


#pragma mark - page view datasource
// Menu的标题用NSArray封装，内为NSString
- (NSArray *)menuItemsForMenuViewInPageView:(WKPageView *)pageView{
    NSMutableArray* titles = [[[NSMutableArray alloc] init] autorelease];
    for (NewsId* news in self.newsList) {
        [titles addObject:news.CategoryName];
    }
    
    return titles;
}

- (WKPageCell *)pageView:(WKPageView *)pageView cellForIndex:(NSInteger)index{
    NSString *identifier = [NSString stringWithFormat:@"%@_%zd", @"pageCell", index];
    ListenNewsView *cell = [pageView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ListenNewsView alloc] initWithIdentifier:identifier];
        cell.backgroundColor = [UIColor whiteColor];
        NewsId* newsId = [self.newsList objectAtIndex:index];
        [cell loadRequestById:[NSString stringWithFormat:@"%zd", newsId.CategoryId]];
    }
    self.currentIndex = index;
    
    return cell;
}

- (UIColor *)randomColor{
    CGFloat r = arc4random_uniform(255);
    CGFloat g = arc4random_uniform(255);
    CGFloat b = arc4random_uniform(255);
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}
#pragma mark Page view delegate
// 若不实现，默认红黑，为保证字体颜色渐变，请尽量选用RGBA来创建UIColor
- (UIColor *)titleColorOfMenuItemInPageView:(WKPageView *)pageView withState:(WKMenuItemTitleColorState)state{
    if (state == WKMenuItemTitleColorStateNormal) {
        return [UIColor greenColor];
    }else{
        return [UIColor blueColor];
    }
}
// 若不实现,默认为30
- (CGFloat)pageView:(WKPageView *)pageView heightForMenuView:(WKMenuView *)menuView{
    return 30;
}
// 若不实现，默认为15/18
- (CGFloat)titleSizeOfMenuItemInPageView:(WKPageView *)pageView withState:(WKMenuItemTitleSizeState)state{
    switch (state) {
        case WKMenuItemTitleSizeStateNormal:
            return 15;
            break;
        case WKMenuItemTitleSizeStateSelected:
            return 18;
        default:
            break;
    }
}
// 若不实现，默认为灰色
- (UIColor *)backgroundColorOfMenuViewInPageView:(WKPageView *)pageView{
    return [UIColor lightGrayColor];
}
// MenuView内部各个item的宽度，若标题过长可自行设置，默认为60
- (CGFloat)pageView:(WKPageView *)pageView widthForMenuItemAtIndex:(NSInteger)index{
    return 60;
}

@end
