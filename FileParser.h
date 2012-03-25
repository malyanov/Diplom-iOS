//
//  FileParser.h
//  diplom
//
//  Created by Mac on 26.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Quotation.h"

@interface FileParser : NSObject
@property (strong) NSMutableArray *data;
@property (strong) NSArray *header;
+newFileParser;
-(NSMutableArray*)readFile;
@end
