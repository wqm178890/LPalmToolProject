//
//  TQTableViewCell.m
//  SoundStock
//
//  Created by 林述灿 on 15/7/23.
//  Copyright (c) 2015年 Reader. All rights reserved.
//

#import "TQTableViewCell.h"

@interface TQTableViewCell()
{
    UIImageView* m_bgView;
    UIImageView* m_selectBgView;
    UIImageView* m_cellLineView;
}
@end

@implementation TQTableViewCell
@synthesize hideCellLine;
@synthesize hideBgView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])) {
        [self initBaseTableViewCell];
    }
    
    return self;
}

- (void)initBaseTableViewCell
{
    self.backgroundColor = [UIColor clearColor];
    self.hideBgView = NO;
    self.hideCellLine = NO;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [self drawBgView:rect];
    [self drawSelectBgView:rect];
    [self drawCellLine:rect];
}

- (void)drawBgView:(CGRect)rect{
    if(!m_bgView) {
        if (self.hideBgView) {
            self.backgroundView = nil;
        }else {
            m_bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,rect.size.width , rect.size.height)];
            m_bgView.backgroundColor = [UIColor whiteColor];
            self.backgroundView = m_bgView;
            [m_bgView release];
        }
    }
}

- (void)drawSelectBgView:(CGRect)rect
{
//    if (!m_selectBgView)
//    {
//        m_selectBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,rect.size.width , rect.size.height)];
//        self.selectedBackgroundView = m_selectBgView;
//        m_selectBgView.backgroundColor = [UIColor grayColor];
////        ((UIImageView*)m_selectBgView).image = [[ReaderSkinManage sharedData] getCellBgImage];
//        [m_selectBgView release];
//    }
}

- (void)drawCellLine:(CGRect)rect {
    if (!self.hideCellLine) {
        UIImage* image = [[TQSkinManger sharedManger] getCellSpline];
        CGSize lineSize = image.size;
        CGRect rc = CGRectMake(0, rect.size.height - lineSize.height, rect.size.width, lineSize.height);
        if (!m_cellLineView) {
            m_cellLineView = [[UIImageView alloc] initWithFrame:rc];
            m_cellLineView.backgroundColor = [UIColor clearColor];
            [self addSubview:m_cellLineView];
            [m_cellLineView release];
        }
        m_cellLineView.image = image;
        m_cellLineView.frame = rc;
    }
}


@end
