//
//  NewsLoader.h
//  diplom
//
//  Created by Mac on 16.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XPathQuery.h"
#import "News.h"

@interface NewsLoader : NSObject
+(NSMutableArray*)getNews;
@end
