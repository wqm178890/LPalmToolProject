//
//  TQTabBarController.m
//  SoundStock
//
//  Created by Reader on 15/6/29.
//  Copyright (c) 2015年 Reader. All rights reserved.
//

#import "TQTabBarController.h"
#import "TQViewController.h"
//#import "TQAppDelegate.h"
#import "TQAppManger.h"

@interface TQTabBarController ()
{
    UIImageView *_tabBarView;//自定义的覆盖原先的tarbar的控件
    UIButton * _previousBtn;//记录前一次选中的按钮
}
@end

@implementation TQTabBarController

-(BOOL)shouldAutorotate{
//        return NO;
    
    return [self.viewControllers.lastObject shouldAutorotate];
//    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
//    if (UIInterfaceOrientationIsPortrait(orientation)) {
//        // 如果状态栏竖着的，不支持controller的旋转
//        return NO;
//    } else if (UIInterfaceOrientationIsLandscape(orientation)) {
//        return YES;
//    }
//    
//    return NO;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
}

//- (NSUInteger)supportedInterfaceOrientations{
//        return UIInterfaceOrientationMaskPortrait;
////    return UIInterfaceOrientationMaskAll;
////    
////    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
////    
////    if (UIInterfaceOrientationIsLandscape(orientation)) {
////        return UIInterfaceOrientationMaskLandscape;
////    }
////    return UIInterfaceOrientationMaskPortrait;
//}

//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//    return UIInterfaceOrientationPortrait;
//}
//
-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

//隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rc = self.tabBar.bounds;
    _tabBarView = [[UIImageView alloc]initWithFrame:self.tabBar.bounds];
    _tabBarView.userInteractionEnabled = YES;
    _tabBarView.backgroundColor = [UIColor clearColor];
    _tabBarView.image = [[TQSkinManger sharedManger] getBottomBarBGImage];
    [self.tabBar addSubview:_tabBarView];
    
    [self creatButtonWithNormalName:@"Skin/tabbar_mainframe.png" andSelectName:@"Skin/tabbar_mainframeHL.png" andTitle:@"联系人" andIndex:0];
    [self creatButtonWithNormalName:@"Skin/tabbar_contacts.png" andSelectName:@"Skin/tabbar_contactsHL.png" andTitle:@"产品" andIndex:1];
    [self creatButtonWithNormalName:@"Skin/tabbar_discover.png" andSelectName:@"Skin/tabbar_discoverHL.png" andTitle:@"信息" andIndex:2];
    [self creatButtonWithNormalName:@"Skin/tabbar_me.png" andSelectName:@"Skin/tabbar_meHL.png" andTitle:@"设置" andIndex:3];
}

- (void)creatButtonWithNormalName:(NSString *)normal andSelectName:(NSString *)selected andTitle:(NSString *)title andIndex:(int)index{
    
    CGFloat buttonW = _tabBarView.frame.size.width / 4;
    CGFloat buttonH = _tabBarView.frame.size.height;
    UIImage* normalImg = [UIImage imageNamed:normal];
    CGSize imageSize = normalImg.size;
    
    UIButton * customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    customButton.tag = index;
    customButton.adjustsImageWhenHighlighted = NO;
    customButton.adjustsImageWhenDisabled = NO;
    
    [customButton setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
//    [customButton setImage:[UIImage imageNamed:selected] forState:UIControlStateHighlighted];
    [customButton setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    [customButton setImage:[UIImage imageNamed:normal] forState:UIControlStateDisabled];
    
    [customButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [customButton setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    [customButton setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
    [customButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    [customButton setTitle:title forState:UIControlStateNormal];
    customButton.imageView.contentMode = UIViewContentModeCenter;
    customButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    customButton.titleLabel.font = [UIFont systemFontOfSize:10];
    
    
    customButton.imageEdgeInsets = UIEdgeInsetsMake(5, (buttonW - imageSize.width)/2 , 0, (buttonW - imageSize.width)/2);
    customButton.titleEdgeInsets = UIEdgeInsetsMake(10 + imageSize.height, - imageSize.width, 0, 0);
    customButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    customButton.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    
    [customButton addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchUpInside];
    customButton.frame = CGRectMake(buttonW * index, 0, buttonW, buttonH);
    
    [_tabBarView addSubview:customButton];
    
    if(index == 0)//设置第一个选择项。（默认选择项）
    {
        _previousBtn = customButton;
        _previousBtn.selected = YES;
    }
    
}

#pragma mark 按钮被点击时调用
- (void)changeViewController:(UIButton *)sender
{
    if(self.selectedIndex != sender.tag){
        
        UIImage* preImg = [_previousBtn imageForState:UIControlStateDisabled];
        [_previousBtn setImage:preImg forState:UIControlStateNormal];
        
        UIColor* preColor = [_previousBtn titleColorForState:UIControlStateDisabled];
        [_previousBtn setTitleColor:preColor forState:UIControlStateNormal];
        
        self.selectedIndex = sender.tag;
        _previousBtn.selected = NO;
        _previousBtn = sender;
        _previousBtn.selected = YES;
        
        UIImage* curImg = [_previousBtn imageForState:UIControlStateSelected];
        [_previousBtn setImage:curImg forState:UIControlStateNormal];
        
        UIColor* curColor = [_previousBtn titleColorForState:UIControlStateSelected];
        [_previousBtn setTitleColor:curColor forState:UIControlStateNormal];
    }
    
    [TQAppManger sharedManger].mainNavigateCtrl = [self.viewControllers objectAtIndex:self.selectedIndex];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSLog(@"viewWillDisappear");
//    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    for (UIView* obj in self.tabBar.subviews) {
        if (obj != _tabBarView) {
            [obj removeFromSuperview];
        }
    }
    
    UIButton * button = _tabBarView.subviews[0];
    [self changeViewController:button];
    
    NSLog(@"viewWillAppear");
//    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}




@end
