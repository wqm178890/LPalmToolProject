//
//  NewsManger.m
//  LPalmNews
//
//  Created by 林述灿 on 15/9/29.
//  Copyright © 2015年 LSC. All rights reserved.
//

#import "NewsManger.h"
#import "NewsMangerCtrl.h"
#import "ObjectDefine.h"

#import "BDTTSSynthesizerDelegate.h"
#import "BDTTSSynthesizer.h"

@interface NewsManger () <BDTTSSynthesizerDelegate>
@property(nonatomic, retain) NSString* curPlayNewsContent;
@property(nonatomic, assign) NSInteger playPosition;
@end

@implementation NewsManger
@synthesize curPlayNewsContent;
@synthesize playPosition;
@synthesize newsCtrl;
@synthesize delegate;

+ (NewsManger*)shareManger{
    static NewsManger* m_shareManger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m_shareManger = [[NewsManger alloc] init];
    });
    
    return m_shareManger;
}

- (id)init{
    self = [super init];
    if (self) {
        self.newsCtrl = nil;
        self.curPlayNewsContent = nil;
        self.playPosition = 0;
        self.delegate = nil;
        [self initBDTTSSynthesizer];
    }
    
    return self;
}

- (void)dealloc{
    self.newsCtrl = nil;
    self.curPlayNewsContent = nil;
    self.delegate = nil;
    
    [super dealloc];
}

- (void)initBDTTSSynthesizer
{
    [BDTTSSynthesizer setLogLevel:BDS_LOG_OFF];
    [[BDTTSSynthesizer sharedInstance] setSynthesizerDelegate: self];
    
    // 在线相关设置
    [[BDTTSSynthesizer sharedInstance] setApiKey:@"HVXghrUfk3XUgMWLL03ZX3fr" withSecretKey:@"ITad5kVnOs7WnuSGlp7vLcpZoSjCG6ZV"];
    [[BDTTSSynthesizer sharedInstance] setTTSServerTimeOut:10];
    
    // 离线相关设置
    NSString *textDataFile =[[NSBundle mainBundle] pathForResource:@"bd_etts_text" ofType:@"dat"];
    NSString *speechDataFile =[[NSBundle mainBundle] pathForResource:@"bd_etts_speech_female" ofType:@"dat"];
    [[BDTTSSynthesizer sharedInstance] setOfflineEngineLicense:nil withAppCode:@"6255031"];
    [[BDTTSSynthesizer sharedInstance] setOfflineEngineTextDatPath:textDataFile andSpeechData:speechDataFile];
    
    // 合成参数设置
    [[BDTTSSynthesizer sharedInstance] setSynthesizeParam: BDTTS_PARAM_VOLUME withValue: BDTTS_PARAM_VOLUME_MAX];
    [[BDTTSSynthesizer sharedInstance] setSynthesizeParam: BDTTS_PARAM_SPEED withValue: BDTTS_PARAM_SPEED_MAX];
    [[BDTTSSynthesizer sharedInstance] setSynthesizeParam: BDTTS_PARAM_PERSON withValue: BDTTS_SPEAK_PERSON_FEMALE];
    
    // 加载合成引擎
    [[BDTTSSynthesizer sharedInstance] loadTTSEngine];
}

- (void)playNewsText:(NSString*)text{
    self.curPlayNewsContent = text;
    self.playPosition = 0;
    
    [self play];
}

- (void)play{
    if (self.playPosition >= self.curPlayNewsContent.length) {
        self.playPosition = 0;
        [self playEnd];
    }else{
        NSInteger start = self.playPosition;
        NSInteger end = self.playPosition + 256;
        if (end >= self.curPlayNewsContent.length) {
            end = self.curPlayNewsContent.length-1;
        }
        NSLog(@"start = %zd, end = %zd, length=%zd", start, end, self.curPlayNewsContent.length);
        
        NSString* text = [self.curPlayNewsContent substringWithRange:NSMakeRange(start, end-start)];
        
        self.playPosition += 256;
        [[BDTTSSynthesizer sharedInstance] speak:text];
    }
}

- (void)pauseSpeak{
    [[BDTTSSynthesizer sharedInstance] pause];
}

- (void)resumeSpeak{
    [[BDTTSSynthesizer sharedInstance] resume];
}

- (void)stopSpeak{
    [[BDTTSSynthesizer sharedInstance] cancel];
}

- (void)playEnd{
    if (self.delegate && [self.delegate respondsToSelector:@selector(newsPlayEnd)]) {
        [self.delegate performSelector:@selector(newsPlayEnd) withObject:nil];
    }
}


#pragma BDTTSSynthesizerDelegate

- (void)synthesizerSpeechDidPaused{
    
}

- (void)synthesizerSpeechDidResumed{
    
}

- (void)synthesizerSpeechDidFinished{
    [self play];
}

@end
