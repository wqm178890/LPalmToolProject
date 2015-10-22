//
//  TQMoveGridView.h
//  LPalmNews
//
//  Created by 林述灿 on 15/9/6.
//  Copyright (c) 2015年 LSC. All rights reserved.
//

#import "TQView.h"

@class TQMoveGridView;
@protocol TQMoveGridViewDelegate <NSObject>

- (void)gridItemDidClicked:(TQMoveGridView *)gridItem;
- (void)gridItemDidDeleteClicked:(TQMoveGridView *)gridItem;
- (void)pressGestureStateBegan:(TQMoveGridView *) gridItem;
- (void)pressGestureStateChangedWithPoint:(CGPoint) gridPoint gridItem:(TQMoveGridView *) gridItem;
- (void)pressGestureStateEnded:(TQMoveGridView *) gridItem;

@end

@interface TQMoveGridView : TQView

@property(nonatomic, assign) id<TQMoveGridViewDelegate>delegate;
@property(nonatomic, assign) NSInteger gridIndex;
@property(nonatomic, assign) CGPoint gridCenter;
@property(nonatomic, assign) CGPoint gridTargeCenter;//移动某一格重新设定位置
@property(nonatomic, assign) BOOL bSelectMove;

- (id)initWithFrame:(CGRect)frame withTitle:(NSString*)title withImage:(UIImage*)image;

+ (NSInteger)indexOfPoint:(CGPoint)point withGridView:(TQMoveGridView *)gridView gridArray:(NSArray *)gridListArray;
@end
