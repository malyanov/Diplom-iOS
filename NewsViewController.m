//
//  NewsViewController.m
//  diplom
//
//  Created by Mac on 16.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NewsViewController.h"

@implementation NewsViewController
@synthesize newsList;
@synthesize refreshBtn;
@synthesize change;
@synthesize exchangeName;
@synthesize instrumentName;
@synthesize curValue;
@synthesize curDirection;
@synthesize exchangeImg;
@synthesize topBar;
@synthesize bottomBar;
@synthesize progress;
@synthesize back;

static NSMutableArray* news=nil;
static NSDateFormatter *format=nil;


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)viewDidLoad{
    [super viewDidLoad];
    self.back.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.bottomBar.backgroundColor=[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bottombar.png"]];
    self.topBar.backgroundColor=[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"topbar.png"]];    
    [self setInfo:[Settings getExchangeId]:[Settings getInstrumentCode]];
    if(format==nil){
        format=[[NSDateFormatter alloc] init];
        [format setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ru"]];
        [format setDateFormat:@"dd MMM  HH:mm"];
    }
    if(news==nil){
        [self showLoading];
        [self performSelectorInBackground:@selector(loadNews) withObject:nil];
    }
    [refreshBtn addTarget:self action:@selector(refreshClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)refreshClick{
    [self showLoading];
    [self performSelectorInBackground:@selector(loadNews) withObject:nil];
}
-(void)loadNews{
    news=[NewsLoader getNews];
    [newsList setDataSource:self];
    [newsList setDelegate:self];
    [newsList reloadData];
    [self hideLoading];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(news==nil)
        return 0;
    return news.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(news!=nil){
        News *n=[news objectAtIndex:[indexPath row]];
        UITableViewCell *cell=[self.newsList dequeueReusableCellWithIdentifier:@"news_row"];
        cell.textLabel.text=[format stringFromDate:n.date];
        cell.detailTextLabel.text=n.title;
        return cell;
    }
    return [self.newsList dequeueReusableCellWithIdentifier:@"news_row"];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(news!=nil){
        News *n=[news objectAtIndex:[indexPath row]];
        UIAlertView *infoPopup=[[UIAlertView alloc] initWithTitle:[format stringFromDate:n.date] message:n.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        infoPopup.alertViewStyle=UIAlertViewStyleDefault;
        UITextView *link=[[UITextView alloc] init];
        link.backgroundColor=[[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0];
        [link setText:n.link];
        [link setEditable:FALSE];
        [link setDataDetectorTypes:UIDataDetectorTypeLink];
        [infoPopup addSubview:link];
        [infoPopup show];
        link.font=[UIFont systemFontOfSize:14];
        link.frame=CGRectMake(10, infoPopup.bounds.size.height-85, 200, 30);
    }
}

- (void)viewDidUnload
{
    [self setNewsList:nil];
    [self setRefreshBtn:nil];
    [self setChange:nil];
    [self setExchangeName:nil];
    [self setInstrumentName:nil];
    [self setCurValue:nil];
    [self setCurDirection:nil];
    [self setExchangeImg:nil];
    [self setTopBar:nil];
    [self setBottomBar:nil];
    [self setBack:nil];
    [super viewDidUnload];    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)setInfo:(int)exchangeId:(NSString*)instr{
    instrumentName.text=instr;
    if(exchangeId==[Instrument getRTS]){
        exchangeName.text=@"RTS";
        exchangeImg.image=[UIImage imageNamed:@"rts.png"];        
    }
    else{
        exchangeName.text=@"MICEX";
        exchangeImg.image=[UIImage imageNamed:@"micex.png"];
    }
}
-(void)showLoading{ 
    progress = [[UIAlertView alloc] initWithTitle:@"Идет загрузка" message:@"Пожалуйства, подождите..." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [progress show];    
    if(progress != nil) {
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];        
        indicator.center = CGPointMake(progress.bounds.size.width/2, progress.bounds.size.height-45);
        [indicator startAnimating];
        [progress addSubview:indicator];
    }
}
-(void)hideLoading{
    [progress dismissWithClickedButtonIndex:0 animated:YES];
}

@end
