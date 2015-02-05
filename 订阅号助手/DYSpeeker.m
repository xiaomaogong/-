//
//  DYSpeeker.m
//  订阅号助手
//
//  Created by 龚莎 on 15/2/4.
//  Copyright (c) 2015年 GSClock. All rights reserved.
//

#import "DYSpeeker.h"
#import <AVFoundation/AVFoundation.h>

@implementation DYSpeeker
{
    AVSpeechSynthesisVoice *voice;
    AVSpeechSynthesizer *syther;
}

-(void)play:(NSString*)content{
    
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:content];
    utterance.voice = voice;
    utterance.rate = 0.3;
    [syther speakUtterance:utterance];
}

-(void)stop{
    [syther pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
//        voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CH"];
        voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"];
        syther =[AVSpeechSynthesizer new];
        AVSpeechUtterance *bugWorkaroundUtterance = [AVSpeechUtterance speechUtteranceWithString:@" "];
        bugWorkaroundUtterance.rate = AVSpeechUtteranceMaximumSpeechRate;
        [syther speakUtterance:bugWorkaroundUtterance];
    }
    return self;
}

-(void)setDelegate:(id) delegate{
    syther.delegate = delegate;
}
@end
