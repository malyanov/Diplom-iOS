//
//  ViewController.m
//  diplom
//
//  Created by Mac on 23.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "Chart.h"

@implementation MainViewController
@synthesize bottomBar = _bottomBar;
@synthesize topBar = _topBar;
@synthesize mainChart = _mainChart;
@synthesize back=_back;
@synthesize clock=_clock;
@synthesize timer=_timer;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];    
    self.back.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    [self.clock setText:[MainViewController getCurrentTimeStr]];
    self.timer=[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timerTask:) userInfo:nil repeats:YES];
    self.clock.backgroundColor=[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"time.png"]];
    self.bottomBar.backgroundColor=[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bottombar.png"]];
    self.topBar.backgroundColor=[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"topbar.png"]];
    Chart *chart=[[Chart alloc] initWithFrame:CGRectMake(0, 0, 320, 175)];
    [self.mainChart addSubview:chart];
}
-(void)timerTask:(NSTimer*) theTimer{    
    [self.clock setText:[MainViewController getCurrentTimeStr]];    
}
+(NSString*)getCurrentTimeStr{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setTimeStyle:NSDateFormatterShortStyle];
    [format setTimeZone:[NSTimeZone localTimeZone]];
    NSString *result=[format stringFromDate:[NSDate date]];
    return result;
}
- (void)viewDidUnload
{
    [self setBack:nil];
    [self setBottomBar:nil];
    [self setTopBar:nil];
    [self setMainChart:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
