//
//  DYArticle.h
//  订阅号助手
//
//  Created by 龚莎 on 1/20/15.
//  Copyright (c) 2015 GSClock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DYArticle : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSData * content;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSNumber * addToFavor;

@end
