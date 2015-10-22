//
//  ListenNewsCell.h
//  LPalmNews
//
//  Created by 林述灿 on 15/8/6.
//  Copyright (c) 2015年 LSC. All rights reserved.
//

#import "TQTableViewCell.h"
#import "ObjectDefine.h"

@interface ListenNewsCell : TQTableViewCell

- (void)updateCellData:(NewsInfoItem*)info;
+ (CGFloat)getCellHeight;

@end
