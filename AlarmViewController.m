//
//  AlarmViewController.m
//  diplom
//
//  Created by Mac on 26.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AlarmViewController.h"

@implementation AlarmViewController
@synthesize back;
@synthesize bottomBar;
@synthesize topBar;

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
    self.bottomBar.backgroundColor=[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bottombar.png"]];
    self.topBar.backgroundColor=[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"topbar.png"]];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setBack:nil];
    [self setBottomBar:nil];
    [self setTopBar:nil];
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