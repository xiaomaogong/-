//
//  DYIURLParser.h
//  订阅号助手
//
//  Created by 龚莎 on 1/20/15.
//  Copyright (c) 2015 GSClock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DYURLParserDelegate <NSObject>
-(void)parse;
-(void)populateData:(BOOL) isSuccessfull data:(NSString *) data;
-(NSString *)GetURL;
@end

@interface DYIURLParser : NSObject<UIWebViewDelegate>
-(void) Parse:(id<DYURLParserDelegate>) callBackDelegates;
@end
