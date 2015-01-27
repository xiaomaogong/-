//
//  DYIURLParser.m
//  订阅号助手
//
//  Created by 龚莎 on 1/20/15.
//  Copyright (c) 2015 GSClock. All rights reserved.
//

#import "DYIURLParser.h"
#import "NSMutableArray+QueueAdditions.h"
#import <UIKit/UIKit.h>
#define TimeOutSeconds 30

@implementation DYIURLParser
{
    NSDate * lastParseTime;
    
    NSMutableArray* dataRequestlist;
    UIWebView* wv;
    NSThread* workThread;
    NSTimer* timer;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        dataRequestlist = [NSMutableArray new];
        wv = [UIWebView new];
        wv.delegate = self;
        workThread = [[NSThread alloc] initWithTarget:self selector:@selector(TryParseNext:) object:nil];
        [workThread start];
        
        NSLog(@"Main Parser Thread Start...");
    }
    return self;
}

-(void) TryParseNext:(id) obj
{
    while(true)
    {
        [self ParseNext];
    }
}

- (void) ParseNext
{
    if(![dataRequestlist empty])
    {
        id<DYURLParserDelegate> data = (id<DYURLParserDelegate>)[dataRequestlist peekHead];
        lastParseTime = [NSDate date];
        [wv loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[data GetURL]]]];
        if(time == nil)
        {
            timer = [NSTimer scheduledTimerWithTimeInterval:TimeOutSeconds target:self selector:@selector(OnTimerRequest:) userInfo:nil repeats:true];
        }
        
    }
}

-(void) OnTimerRequest:(NSTimer *)timer
{
    if([lastParseTime timeIntervalSinceNow] > TimeOutSeconds)
    {
        [self OnResult:@"Time out" isSuccessfull:false];
    }
}

-(void) webViewDidFinishLoad:(UIWebView *)webView{
    NSString * content = [webView stringByEvaluatingJavaScriptFromString:@"document.body.innerText.replace(/^\\s*[\\r\\n]/gm,'')"];
    [self OnResult:content isSuccessfull:YES];
}

-(void) Parse:(id<DYURLParserDelegate>) callBackDelegates{
    
}

-(void) OnResult: (NSString *) result isSuccessfull:(BOOL) isSuccessfull
{
    id<DYURLParserDelegate> request = (id<DYURLParserDelegate>)[dataRequestlist dequeue];
    [request populateData:isSuccessfull data:result];
}
@end
