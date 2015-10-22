//
//  MainPageViewCtrl.m
//  LPalmNews
//
//  Created by 林述灿 on 15/9/8.
//  Copyright (c) 2015年 LSC. All rights reserved.
//

#import "MainPageViewCtrl.h"

#import "TQMoveGridView.h"
#import "ListenNewsCtrl.h"
#import "TQAppManger.h"

@interface MainPageViewCtrl ()<TQMoveGridViewDelegate>

@property(nonatomic, retain) NSMutableArray* gridListArray;

@end

@implementation MainPageViewCtrl

@synthesize gridListArray;

- (id)init{
    self = [super init];
    if (self) {
        self.gridListArray = [[[NSMutableArray alloc] init] autorelease];
    }
    
    return self;
}

- (void)loadView{
    [super loadView];
    
    NSString* filePath = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath], @"NewsSetting.plist"];
    NSArray* array = [NSArray arrayWithContentsOfFile:filePath];
    
    
    UIView* bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    [bgView release];
    
    CGFloat lineW = 1.0f;
    CGSize btnSize = CGSizeMake((CGRectGetWidth(self.view.bounds) - lineW*3)/4, 80);
    CGFloat oriX = btnSize.width-lineW/2;
    for (NSInteger i = 0; i < 3; i++) {
        UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(oriX, 0, lineW, (80 + lineW)*3)];
        lineView.backgroundColor = [UIColor grayColor];
        [self.view addSubview:lineView];
        [lineView release];
        
        oriX += btnSize.width+lineW;
    }
    
    CGFloat oriY = btnSize.height;
    for (NSInteger i = 0; i < 3; i++) {
        UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(0, oriY, CGRectGetWidth(self.view.bounds), lineW)];
        lineView.backgroundColor = [UIColor grayColor];
        [self.view addSubview:lineView];
        [lineView release];
        
        oriY += btnSize.height+lineW;
    }
    
    oriY = 0;
    oriX = 0;
    for (NSInteger i = 0; i < 3; i++) {
        oriX = 0;
        for (NSInteger j = 0; j < 4; j++) {
            NSInteger index = i*4 + j;
            NSDictionary* dic = [array objectAtIndex:index];
            NSString* iconPath = [NSString stringWithFormat:@"Platform/%@.png", [dic objectForKey:@"icon"]];
            UIImage* iconImg = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", [TQSkinManger getAppResourcePath], iconPath]];
            
            TQMoveGridView* view = [[TQMoveGridView alloc] initWithFrame:CGRectMake(oriX, oriY, btnSize.width, btnSize.height) withTitle:[dic objectForKey:@"iconName"] withImage:iconImg];
            view.delegate = self;
            view.gridIndex = index;
            [self.view addSubview:view];
            [view release];
            
            [self.gridListArray addObject:view];
            
            oriX += btnSize.width + lineW;
        }
        
        oriY += btnSize.height+ lineW;
    }
}

- (void)gridItemDidClicked:(TQMoveGridView *)gridItem{
    //    [self.gridListArray removeObject:gridItem];
    //    if (gridItem.superview) {
    //        [gridItem removeFromSuperview];
    //    }
    
    ListenNewsCtrl* ctrl = [[ListenNewsCtrl alloc] init];
    ctrl.title = @"新闻";
    ctrl.hidesBottomBarWhenPushed = YES;
//    ctrl.navigationController.navigationBarHidden = YES;
    [[TQAppManger sharedManger].mainNavigateCtrl pushViewController:ctrl animated:YES];
    [ctrl release];
}

- (void)gridItemDidDeleteClicked:(TQMoveGridView *)gridItem{
    
}

- (void)pressGestureStateBegan:(TQMoveGridView *) gridItem{
    
}

- (void)pressGestureStateChangedWithPoint:(CGPoint) gridPoint gridItem:(TQMoveGridView *) gridItem{
    
    NSInteger fromIndex = gridItem.gridIndex;
    NSInteger toIndex = [TQMoveGridView indexOfPoint:gridItem.center withGridView:gridItem gridArray:self.gridListArray];
    
    if (toIndex < 0 ){//|| toIndex >= borderIndex) {
        //        contain = NO;
    }else{
        //获取移动到目标格子
        TQMoveGridView *targetGrid = self.gridListArray[toIndex];
        //        gridItem.center = targetGrid.gridCenter;
        gridItem.gridTargeCenter = targetGrid.gridCenter;
        gridItem.gridIndex = toIndex;
        
        //判断格子的移动方向，是从后往前还是从前往后拖动
        if ((fromIndex - toIndex) > 0) {
            //从移动格子的位置开始，始终获取最后一个格子的索引位置
            NSInteger lastGridIndex = fromIndex;
            for (NSInteger i = toIndex; i < fromIndex; i++) {
                TQMoveGridView *lastGrid = self.gridListArray[lastGridIndex];
                TQMoveGridView *preGrid = self.gridListArray[lastGridIndex-1];
                [UIView animateWithDuration:0.5 animations:^{
                    preGrid.center = lastGrid.gridCenter;
                }];
                preGrid.gridIndex = lastGridIndex;
                lastGridIndex--;
            }
        }else if((fromIndex - toIndex) < 0){
            //从前往后拖动格子
            for (NSInteger i = fromIndex; i < toIndex; i++) {
                TQMoveGridView *topOneGrid = self.gridListArray[i];
                TQMoveGridView *nextGrid = self.gridListArray[i+1];
                [UIView animateWithDuration:0.5 animations:^{
                    nextGrid.center = topOneGrid.gridCenter;
                }];
                nextGrid.gridIndex = i;
            }
        }
        
        [self sortGridList];
    }
}

- (void)sortGridList
{
    [self.gridListArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        TQMoveGridView *tempGrid1 = (TQMoveGridView *)obj1;
        TQMoveGridView *tempGrid2 = (TQMoveGridView *)obj2;
        return tempGrid1.gridIndex > tempGrid2.gridIndex;
    }];
    
    for (NSInteger i = 0; i < self.gridListArray.count; i++) {
        TQMoveGridView *gridItem = self.gridListArray[i];
        if (gridItem.bSelectMove) {
            gridItem.gridCenter = gridItem.gridTargeCenter;
        }else{
            gridItem.gridCenter = gridItem.center;
        }
    }
}

- (void)pressGestureStateEnded:(TQMoveGridView *) gridItem{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
