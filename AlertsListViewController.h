//
//  AlertsListViewController.h
//  diplom
//
//  Created by Mac on 17.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertItem.h"

@interface AlertsListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
- (IBAction)clearTable:(id)sender;
-(void)addAlert:(double)value:(NSString*)code;
@end
