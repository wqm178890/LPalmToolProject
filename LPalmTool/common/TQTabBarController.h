//
//  TQTabBarController.h
//  SoundStock
//
//  Created by Reader on 15/6/29.
//  Copyright (c) 2015年 Reader. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TQTabBarControllerDelegate <UITabBarControllerDelegate>

@optional
- (void)tabBarDidSelectViewController:(UIViewController *)viewController didSelectItem:(NSDictionary*)item;

@end

@interface TQTabBarController : UITabBarController
@property(nonatomic, assign) id<TQTabBarControllerDelegate> tabBarDelegate;

- (void)initTabBarView:(NSArray*)array;
@end
