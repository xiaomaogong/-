//
//  DYArticle.m
//  订阅号助手
//
//  Created by 龚莎 on 1/20/15.
//  Copyright (c) 2015 GSClock. All rights reserved.
//

#import "DYArticle.h"


@implementation DYArticle

@dynamic title;
//@dynamic content;
//@dynamic url;
@dynamic addToFavor;

@synthesize selector,IsSuccess,url,content;

-(void)setArrcontent:(NSArray *)arrcontent{
    if (arrcontent != nil) {
        self.content = [NSKeyedArchiver archivedDataWithRootObject:arrcontent];
    }
}

-(NSArray*) arrcontent{
    return self.content != nil ? [NSKeyedUnarchiver unarchiveObjectWithData:self.content]: nil;
}

-(void)parse{
    
}

+(instancetype) initWithUpdateSelector: (blockParserCompleted)selector{
    DYArticle *dy = [DYArticle new];
    dy.selector =  selector;
    return dy;
}

- (NSString *)GetURL{
    return  self.url;
}

-(void)populateData:(BOOL)isSuccessfull data:(NSString *)data
{
    self.IsSuccess = isSuccessfull;
    self.arrcontent =[data componentsSeparatedByString:@"\n"];
    self.selector(self);
}

@end
