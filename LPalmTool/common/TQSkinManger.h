//
//  TQSkinManger.h
//  SoundStock
//
//  Created by 林述灿 on 15/8/1.
//  Copyright (c) 2015年 Reader. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TQSkinManger : NSObject

+ (TQSkinManger *)sharedManger;
+ (NSString*)getAppResourcePath;
- (UIImage*) getBottomBarBGImage;
- (UIImage*) getTopBarBGImage;
- (UIImage*)getBarBackIcon;
- (UIImage*)getCellSpline;
- (UIImage*)getDefault;
- (UIImage*)getNewsPlayBtnNormal;
- (UIImage*)getNewsPlayBtnPress;
- (UIImage*)getNewsPlayAudioNewsBg;
- (UIImage*)getNewsPlayAudioButton;
- (UIImage*)getNewsPlayAudioPause;
- (UIImage*)getNewsPlayAudioDisk;
- (UIImage*)getNewsPlayAudioPrevious;
- (UIImage*)getNewsPlayAudioPreviousHight;
- (UIImage*)getNewsPlayAudioNext;
- (UIImage*)getNewsPlayAudioNextHight;
- (UIImage*)getNewsPlayAudioBlockBg;

@end
