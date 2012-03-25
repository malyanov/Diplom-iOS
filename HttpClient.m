//
//  HttpClient.m
//  diplom
//
//  Created by Mac on 19.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HttpClient.h"

@implementation HttpClient
+(NSString*)sendHttpGet:(NSString*)urlSting{
    NSURL *url = [NSURL URLWithString:urlSting];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString * str = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    return  str;
}
+(void)sendHttpGetAsync:(NSString*)urlSting:(void(^)(NSString*))handler{
    NSURL *url = [NSURL URLWithString:urlSting];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        handler(str);
    }];    
}
+(int)downloadFromURL:(NSString*)urlStr:(NSString*)filename{
    NSLog(@"query: %@", urlStr);
    NSURL  *url = [NSURL URLWithString:urlStr];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    if(urlData){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, filename];
        [urlData writeToFile:filePath atomically:YES];
        return 1;
    }
    return 0;
}
@end
