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
#define TimeOutSeconds 10
#define TimeInterval 1

@implementation DYIURLParser
{
    NSDate * lastParseTime;
    
    NSMutableArray* dataRequestlist;
    UIWebView* wv;
    NSThread* workThread;
    NSTimer* timer;
    
    id<DYURLParserDelegate> curentDataRequest;
    BOOL isCurrentDataBack;
}

+(DYIURLParser *) defaultInstance{
    static DYIURLParser* singleton;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate , ^
                  {
                      singleton = [DYIURLParser new];
                  });
    return singleton;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        dataRequestlist = [NSMutableArray new];
        wv = [UIWebView new];
        wv.delegate = self;
        workThread = [[NSThread alloc] initWithTarget:self selector:@selector(TryParseNext:) object:nil];
        workThread.name = @"Main Parser Thread";
        [workThread start];
        
        NSLog(@"Main Parser Thread Start...");
        
        timer = [NSTimer scheduledTimerWithTimeInterval:TimeInterval target:self selector:@selector(OnTimerRequest:) userInfo:nil repeats:YES];
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
    @synchronized(dataRequestlist){
        if(![dataRequestlist empty])
        {
            curentDataRequest = (id<DYURLParserDelegate>)[dataRequestlist dequeue];
            lastParseTime = [NSDate date];
            isCurrentDataBack = NO;
            [wv loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[curentDataRequest GetURL]]]];
//            if(timer == nil)
//            {
//                timer = [NSTimer scheduledTimerWithTimeInterval:TimeInterval target:self selector:@selector(OnTimerRequest:) userInfo:nil repeats:YES];
//                
//            }
            
            //Block until result is back
            while (!isCurrentDataBack) {
                
            }
            
        }
    }
}

-(void) OnTimerRequest:(NSTimer *)timer
{
    if(fabs([lastParseTime timeIntervalSinceNow]) > TimeOutSeconds && !isCurrentDataBack)
    {
        @synchronized(self){
            [self OnResult:@"Time out" isSuccessfull:NO];
            isCurrentDataBack = YES;
            
        }
    }
}

-(void) webViewDidFinishLoad:(UIWebView *)webView{
    @synchronized(self){
        NSLog(@"Successfully get result from %@",[curentDataRequest GetURL]);
        
        NSString * content = [webView stringByEvaluatingJavaScriptFromString:@"document.body.innerText.replace(/^\\s*[\\r\\n]/gm,'')"];
        [self OnResult:content isSuccessfull:YES];
        isCurrentDataBack = YES;
    }
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    @synchronized(self){
        NSString* errorInfo = [NSString stringWithFormat:@"Fail to get result %@", error.userInfo];
        [self OnResult: errorInfo isSuccessfull:NO];
        isCurrentDataBack = YES;
        NSLog(@"%@", errorInfo);
    }
}

-(void) Parse:(id<DYURLParserDelegate>) callBackDelegates{
    @synchronized(dataRequestlist)
    {
        [dataRequestlist enqueue:callBackDelegates];
    }
}

-(void) OnResult: (NSString *) result isSuccessfull:(BOOL) isSuccessfull
{
    [curentDataRequest populateData:isSuccessfull data:result];
}
@end
