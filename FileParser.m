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
    NSLog(@"Read file path:%@", fileName);
    NSString *fileContents = [NSString stringWithContentsOfFile:fileName encoding:NSASCIIStringEncoding error:nil];
    NSArray *lines = [fileContents componentsSeparatedByString:@"\n"];
    NSArray *splited;
    NSMutableString *dateStr=[[NSMutableString alloc] initWithString:@""];
    double open=0, close=0, high=0, low=0;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *qdate;
    for (NSString *line in lines) {
        NSString* l=[line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];        
        if(header==nil){
            l=[l substringWithRange:NSMakeRange(1, [l length]-2)];
            header=[l componentsSeparatedByString:@">,<"];
            continue;
        }
        splited=[l componentsSeparatedByString:@","];
        if(splited.count==header.count){
            for(int i=0;i<header.count;i++){
                NSString* str=[splited objectAtIndex:i];                
                NSString* head=[header objectAtIndex:i];
                if([head isEqualToString:@"OPEN"]) 
                    open=[self stringToDouble:str];
                if([head isEqualToString:@"CLOSE"]) 
                    close=[self stringToDouble:str];
                if([head isEqualToString:@"HIGH"]) 
                    high=[self stringToDouble:str];
                if([head isEqualToString:@"LOW"]) 
                    low=[self stringToDouble:str];
                if([head isEqualToString:@"DATE"]) 
                    [dateStr appendString:str];
                if([head isEqualToString:@"TIME"]){
                    [dateStr appendString:str];                
                    qdate=[df dateFromString:dateStr];                    
                }
            }
        }
        dateStr=[[NSMutableString alloc] initWithString:@""];
        Quotation *quot=[Quotation newQuotation:open:close:high:low];
        [quot setDateTime:qdate];
        [data addObject:quot];
    }    
    return data;
}
@end
