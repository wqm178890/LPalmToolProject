//
//  TQActionManger.m
//  LPalmNews
//
//  Created by 林述灿 on 15/9/8.
//  Copyright (c) 2015年 LSC. All rights reserved.
//

#import "TQActionManger.h"

@implementation TQActionManger

+ (TQActionManger *)sharedManger {
    
    static TQActionManger* kTQActionManger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kTQActionManger = [[TQActionManger alloc] init];
    });
    
    return kTQActionManger;
}

@end
