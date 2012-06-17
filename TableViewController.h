//
//  TableViewController.h
//  diplom
//
//  Created by Mac on 17.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableRow.h"
#import "SelectViewController.h"

@interface TableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIView *topBar;
@property (weak, nonatomic) IBOutlet UIImageView *direction;
@property (weak, nonatomic) IBOutlet UILabel *value;
@property (weak, nonatomic) IBOutlet UIImageView *exchangeImg;
@property (weak, nonatomic) IBOutlet UILabel *exchangeName;
@property (weak, nonatomic) IBOutlet UILabel *exchangeInstrument;
@property (weak, nonatomic) IBOutlet UILabel *change;
@property (weak, nonatomic) IBOutlet UIView *back;
@property (weak, nonatomic) IBOutlet UIView *bottomBar;
-(UITableViewCell*)createRow:(TableRow*)row;
-(void)addRow:(int)exchangeId:(NSString*)instrumentCode;
@end
