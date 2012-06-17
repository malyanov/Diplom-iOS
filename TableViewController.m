//
//  TableViewController.m
//  diplom
//
//  Created by Mac on 17.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TableViewController.h"

@implementation TableViewController
@synthesize table;
@synthesize topBar;
@synthesize direction;
@synthesize value;
@synthesize exchangeImg;
@synthesize exchangeName;
@synthesize exchangeInstrument;
@synthesize change;
@synthesize back;
@synthesize bottomBar;

static NSMutableArray* rows;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad{
    [super viewDidLoad];
    self.back.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];    
    self.bottomBar.backgroundColor=[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bottombar.png"]];
    self.topBar.backgroundColor=[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"topbar.png"]];
    if(rows==nil)
        rows=[[NSMutableArray alloc] init];
    table.dataSource=self;
    table.delegate=self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(rows==nil)
        return 1;
    return rows.count+1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(rows!=nil){
        int index=[indexPath row];
        if(index==0)
            return [self.table dequeueReusableCellWithIdentifier:@"top_cell"];
        TableRow *row=[rows objectAtIndex:index-1];
        return [self createRow:row];
    }
    return nil;
}
-(UITableViewCell*)createRow:(TableRow*)row{
    UITableViewCell *cell=[self.table dequeueReusableCellWithIdentifier:@"exchange_cell"];
    UIView* v=[cell.subviews objectAtIndex:0];
    for (UIView *view in v.subviews) {
        if([view isKindOfClass:[UILabel class]]||[view isKindOfClass:[UIImageView class]]){
            switch (view.tag) {
                case 0:
                    ((UILabel*)view).text=row.exchangeName;
                    break;
                case 1:
                    ((UILabel*)view).text=row.instrumentName;
                    break;
                case 2:
                    ((UILabel*)view).text=[NSString stringWithFormat:@"%.2f", row.price];
                    break;
                case 3:
                    ((UILabel*)view).text=[NSString stringWithFormat:@"%.2f", row.change];
                    break;
                case 4:
                {
                    NSString* filename=@"down.png";
                    if(row.up)
                        filename=@"up.png";
                    ((UIImageView*)view).image=[UIImage imageNamed:filename];
                }
                    break;
                default:
                    break;
            }
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int index=[indexPath row];
    [rows removeObjectAtIndex:index];
    [table reloadData];
}
-(void)addRow:(int)exchangeId:(NSString*)instrumentCode{
    [rows addObject:[TableRow newTableRow:((exchangeId==0)?@"ММВБ":@"РТС"):instrumentCode:0:0:true]];
    [table reloadData];
}
- (void)viewDidUnload
{
    [self setTable:nil];
    [self setTopBar:nil];
    [self setDirection:nil];
    [self setValue:nil];
    [self setExchangeImg:nil];
    [self setExchangeName:nil];
    [self setExchangeInstrument:nil];
    [self setChange:nil];
    [self setBack:nil];
    [self setBottomBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
