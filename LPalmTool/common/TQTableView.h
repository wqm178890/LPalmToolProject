//
//  TQTableView.h
//  SoundStock
//
//  Created by 林述灿 on 15/7/23.
//  Copyright (c) 2015年 Reader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TQTableView : UITableView

@property(nonatomic, assign)BOOL bHiddenBgImg;//default is YES

- (void)setEmptySeparator;

@end
