//
//  TQMoveGridView.m
//  LPalmNews
//
//  Created by 林述灿 on 15/9/6.
//  Copyright (c) 2015年 LSC. All rights reserved.
//

#import "TQMoveGridView.h"

@interface TQMoveGridView ()
{
    CGPoint startPoint;
    CGPoint originPoint;
}
@end

@implementation TQMoveGridView
@synthesize delegate;
@synthesize gridIndex;
@synthesize gridCenter;
@synthesize gridTargeCenter;
@synthesize bSelectMove;

- (id)initWithFrame:(CGRect)frame withTitle:(NSString*)title withImage:(UIImage*)image{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.gridCenter = self.center;
        self.gridTargeCenter = self.center;
        
        UIImageView* iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.bounds) - image.size.width)/2, 10, image.size.width, image.size.height)];
        iconImgView.image = image;
        [self addSubview:iconImgView];
        [iconImgView release];
        
        CGFloat oriY = iconImgView.frame.origin.y + iconImgView.frame.size.height;
        
        UILabel* titleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, oriY, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - oriY)];
        titleLb.text = title;
        titleLb.textColor = [UIColor blackColor];
        titleLb.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLb];
        [titleLb release];
        
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:longPressGesture];
        [longPressGesture release];
        
        UITapGestureRecognizer* tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPress:)];
        [self addGestureRecognizer:tapGestureRecognizer];
        [tapGestureRecognizer release];
    }
    
    return self;
}


- (void)longPress:(UILongPressGestureRecognizer*)recognizer{
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            startPoint = [recognizer locationInView:self];
            originPoint = self.center;
            self.bSelectMove = YES;
            [UIView animateWithDuration:0.5 animations:^{
                self.backgroundColor = [UIColor grayColor];
                self.transform = CGAffineTransformMakeScale(1.1, 1.1);
            }];
            if (self.delegate && [self.delegate respondsToSelector:@selector(pressGestureStateBegan:)]) {
                [self.delegate pressGestureStateBegan:self];
            }
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            //应用移动后的新坐标
            CGPoint newPoint = [recognizer locationInView:self];
            CGFloat deltaX = newPoint.x - startPoint.x;
            //应用移动后的Y坐标
            CGFloat deltaY = newPoint.y - startPoint.y;
            //拖动的应用跟随手势移动
            self.center = CGPointMake(self.center.x + deltaX, self.center.y + deltaY);
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(pressGestureStateChangedWithPoint:gridItem:)]) {
                [self.delegate pressGestureStateChangedWithPoint:newPoint gridItem:self];
            }
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            [UIView animateWithDuration:0.5 animations:^{
                self.transform = CGAffineTransformIdentity;
                self.backgroundColor = [UIColor clearColor];
            }];
            
            self.bSelectMove = NO;
            self.center = self.gridTargeCenter;
            if (self.delegate && [self.delegate respondsToSelector:@selector(pressGestureStateEnded:)]) {
                [self.delegate pressGestureStateEnded:self];
            }
        }
            break;
            
        default:
            break;
    }
    
}

- (void)tapPress:(UITapGestureRecognizer*)recognizer{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gridItemDidClicked:)]) {
        [self.delegate gridItemDidClicked:self];
    }
}

//根据格子的坐标计算格子的索引位置
+ (NSInteger)indexOfPoint:(CGPoint)point withGridView:(TQMoveGridView *)gridView gridArray:(NSArray *)gridListArray
{
    for (NSInteger i = 0; i< gridListArray.count; i++) {
        TQMoveGridView *view = gridListArray[i];
        if (view != gridView) {
            if (CGRectContainsPoint(view.frame, point)) {
                return i;
            }
        }
    }
    
    return -1;
}

@end
