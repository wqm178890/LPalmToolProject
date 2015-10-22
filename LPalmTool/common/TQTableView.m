//
//  TQTableView.m
//  SoundStock
//
//  Created by 林述灿 on 15/7/23.
//  Copyright (c) 2015年 Reader. All rights reserved.
//

#import "TQTableView.h"

@implementation TQTableView
@synthesize bHiddenBgImg;

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [self initWithFrame:frame style:UITableViewStylePlain])) {
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if ((self = [super initWithFrame:frame style:style])) {
        self.bHiddenBgImg = YES;
        self.separatorColor = [UIColor clearColor];
        //self.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    
    if (!self.bHiddenBgImg)
    {
//        UIImage* img = [[ReaderSkinManage sharedData] getGrayBgImage];
//        if (img)
//        {
//            [img customDrawInRect:rect];
//        }
//        else
//        {
//            UIColor* color = grayBgColor;
//            [color set];
//            UIRectFill(rect);
//        }
        
    }
}

- (void)setEmptySeparator
{
//    UIColor* cl = [UIColor clearColor];
//    self.separatorColor = cl;
}
@end
