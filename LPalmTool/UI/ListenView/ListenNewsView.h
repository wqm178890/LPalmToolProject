//
//  LinstenNewsView.h
//  LPalmNews
//
//  Created by 林述灿 on 15/8/13.
//  Copyright (c) 2015年 LSC. All rights reserved.
//

#import "TQView.h"
#import "WKPageCell.h"

@interface ListenNewsView : WKPageCell
@property(nonatomic, retain) NSString* loadUrl;
- (void)loadRequestById:(NSString*)cateogryId;
@end
