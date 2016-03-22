//
//  SoundPlayer.h
//  KeyboardDemo
//  播放声音和振动的辅助类
//  Created by Baidu BP&IT 内网与预算组 高兴民 on 13-8-12.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface SoundPlayer : NSObject

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

//播号声音
+(void)playSound;

//拨号播放振动
+(void)playVibrate;

//同时播放声音和振动
+(void)playSoundAndVibrate;

@end
