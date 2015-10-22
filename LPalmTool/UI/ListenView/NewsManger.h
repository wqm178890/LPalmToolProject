//
//  NewsManger.h
//  LPalmNews
//
//  Created by 林述灿 on 15/9/29.
//  Copyright © 2015年 LSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NewsMangerDelegate <NSObject>

@optional
- (void)newsPlayEnd;
@end

@class NewsMangerCtrl;

@interface NewsManger : NSObject
@property(nonatomic, retain) NewsMangerCtrl* newsCtrl;
@property(nonatomic, assign) id<NewsMangerDelegate> delegate;

+ (NewsManger*)shareManger;

- (void)playNewsText:(NSString*)text;
- (void)pauseSpeak;
- (void)resumeSpeak;
- (void)stopSpeak;

@end
