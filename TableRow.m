//
//  TableRow.m
//  diplom
//
//  Created by Mac on 17.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TableRow.h"

@implementation TableRow
@synthesize exchangeName, instrumentName, change, price, up;
+(id)newTableRow:(NSString *)exchangeName :(NSString *)instrumentName :(double)price :(double)change :(bool)up{
    TableRow *row=[[TableRow alloc] init];
    row.exchangeName=exchangeName;
    row.instrumentName=instrumentName;
    row.price=price;
    row.change=change;
    row.up=up;
    return row;
}
@end
