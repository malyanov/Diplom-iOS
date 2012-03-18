//
//  Settings.m
//  diplom
//
//  Created by Mac on 18.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Settings.h"

@implementation Settings
static Modes chartMode;
static QuotationType bidType;
+(QuotationType) getBidType{
    return bidType;
}
+(Modes) getChartMode{
    return chartMode;
}
@end
