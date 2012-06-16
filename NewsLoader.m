//
//  NewsLoader.m
//  diplom
//
//  Created by Mac on 16.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NewsLoader.h"

@implementation NewsLoader
static NSString* serverAddress=@"http://rts.micex.ru/export/news.aspx";
+(NSMutableArray*)getNews{    
    NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:serverAddress]];
    NSArray *titles = PerformXMLXPathQuery(data, @"//item/title"),
            *descriptions = PerformXMLXPathQuery(data, @"//item/description"),
            *dates = PerformXMLXPathQuery(data, @"//item/pubDate"),
            *guids = PerformXMLXPathQuery(data, @"//item/guid");
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss Z"];
    NSMutableArray *result=[[NSMutableArray alloc] init];
    for (int i=0; i<titles.count; i++) {
        NSString *title=[[titles objectAtIndex:i] objectForKey:@"nodeContent"],
                 *description=[[descriptions objectAtIndex:i] objectForKey:@"nodeContent"],
                 *dateStr=[[dates objectAtIndex:i] objectForKey:@"nodeContent"],
                 *guid=[[guids objectAtIndex:i] objectForKey:@"nodeContent"];
        [result addObject:[News newNews:[formatter dateFromString:dateStr]:title:description:guid]];
    }
    return result;
}
@end
