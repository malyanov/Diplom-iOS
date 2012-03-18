//
//  Settings.h
//  diplom
//
//  Created by Mac on 18.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Chart.h"
#import "Quotation.h"

@interface Settings : NSObject
+(QuotationType) getBidType;
+(Modes) getChartMode;
@end
