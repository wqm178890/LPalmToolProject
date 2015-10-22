//
//  TQRequestLoadingView.m
//  LPalmNews
//
//  Created by 林述灿 on 15/8/4.
//  Copyright (c) 2015年 LSC. All rights reserved.
//

#import "TQRequestLoadingView.h"
#import "TQSkinManger.h"

@interface TQRequestLoadingView (){
    UIImageView* m_loadingView;
    UIImageView* m_logoView;
}

@end

@implementation TQRequestLoadingView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        [self initView];
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    CGRect rc = m_loadingView.bounds;
    m_loadingView.frame = CGRectMake((CGRectGetWidth(self.bounds) - CGRectGetWidth(rc))/2, (CGRectGetHeight(self.bounds) - CGRectGetHeight(rc))/2, CGRectGetWidth(rc), CGRectGetHeight(rc));
    
    CGRect logoRc = m_logoView.bounds;
    m_logoView.frame = CGRectMake((CGRectGetWidth(rc) - CGRectGetWidth(logoRc))/2, (CGRectGetHeight(rc) - CGRectGetHeight(logoRc))/2, CGRectGetWidth(logoRc), CGRectGetHeight(logoRc));
}

- (void)initView{
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:28];
    for (NSInteger i = 1; i <= 26; i++) {
//        UIImage* img = [UIImage imageNamed:[NSString stringWithFormat:@"%@loading/loading_blue%zd.png", [TQSkinManger getAppResourcePath] , i]];
        UIImage* img = [UIImage imageNamed:[NSString stringWithFormat:@"%@loading/loading%zd.png", [TQSkinManger getAppResourcePath] , i]];
        [array addObject:img];
    }
    
//    CGSize size = CGSizeMake(110/2, 110/2);
    CGSize size = CGSizeMake(94/2, 94/2);
    CGRect rc = CGRectMake((CGRectGetWidth(self.bounds) - size.width)/2, (CGRectGetHeight(self.bounds) - size.height)/2, size.width, size.height);
    m_loadingView = [[UIImageView alloc] initWithFrame:rc];
    m_loadingView.animationImages = array;
    m_loadingView.animationDuration = 2;
    [m_loadingView startAnimating];
    [self addSubview:m_loadingView];
    [m_loadingView release];
    
    UIImage* logoImg = [UIImage imageNamed:[NSString stringWithFormat:@"%@loading/loadinglogo.png", [TQSkinManger getAppResourcePath]]];
    size = logoImg.size;
    m_logoView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(m_loadingView.bounds) - size.width)/2, (CGRectGetHeight(m_loadingView.bounds) - size.height)/2, size.width, size.height)];
    m_logoView.image = logoImg;
    [m_loadingView addSubview:m_logoView];
    [m_logoView release];
}

@end
