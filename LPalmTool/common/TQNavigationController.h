//
//  TQNavigationController.h
//  TQProject
//
//  Created by Reader on 15/4/9.
//  Copyright (c) 2015年 Reader. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TQNavigationController : UINavigationController<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@property(nonatomic, retain) UIViewController* currentShowVC;

@end
