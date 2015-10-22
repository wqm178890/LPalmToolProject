//
//  TQViewController.m
//  TQProject
//
//  Created by Reader on 15/4/14.
//  Copyright (c) 2015年 Reader. All rights reserved.
//

#import "TQViewController.h"
//#import "TQAppDelegate.h"

@interface TQViewController ()
{
    UIImageView* _bgView;
    UILabel* _navTitleLabel;
    
    UIView* _firstSubView;
    UIView* _selfView;
}
@end

@implementation TQViewController

- (id)init
{
    self = [super init];
    if (self) {
//        [self navigationItemInit];
    }
    
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    
    return self;
}

- (void)initNavBarItem
{
    
}

- (void)loadView{
    [super loadView];
    CGRect rc = self.view.bounds;

    _selfView = [[UIView alloc] initWithFrame:self.view.bounds];
    _bgView = [[UIImageView alloc] initWithFrame:rc];
    _bgView.image = [UIImage imageNamed:@"Skin/background_gray.png"];
    _bgView.backgroundColor = [UIColor clearColor];
    [_selfView addSubview:_bgView];
    [_bgView release];
    
    if (_selfView) {
        self.view = _selfView;
    }

    
//    if (_selfView)
//    {
//        self.view = _selfView;
//    }
    
//    _bgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    _bgView.image = [UIImage imageNamed:@"skin/background_gray.png"];
//    [self.view addSubview:_bgView];
//    [_bgView release];
    
//    UIButton* btn = [UIButton buttonWithType:UIButtonTypeSystem];
//    [btn setTitle:@"push" forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
//    btn.frame = CGRectMake(100, 100, 100, 100);
//    [self.view addSubview:btn];
}

//- (void)push{
//    TQViewController* pushCtrl = [[TQViewController alloc] init];
////    pushCtrl.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:pushCtrl animated:YES];
//    [pushCtrl release];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
//    CGRect rc = self.navigationController.navigationBar.frame;
//    CGFloat navheight = self.navigationController.navigationBar.frame.size.height;
//    NSLog(@"nav%f",navheight);
    
//    [self setNeedsStatusBarAppearanceUpdate];
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:[[TQSkinManger sharedManger] getTopBarBGImage] forBarMetrics:UIBarMetricsDefault];

//    if (self.navigationController.viewControllers.count > 1) {
//        TQAppDelegate *tempAppDelegate = (TQAppDelegate *)[[UIApplication sharedApplication] delegate];
//        [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
//    }else{
//        TQAppDelegate *tempAppDelegate = (TQAppDelegate *)[[UIApplication sharedApplication] delegate];
//        [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
//    }
//}

//- (void)viewWillDisappear:(BOOL)animated{
//    if (self.navigationController.viewControllers.count > 1) {
//        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
//    }
//}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
-(BOOL)shouldAutorotate{
    return YES;
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

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;//UIInterfaceOrientationMaskPortrait;
    
//    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
//    
//    if (UIInterfaceOrientationIsLandscape(orientation)) {
//        return UIInterfaceOrientationMaskLandscape;
//    }
//    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}


-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

////隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)statusBarOrientationChange:(NSNotification *)notification

{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if (orientation == UIInterfaceOrientationLandscapeRight) // home键靠右
        
    {
        
//        self.navigationItem.titleView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 32);
        
    }
    
    if (
        
        orientation ==UIInterfaceOrientationLandscapeLeft) // home键靠左
        
    {
        
//        self.navigationItem.titleView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 32);
        
    }
    
    if (orientation == UIInterfaceOrientationPortrait)
        
    {
        
//        self.navigationItem.titleView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), NAVIGATION_TOP_HEIGHT);
        
    }
    
    
    if (orientation == UIInterfaceOrientationPortraitUpsideDown)
        
    {
        
//        self.navigationItem.titleView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), NAVIGATION_TOP_HEIGHT);
        
    }
    
}

- (void)orientChange:(NSNotification *)noti

{
    
    NSDictionary* ntfDict = [noti userInfo];
    
    UIDeviceOrientation orient = [UIDevice currentDevice].orientation;

    /*
     
     UIDeviceOrientationUnknown,
     
     UIDeviceOrientationPortrait, // Device oriented vertically, home button on the bottom
     
     UIDeviceOrientationPortraitUpsideDown, // Device oriented vertically, home button on the top
     
     UIDeviceOrientationLandscapeLeft, // Device oriented horizontally, home button on the right
     
     UIDeviceOrientationLandscapeRight, // Device oriented horizontally, home button on the left
     
     UIDeviceOrientationFaceUp, // Device oriented flat, face up
     
     UIDeviceOrientationFaceDown // Device oriented flat, face down */
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGRect rc = [UIScreen mainScreen].bounds;
    
    switch (orient)
    
    {
            
        case UIDeviceOrientationPortrait:
//        case UIDeviceOrientationPortraitUpsideDown:
        {
//            _bgView.frame = CGRectMake(0, 0, 320, 568);
//            self.navigationItem.titleView.frame = CGRectMake(0, 0, 320, NAVIGATION_TOP_HEIGHT);
        }
            
            break;
            
        case UIDeviceOrientationLandscapeLeft:
        case UIDeviceOrientationLandscapeRight:
        {
//            CGRect rc = self.view.frame;
//            self.view.frame = CGRectMake(0, 0, 568, 320);
//            _bgView.frame = CGRectMake(0, 0, 568, 320);
//            self.navigationItem.titleView.frame = CGRectMake(0, 0, 568, 32);
        }
            break;
            
//        case UIDeviceOrientationPortraitUpsideDown:
//            
//            break;
            
//        case UIDeviceOrientationLandscapeRight:
//            
//            break;
            
        default:
            
            break;
            
    }
    
}

//- (void)navigationItemInit
//{
//    if (!_navTitleLabel) {
//        _navTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,CGRectGetWidth(self.navigationItem.titleView.bounds), NAVIGATION_TOP_HEIGHT)];
//        _navTitleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
//        _navTitleLabel.font            = [UIFont systemFontOfSize:20];  //设置文本字体与大小
//        _navTitleLabel.textColor       = [UIColor whiteColor];  //设置文本颜色
//        _navTitleLabel.textAlignment   = NSTextAlignmentCenter;
//        self.navigationItem.titleView = _navTitleLabel;
//    }
//}
//
//- (void)setTitle:(NSString *)title{
//    [super setTitle:title];
//    if (_navTitleLabel) {
//        _navTitleLabel.text = title;
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIBarButtonItem *)navBarItemWithTarget:(id)target
                                   action:(SEL)action
                                imageName:(NSString*)imgName
{
    UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbutton.frame = CGRectMake(0, 4, 42, 40);
    [leftbutton setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [leftbutton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UILabel* leftLb = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 50, 44)];
    leftLb.text = @"xxx";
    leftLb.backgroundColor = [UIColor whiteColor];
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    view.backgroundColor = [UIColor blueColor];
    [view addSubview:leftbutton];
    
    [view addSubview:leftLb];
    
    UIBarButtonItem *letfBarItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    letfBarItem.title = @"xxxx";
    
    return letfBarItem;
}

@end
