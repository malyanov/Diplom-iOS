//
//  AlertsListViewController.m
//  diplom
//
//  Created by Mac on 17.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AlertsListViewController.h"

@implementation AlertsListViewController
@synthesize table;
static NSMutableArray* alerts=nil;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(alerts==nil)
        alerts=[[NSMutableArray alloc] init];
    table.dataSource=self;
    table.delegate=self;
}

- (void)viewDidUnload
{
    [self setTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)addAlert:(double)value:(NSString*)code{
    if(alerts==nil)
        alerts=[[NSMutableArray alloc] init];
    [alerts addObject:[AlertItem newAlertItem:value:code]];
    [table reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(alerts==nil)
        return 0;
    return alerts.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(alerts!=nil){
        AlertItem *alert=[alerts objectAtIndex:[indexPath row]];
        UITableViewCell *cell=[self.table dequeueReusableCellWithIdentifier:@"alert_row"];
        cell.textLabel.text=[NSString stringWithFormat:@"%.3f", alert.value];
        cell.detailTextLabel.text=alert.instrumentCode;
        return cell;
    }
    return [self.table dequeueReusableCellWithIdentifier:@"alert_row"];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int index=[indexPath row];
    [alerts removeObjectAtIndex:index];
    [table reloadData];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)clearTable:(id)sender {
    [alerts removeAllObjects];
    [table reloadData];
}
@end
