//
//  News.m
//  diplom
//
//  Created by Mac on 16.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "News.h"

@implementation News
@synthesize  date, title, description, link;
+(id)newNews:(NSDate *)date :(NSString *)title :(NSString *)description :(NSString *)link{
    News *n=[[News alloc] init];
    n.date=date;
    n.title=title;
    n.description=description;
    n.link=[[NSString alloc] initWithFormat:@"http://rts.micex.ru%@",link];
    return n;
}
@end
