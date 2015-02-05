//
//  DYPlayer.m
//  订阅号助手
//
//  Created by 龚莎 on 1/20/15.
//  Copyright (c) 2015 GSClock. All rights reserved.
//

#import "DYPlayer.h"
#import "DYSpeeker.h"
#import <AVFoundation/AVFoundation.h>

@implementation DYPlayer
{
    NSArray* currentArticle;
    int currentPlayingIndex;
    DYSpeeker* speeker;
}
@synthesize Delegate = notifier;

+(instancetype) initWithPlayerDelegate: (id<DYPlayerDelegate>) dyplayerDelegate{
    DYPlayer* player = [DYPlayer new];
    player.Delegate = dyplayerDelegate;
    return  player;
}

+(DYPlayer *) defaultInstance{
    static DYPlayer* singleton;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate , ^
                  {
                      singleton = [DYPlayer new];
                  });
    return singleton;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        speeker = [DYSpeeker new];
        [speeker setDelegate:speeker];
    }
    return self;
}

-(void) setCurrentData: (NSArray*) data{
    currentArticle = data;
}

-(void) play{
    [self play:currentPlayingIndex];
}

-(void) play:(int) index{
    
    if(currentArticle != nil && index <= [currentArticle count])
    {
        currentPlayingIndex = index;
        [speeker play:currentArticle[index]];
    }
}

-(void) stop{
    if(currentArticle != nil){
        [speeker stop];
    }
}

-(void) playNext{
    [self play:currentPlayingIndex +1];
}

-(void) playPrevious{
    [self play:currentPlayingIndex -1];
}

#pragma AVSpeechUtterance Delegate methods
-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance{
    [self play];
}
@end
