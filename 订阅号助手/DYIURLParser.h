//
//  DYIURLParser.h
//  订阅号助手
//
//  Created by 龚莎 on 1/20/15.
//  Copyright (c) 2015 GSClock. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DYURLParserDelegate <NSObject>
-(void)parse;
-(void)populateData;
@end

@interface DYIURLParser : NSObject
-(void) Parse:(NSString *) url;
@end
