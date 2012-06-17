//
//  TableRow.h
//  diplom
//
//  Created by Mac on 17.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableRow : NSObject
@property (strong) NSString *exchangeName, *instrumentName;
@property double price, change;
@property bool up;
+(id)newTableRow:(NSString*)exchangeName:(NSString*)instrumentName:(double)price:(double)change:(bool)up;
@end
