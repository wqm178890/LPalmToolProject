//
//  ListenNewsCell.m
//  LPalmNews
//
//  Created by 林述灿 on 15/8/6.
//  Copyright (c) 2015年 LSC. All rights reserved.
//

#import "ListenNewsCell.h"
#import "TQSkinManger.h"

@interface ListenNewsCell()
{
    UIImageView* m_imageView;
    UILabel* m_titleLabel;
}
@property(nonatomic, retain)NewsInfoItem* newsInfo;
@end

@implementation ListenNewsCell
@synthesize newsInfo;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])) {
        
//        m_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 60, 30)];
//        m_imageView.image = [[TQSkinManger sharedManger] getDefault];
//        [self addSubview:m_imageView];
//        [m_imageView release];
        
//        m_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//        m_titleLabel.backgroundColor = [UIColor clearColor];
//        m_titleLabel.font = [UIFont systemFontOfSize:15];
//        m_titleLabel.textColor = [UIColor grayColor];
//        [self addSubview:m_titleLabel];
//        [m_titleLabel release];
    }
    
    return self;
}

- (void)updateCellData:(NewsInfoItem*)info{
    self.newsInfo = info;
}

- (void)adjustView:(CGRect)rect{
    if (!m_imageView) {
        m_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 60, 30)];
        m_imageView.image = [[TQSkinManger sharedManger] getDefault];
        [self addSubview:m_imageView];
        [m_imageView release];
    }
    CGSize imgSize = m_imageView.bounds.size;
    m_imageView.frame = CGRectMake(10, (CGRectGetHeight(rect) - imgSize.height)/2, imgSize.width, imgSize.height);
//    if (self.newsInfo.imgUrl) {
//        [m_imageView setImageWithURL:[NSURL URLWithString:self.newsInfo.imgUrl]];
//    }
    
    CGRect textLbRc = rect;
    textLbRc.origin.x = 20 + imgSize.width;
    textLbRc.origin.y = 0;
    textLbRc.size.width = CGRectGetWidth(rect) - textLbRc.origin.x - 10;
    if (!m_titleLabel) {
        m_titleLabel = [[UILabel alloc] initWithFrame:textLbRc];
        m_titleLabel.backgroundColor = [UIColor clearColor];
        m_titleLabel.font = [UIFont systemFontOfSize:15];
        m_titleLabel.textColor = [UIColor grayColor];
        [self addSubview:m_titleLabel];
        [m_titleLabel release];
    }
    m_titleLabel.text = self.newsInfo.title;
    m_titleLabel.frame = textLbRc;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [self adjustView:rect];
}

- (void)dealloc{
    self.newsInfo = nil;
    
    [super dealloc];
}

+ (CGFloat)getCellHeight{
    return 50;
}
@end
