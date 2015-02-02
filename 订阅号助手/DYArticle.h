//
//  DYArticle.h
//  订阅号助手
//
//  Created by 龚莎 on 1/20/15.
//  Copyright (c) 2015 GSClock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "DYIURLParser.h"



@interface DYArticle : NSManagedObject<DYURLParserDelegate>

typedef void (^blockParserCompleted) (DYArticle*) ;

@property (nonatomic) BOOL isReaded;
@property (nonatomic) NSInteger identifier;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSData * content;
@property (nonatomic, retain) NSArray * arrcontent;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSNumber * addToFavor;
@property (nonatomic, copy) blockParserCompleted  selector;

+(instancetype) initWithUpdateSelector: (blockParserCompleted)selector;

@end


