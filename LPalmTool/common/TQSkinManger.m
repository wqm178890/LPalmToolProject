//
//  TQSkinManger.m
//  SoundStock
//
//  Created by 林述灿 on 15/8/1.
//  Copyright (c) 2015年 Reader. All rights reserved.
//

#import "TQSkinManger.h"

@implementation TQSkinManger

static TQSkinManger *kTQSkinManger = nil;

+ (TQSkinManger *)sharedManger {
    @synchronized(self) {
        if (kTQSkinManger == nil) {
            kTQSkinManger = [[TQSkinManger alloc] init];
        }
    }
    return kTQSkinManger;
    
//    static TQSkinManger* kTQSkinManger = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        kTQSkinManger = [[TQSkinManger alloc] init];
//    });
//    
//    return kTQSkinManger;
}


+ (NSString *)getAppResourcePath {
    return @"Skin/";
}

+ (NSString *)getAppAbsoluteResourcePath {
    return [NSString stringWithFormat:@"%@/%@",[[self class] getAppPath],[[self class] getAppResourcePath]];
}

//+ (NSString *)getHtmlServerResourcePath
//{
//    return [NSString stringWithFormat:@"%@/tmp", [[NSBundle mainBundle] resourcePath]];
//}

//获取FirstReadConfigFile文件
//+ (NSString*)getFirstReadConfigFile
//{
//    NSString *firstReadConfigPath = [NSString stringWithFormat:@"%@%@",[ReaderGUICtrl getPreferencePath],FIRST_READ_CONFIG];
//    return firstReadConfigPath;
//}

+ (NSString *)getAppPath {
    return [NSString stringWithFormat:@"%@/", [[NSBundle mainBundle] resourcePath]];
}

- (UIImage*)getBottomBarBGImage {
    NSString *imagePath = [NSString stringWithFormat:@"%@%@", [[self class] getAppResourcePath], BottomBarBG];
    return [UIImage imageNamed:imagePath];
}

- (UIImage*)getTopBarBGImage {
    NSString *imagePath = [NSString stringWithFormat:@"%@%@", [[self class] getAppResourcePath], TopNavBarBG];
    return [UIImage imageNamed:imagePath];
}

- (UIImage*)getCellSpline{
    NSString *imagePath = [NSString stringWithFormat:@"%@%@", [[self class] getAppResourcePath], CellSpline];
    return [UIImage imageNamed:imagePath];
}

- (UIImage*)getDefault{
    NSString *imagePath = [NSString stringWithFormat:@"%@%@", [[self class] getAppResourcePath], Default];
    return [UIImage imageNamed:imagePath];
}

- (UIImage*)getBarBackIcon{
    NSString *imagePath = [NSString stringWithFormat:@"%@%@", [[self class] getAppResourcePath], BarBackIcon];
    return [UIImage imageNamed:imagePath];
}

- (UIImage*)getNewsPlayBtnNormal{
    NSString *imagePath = [NSString stringWithFormat:@"%@%@", [[self class] getAppResourcePath], NewsPlayBtnNormal];
    return [UIImage imageNamed:imagePath];
}

- (UIImage*)getNewsPlayBtnPress{
    NSString *imagePath = [NSString stringWithFormat:@"%@%@", [[self class] getAppResourcePath], NewsPlayBtnPress];
    return [UIImage imageNamed:imagePath];
}

- (UIImage*)getNewsPlayAudioNewsBg{
    NSString *imagePath = [NSString stringWithFormat:@"%@%@", [[self class] getAppResourcePath], NewsPlayAudioNewsPlayBg];
    return [UIImage imageNamed:imagePath];
}

- (UIImage*)getNewsPlayAudioButton{
    NSString *imagePath = [NSString stringWithFormat:@"%@%@", [[self class] getAppResourcePath], NewsPlayAudioNewsPlay];
    return [UIImage imageNamed:imagePath];
}

- (UIImage*)getNewsPlayAudioPause{
    NSString *imagePath = [NSString stringWithFormat:@"%@%@", [[self class] getAppResourcePath], NewsPlayAudioNewsPause];
    return [UIImage imageNamed:imagePath];
}

- (UIImage*)getNewsPlayAudioDisk{
    NSString *imagePath = [NSString stringWithFormat:@"%@%@", [[self class] getAppResourcePath], NewsPlayAudioNewsDisk];
    return [UIImage imageNamed:imagePath];
}

- (UIImage*)getNewsPlayAudioPrevious{
    NSString *imagePath = [NSString stringWithFormat:@"%@%@", [[self class] getAppResourcePath], NewsPlayAudioNewsPrevious];
    return [UIImage imageNamed:imagePath];
}

- (UIImage*)getNewsPlayAudioPreviousHight{
    NSString *imagePath = [NSString stringWithFormat:@"%@%@", [[self class] getAppResourcePath], NewsPlayAudioNewsPreviousHight];
    return [UIImage imageNamed:imagePath];
}

- (UIImage*)getNewsPlayAudioNext{
    NSString *imagePath = [NSString stringWithFormat:@"%@%@", [[self class] getAppResourcePath], NewsPlayAudioNewsNext];
    return [UIImage imageNamed:imagePath];
}

- (UIImage*)getNewsPlayAudioNextHight{
    NSString *imagePath = [NSString stringWithFormat:@"%@%@", [[self class] getAppResourcePath], NewsPlayAudioNewsNextHight];
    return [UIImage imageNamed:imagePath];
}

- (UIImage*)getNewsPlayAudioBlockBg{
    NSString *imagePath = [NSString stringWithFormat:@"%@%@", [[self class] getAppResourcePath], NewsPlayAudioNewsBlockBg];
    return [UIImage imageNamed:imagePath];
}

@end
