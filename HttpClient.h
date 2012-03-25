//
//  HttpClient.h
//  diplom
//
//  Created by Mac on 19.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpClient : NSObject
+(NSString*)sendHttpGet:(NSString*)urlSting;
+(void)sendHttpGetAsync:(NSString*)urlSting:(void(^)(NSString*))handler;
+(int)downloadFromURL:(NSString*)urlStr:(NSString*)filename;
@end
