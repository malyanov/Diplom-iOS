//
//  FileParser.m
//  diplom
//
//  Created by Mac on 26.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FileParser.h"

@implementation FileParser
@synthesize header;
@synthesize data;
+(id)newFileParser{
    FileParser* fp=[[FileParser alloc] init];
    [fp setData:[[NSMutableArray alloc] init]];
    [fp setHeader:nil];
    return fp;
}
-(double)stringToDouble:(NSString*) str{
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [f numberFromString:str];
    return [myNumber doubleValue];
}
-(NSMutableArray *)readFile{
    [data removeAllObjects];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@/data.txt", documentsDirectory];
    NSString *fileContents = [NSString stringWithContentsOfURL:[NSURL URLWithString:fileName] encoding:NSUTF8StringEncoding error:nil];
    NSArray *lines = [fileContents componentsSeparatedByString:@"\n"];
    NSArray *splited;
    NSMutableString *dateStr=[[NSMutableString alloc] initWithString:@""];
    double open=0, close=0, high=0, low=0;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyyMMddhhmmss"];
    NSDate *qdate;
    for (NSString *line in lines) {
        if(header==nil){
            NSString* l=[line substringWithRange:NSMakeRange(0, [line length]-1)];
            header=[l componentsSeparatedByString:@">,<"];
            continue;
        }
        splited=[line componentsSeparatedByString:@","];
        for(int i=0;i<header.count;i++){
            NSString* str=[splited objectAtIndex:i];
            if([header objectAtIndex:i]==@"OPEN") 
                open=[self stringToDouble:str];
            if([header objectAtIndex:i]==@"CLOSE") 
                close=[self stringToDouble:str];
            if([header objectAtIndex:i]==@"HIGH") 
                high=[self stringToDouble:str];
            if([header objectAtIndex:i]==@"LOW") 
                low=[self stringToDouble:str];
            if([header objectAtIndex:i]==@"DATE") 
                [dateStr appendString:str];
            if([header objectAtIndex:i]==@"TIME"){
                [dateStr appendString:str];                
                qdate=[df dateFromString:dateStr];
            }
        }
        Quotation *quot=[Quotation newQuotation:open:close:high:low];
        [quot setDateTime:qdate];
        [data addObject:quot];
    }    
    return data;
}
@end
