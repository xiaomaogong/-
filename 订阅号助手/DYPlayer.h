//
//  DYPlayer.h
//  订阅号助手
//
//  Created by 龚莎 on 1/20/15.
//  Copyright (c) 2015 GSClock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DYArticle.h"

@class DYPlayer;

@protocol DYPlayerDelegate <NSObject>

- (void) player:(DYPlayer*)player willPlayNextContent:(NSString*)content;

@end

@interface DYPlayer : NSObject

+(instancetype) initWithPlayerDelegate: (id<DYPlayerDelegate>) dyplayerDelegate;
-(void) setCurrentArticle: (DYArticle*) article;
-(void) play;
-(void) play:(int) index;
-(void) stop;
-(void) playNext;
-(void) playPrevious;
@end


