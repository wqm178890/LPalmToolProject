//
//  TQNavigationController.m
//  TQProject
//
//  Created by Reader on 15/4/9.
//  Copyright (c) 2015年 Reader. All rights reserved.
//

#import "TQNavigationController.h"


//    http://blog.csdn.net/meegomeego/article/details/25879605
//    http://www.apkbus.com/android-131343-1-1.html
//    [self.navigationController.navigationBar setBackIndicatorImage:
//     [UIImage imageNamed:@"CustomerBackImage"]];
//    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:
//     [UIImage imageNamed:@"CustomerBackImage"]];
//不过在ios8中，最好将[self.navigationController setNavigationBarHidden:NO animated:YES];改成self.navigationController.navigationBar.hidden = NO;这样既能隐藏导航栏，但还能保留划屏返回的手势

@implementation TQNavigationController

@synthesize currentShowVC;

-(id)initWithRootViewController:(UIViewController *)rootViewController
{
    TQNavigationController* nvc = [super initWithRootViewController:rootViewController];
    self.interactivePopGestureRecognizer.delegate = self;
    nvc.delegate = self;
    
    rootViewController.navigationItem.leftBarButtonItem = [self addNullLeftBar];
    rootViewController.navigationItem.rightBarButtonItem = [self addRightBarBack];
    [self navigationItemInit:rootViewController];
    
    return nvc;
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (navigationController.viewControllers.count == 1)
        self.currentShowVC = Nil;
    else
        self.currentShowVC = viewController;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        return (self.currentShowVC == self.topViewController);
    }
    return YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
    UIViewController* topVC = self.topViewController;
    
    return [topVC preferredStatusBarStyle];
}

-(BOOL)shouldAutorotate{
//    return YES;
    UIViewController* topVC = self.topViewController;
    
    return [topVC shouldAutorotate];
}

//- (NSUInteger)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskPortrait;
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//    return UIInterfaceOrientationPortrait;
//}

-(NSUInteger)supportedInterfaceOrientations
{
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
}


////隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)dealloc{
    self.currentShowVC = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];//状态栏
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange:) name:UIDeviceOrientationDidChangeNotification object:nil];//设备转
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationBar setBackgroundImage:[[TQSkinManger sharedManger] getTopBarBGImage] forBarMetrics:UIBarMetricsDefault];
}

- (void)statusBarOrientationChange:(NSNotification *)notification

{
//    [self.viewControllers.lastObject statusBarOrientationChange:notification];
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if (orientation == UIInterfaceOrientationLandscapeRight) // home键靠右
        
    {
        
        //
        
    }
    
    if (
        
        orientation ==UIInterfaceOrientationLandscapeLeft) // home键靠左
        
    {
        
        //
        
    }
    
    if (orientation == UIInterfaceOrientationPortrait)
        
    {
        
        //
        
    }
    
    
    if (orientation == UIInterfaceOrientationPortraitUpsideDown)
        
    {
        
        //
        
    }
    
}

- (void)orientChange:(NSNotification *)noti

{
    
    NSDictionary* ntfDict = [noti userInfo];
    
    UIDeviceOrientation orient = [UIDevice currentDevice].orientation;
    
    if ([self.viewControllers.lastObject respondsToSelector:@selector(orientChange:)]) {
        [self.viewControllers.lastObject orientChange:noti];
    }
    
    return;
    
    /*
     
     UIDeviceOrientationUnknown,
     
     UIDeviceOrientationPortrait, // Device oriented vertically, home button on the bottom
     
     UIDeviceOrientationPortraitUpsideDown, // Device oriented vertically, home button on the top
     
     UIDeviceOrientationLandscapeLeft, // Device oriented horizontally, home button on the right
     
     UIDeviceOrientationLandscapeRight, // Device oriented horizontally, home button on the left
     
     UIDeviceOrientationFaceUp, // Device oriented flat, face up
     
     UIDeviceOrientationFaceDown // Device oriented flat, face down */
    
    switch (orient)
    
    {
            
        case UIDeviceOrientationPortrait:
            
            break;
            
        case UIDeviceOrientationLandscapeLeft:
            
            break;
            
        case UIDeviceOrientationPortraitUpsideDown:
            
            break;
            
        case UIDeviceOrientationLandscapeRight:
            
            break;
            
        default:
            
            break;
            
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (UIBarButtonItem *)addNullLeftBar
{
    UIView* view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 65, NAVIGATION_TOP_HEIGHT)] autorelease];
    view.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem *letfBarItem = [[[UIBarButtonItem alloc] initWithCustomView:view] autorelease];
    //    letfBarItem.style = UIBarButtonItemStylePlain;
    return letfBarItem;
}

- (UIBarButtonItem *)addLeftBarBack
{
    UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbutton.frame = CGRectMake(0, (NAVIGATION_TOP_HEIGHT - 30)/2, 15, 30);
    [leftbutton setBackgroundImage:[[TQSkinManger sharedManger] getBarBackIcon] forState:UIControlStateNormal];
    [leftbutton addTarget:self action:@selector(backBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel* leftLb = [[[UILabel alloc] initWithFrame:CGRectMake(20, 0, 50, NAVIGATION_TOP_HEIGHT)] autorelease];
    leftLb.text = ((UILabel*)(self.topViewController.navigationItem.titleView)).text;
    leftLb.backgroundColor = [UIColor clearColor];
    leftLb.textColor = [UIColor whiteColor];
    
    UIView* view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 65, NAVIGATION_TOP_HEIGHT)] autorelease];
    view.backgroundColor = [UIColor clearColor];
    [view addSubview:leftbutton];
    
//    [view addSubview:leftLb];
    
    UIBarButtonItem *letfBarItem = [[[UIBarButtonItem alloc] initWithCustomView:view] autorelease];
//    letfBarItem.style = UIBarButtonItemStylePlain;
    return letfBarItem;
}
- (void)webTest{
    //http://rmb0595.gotoip3.com/service/News/ArticleDetail.aspx?id=111
    UIViewController* ctrl = [[UIViewController alloc] init];
    ctrl.title = @"网页测试";
    [self pushViewController:ctrl animated:YES];
}
- (UIBarButtonItem *)addRightBarBack
{
    UIView* view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 65, NAVIGATION_TOP_HEIGHT)] autorelease];
    view.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem *letfBarItem = [[[UIBarButtonItem alloc] initWithCustomView:view] autorelease];
    //    letfBarItem.style = UIBarButtonItemStylePlain;
    return letfBarItem;
}

- (void)navigationItemInit:(UIViewController*)viewController
{
    CGFloat width = ScreenWidth;
//    if(viewController.navigationItem.leftBarButtonItem){
//        width -= 15*2;
//    }
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,width,NAVIGATION_TOP_HEIGHT)];
    titleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
    titleLabel.font            = [UIFont boldSystemFontOfSize:20];  //设置文本字体与大小
    titleLabel.textColor       = [UIColor whiteColor];  //设置文本颜色
    titleLabel.textAlignment   = NSTextAlignmentCenter;
    titleLabel.text = viewController.title;
    viewController.navigationItem.titleView = titleLabel;
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
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    view.backgroundColor = [UIColor clearColor];
    [view addSubview:leftbutton];
    
    [view addSubview:leftLb];
    
    UIBarButtonItem *letfBarItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    letfBarItem.title = @"xxxx";
//    return nil;
    return letfBarItem;
}

- (void)backBtnPressed:(id)sender
{
    [super popViewControllerAnimated:YES];
}

- (void)dismissLeftBtnPress:(id)sender
{
    [super dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightBtnPressed:(id)sender
{
    
}

#pragma mark - presentViewController && pushViewController method
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag
                   completion:(void (^)(void))completion
{
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
    // 添加返回
    UINavigationController *nav = (UINavigationController*)viewControllerToPresent;
    if ([self.viewControllers count] > 1){
        if (nav.topViewController.navigationItem.leftBarButtonItem == nil){
            nav.topViewController.navigationItem.leftBarButtonItem =
            [self navBarItemWithTarget:self
                                action:@selector(dismissLeftBtnPress:)
                             imageName:@"icon_return.png"];
        }
        if (nav.topViewController.navigationItem.rightBarButtonItem == nil)
        {
            nav.topViewController.navigationItem.rightBarButtonItem = [self navBarItemWithTarget:self action:@selector(rightBtnPressed:) imageName:@"icon_personal.png"];
        }
        
        [self navigationItemInit:nav.topViewController];
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIBarButtonItem* leftItem = [self addLeftBarBack];
    
    [super pushViewController:viewController animated:animated];
    
    // 添加返回
    if ([self.viewControllers count] > 1){
        if (viewController.navigationItem.leftBarButtonItem == nil){
            viewController.navigationItem.leftBarButtonItem = leftItem;
//              self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
//            viewController.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:[self navBarItemWithTarget:self
//                                                                                                             action:@selector(backBtnPressed:)
//                                                                                                          imageName:@"Skin/back_button.png"]
//                                                                , nil];
           
//            self.navigationItem.backBarButtonItem = [self navBarItemWithTarget:self
//                                                                        action:@selector(backBtnPressed:)
//                                                                     imageName:@"Skin/back_button.png"];
        }
        
        if (viewController.navigationItem.rightBarButtonItem == nil)
        {
            viewController.navigationItem.rightBarButtonItem = [self addRightBarBack];
//            [self navBarItemWithTarget:self
//                                action:@selector(rightBtnPressed:)
//                             imageName:@"Skin/back_button.png"];
        }
        
        [self navigationItemInit:viewController];
    }
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    return [super popViewControllerAnimated:animated];
}

@end
